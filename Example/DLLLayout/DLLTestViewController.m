//
//  DLLTestViewController.m
//  DLLLayout
//
//  Created by DLL on 2017/7/31.
//  Copyright © 2017年 xiaobinlzy. All rights reserved.
//

#import "DLLTestViewController.h"
#import <DLLLayout/DLLLayout.h>
#import "DLLLabel.h"

NSString *kHelloWorld = @"Hello world.";

@interface DLLTestViewController ()

@end

@implementation DLLTestViewController {
    UILabel *_label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView dll_setLayout:^(DLLLayout *layout) {
        layout.margin(UIEdgeInsetsZero);
    }];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    [scrollView addSubview:view];
    
    _label = [[UILabel alloc] init];
    _label.text = kHelloWorld;
    _label.numberOfLines = 0;
    [view addSubview:_label];
    
    UIView *innerView1 = [[UIView alloc] init];
    innerView1.backgroundColor = [UIColor greenColor];
    innerView1.tag = 1;
    [view addSubview:innerView1];
    UIView *innerView2 = [[UIView alloc] init];
    innerView2.backgroundColor = [UIColor blueColor];
    innerView2.tag = 2;
    [view addSubview:innerView2];
    
    [view dll_setLayout:^(DLLLayout *layout) {
        layout.centerX(0)
        .topMargin(50)
        .relative.width.with(_label.dll_width, 2, 20)
        .relative.height.with(_label.dll_height, 2, 20);
    }];
    
    [_label dll_setLayout:^(DLLLayout *layout) {
        layout.relative.left.to(innerView1.dll_left)
        .topMargin(10);
    }];
    
    [innerView1 dll_setLayout:^(DLLLayout *layout) {
        layout.leftMargin(10)
        .relative.width.to(innerView2.dll_width)
        .relative.top.to(_label.dll_bottom)
        .relative.height.to(_label.dll_height);
    }];
    
    [innerView2 dll_setLayout:^(DLLLayout *layout) {
        layout.relative.left.to(_label.dll_right)
        .relative.height.to(innerView1.dll_height)
        .relative.width.to(_label.dll_width)
        .centerY(0);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"click me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    [button dll_setLayout:^(DLLLayout *layout) {
        layout.centerX(0)
        .relative.top.withOffset(view.dll_bottom, 50);
    }];
    
    scrollView.contentSize = CGSizeMake(0, 1000);
}

- (void)clickButton:(id)sender {
    _label.text = [NSString stringWithFormat:@"%@\n%@", _label.text, kHelloWorld];
    [_label dll_updateFrame];
}




@end
