//
//  DLLAffineTransformViewController.m
//  DLLLayout
//
//  Created by DLL on 2017/9/14.
//  Copyright © 2017年 xiaobinlzy. All rights reserved.
//

#import "DLLAffineTransformViewController.h"
#import <DLLLayout/DLLLayout.h>

@interface DLLAffineTransformViewController ()

@end

@implementation DLLAffineTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"垂直水平居中 宽高200";
    label.textAlignment = NSTextAlignmentCenter;
    [label dll_setLayout:^(DLLLayout *layout) {
        layout.topMargin(0)
        .height(50)
        .leftMargin(0)
        .rightMargin(0);
    }];
    [self.view addSubview:label];
    
    UIView *exampleView = [[UIView alloc] init];
    exampleView.backgroundColor = [UIColor redColor];
    [exampleView dll_setLayout:^(DLLLayout *layout) {
        layout.centerX(0)
        .centerY(0)
        .width(200)
        .height(200);
    }];
    [self.view addSubview:exampleView];
    
    UIView *innerView = [[UIView alloc] init];
    innerView.transform = CGAffineTransformMakeScale(0.5, 1);
    innerView.backgroundColor = [UIColor greenColor];
    [innerView dll_setLayout:^(DLLLayout *layout) {
        layout.width(100)
        .height(100)
        .centerX(0)
        .centerY(0);
    }];
    [exampleView addSubview:innerView];
    
    UILabel *innerLabel = [[UILabel alloc] init];
    innerLabel.text = @"居中 宽高100 宽度缩小0.5倍";
    innerLabel.textAlignment = NSTextAlignmentCenter;
    [innerLabel dll_setLayout:^(DLLLayout *layout) {
        layout.centerY(0)
        .centerX(0);
    }];
    [exampleView addSubview:innerLabel];
}


@end
