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
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    _label = [[DLLLabel alloc] init];
    _label.numberOfLines = 0;
    _label.text = kHelloWorld;
    [view addSubview:_label];
    
    UIView *innerView = [[UIView alloc] init];
    innerView.backgroundColor = [UIColor blueColor];
    [view addSubview:innerView];
    
    [view dll_setLayout:^(DLLLayout *layout) {
        layout.topMargin(50)
        .centerX(0)
        .leftMargin(20)
        .relative.height.withMulti(_label.dll_height, 2);
    }];
    
    [_label dll_setLayout:^(DLLLayout *layout) {
        layout.topMargin(0)
        .relative.left.to(innerView.dll_left);
    }];
    
    [innerView dll_setLayout:^(DLLLayout *layout) {
        layout.leftMargin(10)
        .relative.width.to(_label.dll_width)
        .relative.top.to(_label.dll_bottom)
        .bottomMargin(0);
    }];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"click me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button dll_setLayout:^(DLLLayout *layout) {
        layout.centerX(0)
        .bottomMargin(50);
    }];
}

- (void)clickButton:(id)sender {
    _label.text = [NSString stringWithFormat:@"%@\n%@", _label.text, kHelloWorld];
    [_label dll_updateFrame];
}




@end
