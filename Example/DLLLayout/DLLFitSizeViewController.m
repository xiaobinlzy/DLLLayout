//
//  DLLFitSizeViewController.m
//  DLLLayout
//
//  Created by DLL on 2017/9/15.
//  Copyright © 2017年 xiaobinlzy. All rights reserved.
//

#import "DLLFitSizeViewController.h"
#import <DLLLayout/DLLLayout.h>

@interface DLLFitSizeViewController ()

@end

@implementation DLLFitSizeViewController {
    UILabel *_label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:containerView];
    
    _label = [[UILabel alloc] init];
    _label.text = @"这是一个自适应Label";
    _label.numberOfLines = 0;
    [containerView addSubview:_label];
    
    UIView *relativeView = [[UIView alloc] init];
    relativeView.backgroundColor = [UIColor blueColor];
    [containerView addSubview:relativeView];
    
    [containerView dll_setLayout:^(DLLLayout *layout) {
        layout.centerX(0)
        .centerY(0)
        .relative.width.to(_label.dll_width.offset(20))
        .relative.height.to(relativeView.dll_bottom.offset(10));
    }];
    
    [_label dll_setLayout:^(DLLLayout *layout) {
        layout.topMargin(10)
        .centerX(0);
    }];
    
    [relativeView dll_setLayout:^(DLLLayout *layout) {
        layout.relative.top.to(_label.dll_bottom)
        .relative.width.to(_label.dll_width)
        .relative.height.to(_label.dll_height)
        .relative.centerX.to(_label.dll_centerX);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"增加文字" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button dll_setLayout:^(DLLLayout *layout) {
        layout.bottomMargin(20)
        .centerX(0);
    }];
}

- (void)clickButton:(id)sender {
    _label.text = [_label.text stringByAppendingString:@"\n这是一个自适应Label"];
    [_label dll_updateFrame];
}


@end
