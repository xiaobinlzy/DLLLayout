//
//  DLLTestViewController.m
//  DLLLayout
//
//  Created by DLL on 2017/7/31.
//  Copyright © 2017年 xiaobinlzy. All rights reserved.
//

#import "DLLTestViewController.h"
#import <DLLLayout/DLLLayout.h>

NSString *kHelloWorld = @"Hello world.";

@interface DLLTestViewController ()

@end

@implementation DLLTestViewController {
    UILabel *_label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIView *outView = [[UIView alloc] init];
    outView.backgroundColor = [UIColor redColor];
    [self.view addSubview:outView];
    
    [outView dll_setLayout:^(DLLLayout *layout) {
        layout.height(100)
        .leftMargin(10)
        .rightMargin(10)
        .centerY(0);
    }];
    
    for (int i = 0; i < 4; i++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor greenColor];
        [outView addSubview:view];
        
        [view dll_setLayout:^(DLLLayout *layout) {
            layout.width(50)
            .height(50)
            .centerY(0)
            .relative.left.with(outView.dll_width, -200, (1.0 / 5) * ( i + 1), i * 50);
        }];
    }
    
}

- (void)clickButton:(id)sender {
    _label.text = [NSString stringWithFormat:@"%@\n%@", _label.text, kHelloWorld];
    [_label dll_updateFrame];
}




@end
