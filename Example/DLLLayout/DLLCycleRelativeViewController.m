//
//  DLLCycleRelativeViewController.m
//  DLLLayout
//
//  Created by DLL on 2017/8/3.
//  Copyright © 2017年 xiaobinlzy. All rights reserved.
//

#import "DLLCycleRelativeViewController.h"
#import <DLLLayout/DLLLayout.h>

@interface DLLCycleRelativeViewController ()

@end

@implementation DLLCycleRelativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *outer = [[UIView alloc] init];
    outer.backgroundColor = [UIColor blackColor];
    outer.tag = -1;
    [self.view addSubview:outer];
    
    UIView *inner1 = [[UIView alloc] init];
    inner1.backgroundColor = [UIColor redColor];
    inner1.tag = 1;
    [outer addSubview:inner1];
    
    UIView *inner2 = [[UIView alloc] init];
    inner2.backgroundColor = [UIColor yellowColor];
    inner2.tag = 2;
    [outer addSubview:inner2];
    
    UIView *inner3 = [[UIView alloc] init];
    inner3.backgroundColor = [UIColor blueColor];
    inner3.tag = 3;
    [outer addSubview:inner3];
    
    UIView *inner4 = [[UIView alloc] init];
    inner4.backgroundColor = [UIColor whiteColor];
    inner4.tag = 4;
    [outer addSubview:inner4];
    
    [outer dll_setLayout:^(DLLLayout *layout) {
        layout.centerX(0)
        .centerY(0)
        .relative.width.to(inner3.dll_right.offset(10))
        .relative.height.to(inner4.dll_bottom.offset(10));
    }];
    
    [inner1 dll_setLayout:^(DLLLayout *layout) {
        layout.relative.left.to(inner2.dll_left)
        .relative.width.to(inner3.dll_width)
        .topMargin(10)
        .height(50);
    }];
    
    [inner2 dll_setLayout:^(DLLLayout *layout) {
        layout.leftMargin(10)
        .relative.width.to(inner3.dll_width)
        .relative.top.to(inner1.dll_bottom)
        .relative.height.to(inner3.dll_height);
    }];
    
    [inner3 dll_setLayout:^(DLLLayout *layout) {
        layout.relative.left.to(inner1.dll_right)
        .relative.width.to(inner2.dll_left.multiple(10))
        .relative.centerY.to(inner2.dll_top)
        .relative.height.to(inner1.dll_height);
    }];
    
    [inner4 dll_setLayout:^(DLLLayout *layout) {
        layout.relative.centerX.to(inner3.dll_centerX)
        .relative.top.to(inner3.dll_bottom)
        .relative.width.to(inner1.dll_width.multiple(0.5))
        .relative.height.to(inner2.dll_height);
    }];
}



@end
