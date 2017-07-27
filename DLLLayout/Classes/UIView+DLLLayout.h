//
//  UIView+DLLLayout.h
//  Pods
//
//  Created by DLL on 2017/7/19.
//
//
#import <UIKit/UIKit.h>
#import "DLLLayoutDefine.h"

@class DLLLayout;

@interface UIView (DLLLayout)

- (void)dll_setLayout:(void(^)(DLLLayout *layout))layout;

- (void)dll_updateLayout:(void(^)(DLLLayout *layout))layout;

- (void)dll_updateFrame;


@property (readonly, nonatomic) DLLLayoutRelative dll_left;

@property (readonly, nonatomic) DLLLayoutRelative dll_right;

@property (readonly, nonatomic) DLLLayoutRelative dll_top;

@property (readonly, nonatomic) DLLLayoutRelative dll_bottom;

@property (readonly, nonatomic) DLLLayoutRelative dll_width;

@property (readonly, nonatomic) DLLLayoutRelative dll_height;

@property (readonly, nonatomic) DLLLayoutRelative dll_centerX;

@property (readonly, nonatomic) DLLLayoutRelative dll_centerY;

@end
