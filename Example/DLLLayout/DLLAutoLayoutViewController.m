//
//  DLLAutoLayoutViewController.m
//  DLLLayout
//
//  Created by DLL on 2017/9/14.
//  Copyright © 2017年 xiaobinlzy. All rights reserved.
//

#import "DLLAutoLayoutViewController.h"
#import <DLLLayout/DLLLayout.h>
#import <Masonry/Masonry.h>

@interface DLLAutoLayoutViewController ()

@end

@implementation DLLAutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIView *exampleView = [[UIView alloc] init];
    exampleView.backgroundColor = [UIColor redColor];
    /*
    [exampleView dll_setLayout:^(DLLLayout *layout) {
        layout.margin(UIEdgeInsetsMake(50, 100, 50, 100));
    }];
     */
    [self.view addSubview:exampleView];
    [exampleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@50);
        make.bottom.equalTo(@-50);
        make.left.equalTo(@100);
        make.right.equalTo(@-100);
    }];
    
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
    /*
    [innerView dll_setLayout:^(DLLLayout *layout) {
        layout.margin(UIEdgeInsetsMake(50, 20, 50, 20));
    }];
     */
    [exampleView addSubview:innerView];
    [innerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.top.equalTo(@50);
        make.bottom.equalTo(@-50);
    }];
}


@end
