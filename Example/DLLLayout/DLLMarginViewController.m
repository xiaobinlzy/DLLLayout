//
//  DLLMarginViewController.m
//  DLLLayout
//
//  Created by DLL on 2017/7/28.
//  Copyright © 2017年 xiaobinlzy. All rights reserved.
//

#import "DLLMarginViewController.h"
#import <DLLLayout/DLLLayout.h>

@interface DLLMarginViewController ()

@end

@implementation DLLMarginViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"请横竖屏切换";
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"上下边距为50 左右边距100";
    [label dll_setLayout:^(DLLLayout *layout) {
        layout.centerX(0)
        .topMargin(00)
        .height(50);
    }];
    [self.view addSubview:label];
    
    UIView *exampleView = [[UIView alloc] init];
    exampleView.backgroundColor = [UIColor redColor];
    [exampleView dll_setLayout:^(DLLLayout *layout) {
        layout.margin(UIEdgeInsetsMake(50, 100, 50, 100));
    }];
    [self.view addSubview:exampleView];
    
    UILabel *innerLabel = [[UILabel alloc] init];
    innerLabel.text = @"上下边距50 左右边距20";
    innerLabel.numberOfLines = 0;
    innerLabel.textAlignment = NSTextAlignmentCenter;
    [innerLabel dll_setLayout:^(DLLLayout *layout) {
        layout.leftMargin(0)
        .rightMargin(0)
        .topMargin(0)
        .height(50);
    }];
    [exampleView addSubview:innerLabel];
    
    UIView *innerView = [[UILabel alloc] init];
    innerView.backgroundColor = [UIColor greenColor];
    [innerView dll_setLayout:^(DLLLayout *layout) {
        layout.margin(UIEdgeInsetsMake(50, 20, 50, 20));
    }];
    [exampleView addSubview:innerView];
}

@end
