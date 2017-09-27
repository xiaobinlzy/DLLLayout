//
//  DLLMultipleValueViewController.m
//  DLLLayout_Example
//
//  Created by DLL on 2017/9/27.
//  Copyright © 2017年 xiaobinlzy. All rights reserved.
//

#import "DLLMultipleValueViewController.h"
#import <DLLLayout/DLLLayout.h>

@interface DLLMultipleValueViewController ()

@end

@implementation DLLMultipleValueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:containerView];
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor redColor];
    topView.tag = 1;
    [containerView addSubview:topView];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor greenColor];
    bottomView.tag = 2;
    [containerView addSubview:bottomView];
    
    [containerView dll_setLayout:^(DLLLayout *layout) {
       layout.width(100)
        .height(200)
        .centerX(0)
        .centerY(0);
    }];
    [topView dll_setLayout:^(DLLLayout *layout) {
       layout.leftMargin(0)
        .rightMargin(0)
        .topMargin(0)
        .relative.bottom.to(bottomView.dll_top.offset(-10));
    }];
    [bottomView dll_setLayout:^(DLLLayout *layout) {
        layout.leftMargin(0)
        .rightMargin(0)
        .bottomMargin(0)
        .relative.height.to(topView.dll_height);
    }];
}

@end
