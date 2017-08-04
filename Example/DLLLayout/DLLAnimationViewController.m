//
//  DLLAnimationViewController.m
//  DLLLayout
//
//  Created by DLL on 2017/8/4.
//  Copyright © 2017年 xiaobinlzy. All rights reserved.
//

#import "DLLAnimationViewController.h"
#import <DLLLayout/DLLLayout.h>

@interface DLLAnimationViewController ()

@end

@implementation DLLAnimationViewController {
    UIView *_exampleView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _exampleView = [[UIView alloc] init];
    _exampleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_exampleView];
    
    [_exampleView dll_setLayout:^(DLLLayout *layout) {
        layout.width(100)
        .height(70)
        .centerX(0)
        .topMargin(100);
    }];
    
    UIView *pannel = [[UIView alloc] init];
    [self.view addSubview:pannel];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftButton setTitle:@"LEFT" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickLeft:) forControlEvents:UIControlEventTouchUpInside];
    [pannel addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightButton setTitle:@"RIGHT" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    [pannel addSubview:rightButton];
    
    UIButton *upButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [upButton setTitle:@"UP" forState:UIControlStateNormal];
    [upButton addTarget:self action:@selector(clickUp:) forControlEvents:UIControlEventTouchUpInside];
    [pannel addSubview:upButton];
    
    UIButton *downButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [downButton setTitle:@"DOWN" forState:UIControlStateNormal];
    [downButton addTarget:self action:@selector(clickDown:) forControlEvents:UIControlEventTouchUpInside];
    [pannel addSubview:downButton];
    
    [pannel dll_setLayout:^(DLLLayout *layout) {
        layout.centerX(0)
        .bottomMargin(50)
        .relative.width.to(rightButton.dll_right)
        .relative.height.to(downButton.dll_bottom);
    }];
    
    [leftButton dll_setLayout:^(DLLLayout *layout) {
        layout.width(100)
        .height(50)
        .leftMargin(0)
        .relative.top.to(upButton.dll_bottom);
    }];
    
    [rightButton dll_setLayout:^(DLLLayout *layout) {
        layout.width(100)
        .height(50)
        .relative.left.to(leftButton.dll_right)
        .relative.top.to(upButton.dll_bottom);
    }];
    
    [upButton dll_setLayout:^(DLLLayout *layout) {
        layout.width(100)
        .height(50)
        .centerX(0)
        .topMargin(0);
    }];
    
    [downButton dll_setLayout:^(DLLLayout *layout) {
        layout.width(100)
        .height(50)
        .centerX(0)
        .relative.top.to(leftButton.dll_bottom);
    }];
}

- (void)clickLeft:(id)sender {
    [UIView animateWithDuration:0.25 animations:^{
        [_exampleView dll_removeLayoutFlag:DLLLayoutFlagCenterX];
        [_exampleView dll_updateLayout:^(DLLLayout *layout) {
            layout.leftMargin(_exampleView.frame.origin.x - 10);
        }];
        [_exampleView dll_updateFrame];
    }];
}

- (void)clickRight:(id)sender {
    [UIView animateWithDuration:0.25 animations:^{
        [_exampleView dll_removeLayoutFlag:DLLLayoutFlagCenterX];
        [_exampleView dll_updateLayout:^(DLLLayout *layout) {
            layout.leftMargin(_exampleView.frame.origin.x + 10);
        }];
        [_exampleView dll_updateFrame];
    }];

}

- (void)clickUp:(id)sender {
    [UIView animateWithDuration:0.25 animations:^{
        [_exampleView dll_removeLayoutFlag:DLLLayoutFlagCenterY];
        [_exampleView dll_updateLayout:^(DLLLayout *layout) {
            layout.topMargin(_exampleView.frame.origin.y - 10);
        }];
        [_exampleView dll_updateFrame];
    }];
}

- (void)clickDown:(id)sender {
    [UIView animateWithDuration:0.25 animations:^{
        [_exampleView dll_removeLayoutFlag:DLLLayoutFlagCenterY];
        [_exampleView dll_updateLayout:^(DLLLayout *layout) {
            layout.topMargin(_exampleView.frame.origin.y + 10);
        }];
        [_exampleView dll_updateFrame];
    }];

}

@end
