//
//  DLLViewController.m
//  DLLLayout
//
//  Created by xiaobinlzy on 07/18/2017.
//  Copyright (c) 2017 xiaobinlzy. All rights reserved.
//


#import "DLLViewController.h"
#import <DLLLayout/DLLLayout.h>


@interface DLLViewController ()

@end

@implementation DLLViewController {
    UIView *_containerView;
    UILabel *_innerLabel;
    UILabel *_label;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor redColor];
    _containerView.tag = 1;
    [self.view addSubview:_containerView];
    
    
    _innerLabel = [[UILabel alloc] init];
    _innerLabel.text = @"Hello world";
    _innerLabel.numberOfLines = 0;
    _innerLabel.backgroundColor = [UIColor whiteColor];
    _innerLabel.tag = 2;
    [_containerView addSubview:_innerLabel];
    
    UIView *innerView = [[UIView alloc] init];
    innerView.backgroundColor = [UIColor yellowColor];
    [_containerView addSubview:innerView];
    
    _label = [[UILabel alloc] init];
    _label.font = [UIFont systemFontOfSize:15];
    _label.text = @"翩若惊鸿，婉若游龙。荣曜秋菊，华茂春松。仿佛兮若轻云之蔽月，飘摇兮若流风之回雪。远而望之，皎若太阳升朝霞；迫而察之，灼若芙蕖出渌波。秾纤得衷，修短合度。肩若削成，腰如约素。延颈秀项，皓质呈露。芳泽无加，铅华弗御。云髻峨峨，修眉联娟。丹唇外朗，皓齿内鲜，明眸善睐，靥辅承权。瑰姿艳逸，仪静体闲。柔情绰态，媚于语言。奇服旷世，骨像应图。披罗衣之璀粲兮，珥瑶碧之华琚。戴金翠之首饰，缀明珠以耀躯。践远游之文履，曳雾绡之轻裾。微幽兰之芳蔼兮，步踟蹰于山隅。";
    _label.numberOfLines = 0;
    _label.textColor = [UIColor blackColor];
    [self.view addSubview:_label];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"click me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [_containerView dll_setLayout:^(DLLLayout *layout) {
        layout.width(300)
        .centerX(0)
        .topMargin(20)
        .relative.height.withOffset(_innerLabel.dll_height, 20);
    }];
    [_innerLabel dll_setLayout:^(DLLLayout *layout) {
        layout.centerY(0)
        .leftMargin(20);
    }];
    [innerView dll_setLayout:^(DLLLayout *layout) {
        layout.relative.centerY.to(_innerLabel.dll_centerY)
        .relative.left.withOffset(_innerLabel.dll_right, 10)
        .rightMargin(10)
        .relative.height.to(_innerLabel.dll_height);
    }];
    [_label dll_setLayout:^(DLLLayout *layout) {
        layout.topMargin(200)
        .leftMargin(20)
        .rightMargin(20);
    }];
    [button dll_setLayout:^(DLLLayout *layout) {
        layout.width(100)
        .height(50)
        .centerX(0)
        .bottomMargin(50);
    }];
}

- (void)clickButton:(id)sender {
    _innerLabel.text = @"button has been clicked.\nbutton has been clicked.\nbutton has been clicked.";
    [UIView animateWithDuration:0.25 animations:^{
        [_innerLabel dll_updateFrame];
    }];
}


@end
