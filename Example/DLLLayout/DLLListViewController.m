//
//  DLLListViewController.m
//  DLLLayout
//
//  Created by DLL on 2017/7/31.
//  Copyright © 2017年 xiaobinlzy. All rights reserved.
//

#import "DLLListViewController.h"
#import <DLLLayout/DLLLayout.h>

NSString *kHelloWorld = @"Hello world.";

@interface DLLListViewController ()

@end

@implementation DLLListViewController {
    UILabel *_label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIView *outView = [[UIView alloc] init];
    outView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:outView];
    
    
    
    [outView dll_setLayout:^(DLLLayout *layout) {
        layout.margin(UIEdgeInsetsMake(20, 20, 20, 20));
    }];
    int count = 8;
    srand((unsigned)time(NULL));
    for (int i = 0; i < count; i++) {
        UIView *innerView = [[UIView alloc] init];
        innerView.backgroundColor = [UIColor colorWithRed:rand()/(double)RAND_MAX green:rand()/(double)RAND_MAX blue:rand()/(double)RAND_MAX alpha:1];
        innerView.tag = i + 1;
        [outView addSubview:innerView];
    }
    
    for (int i = 0; i < count; i++) {
        UIView *view = outView.subviews[i];
        
        [view dll_setLayout:^(DLLLayout *layout) {
            layout.relative.width.to(view.dll_height.multiple(2))
            .relative.height.to(outView.dll_height.regulation(-20).multiple(1.0 / count))
            .centerX(0);
            
            if (i == 0) {
                layout.topMargin(10);
            } else {
                UIView *prevView = outView.subviews[i - 1];
                layout.relative.top.to(prevView.dll_bottom);
            }
        }];
    }
}

- (void)clickButton:(id)sender {
    _label.text = [NSString stringWithFormat:@"%@\n%@", _label.text, kHelloWorld];
    [_label dll_updateFrame];
}




@end
