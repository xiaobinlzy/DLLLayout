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

/**
 给UIView设置布局规则，这个方法会清空之前设置的布局规则。

 @param layout 布局规则
 */
- (void)dll_setLayout:(void(^)(DLLLayout *layout))layout;

/**
 给UIView更新布局规则，这个方法不会清空之前的布局规则，而是在之前的基础上修改。

 @param layout 布局规则
 */
- (void)dll_updateLayout:(void(^)(DLLLayout *layout))layout;


/**
 当需要更新UIView.frame的时候调用这个方法，比如在UIViewAnimation中使用新的布局规则更新frame。
 */
- (void)dll_updateFrame;

/**
 移除一个或多个边的布局规则

 @param flag 要移除的边的Flag
 */
- (void)dll_removeLayoutFlag:(DLLLayoutFlag)flag;

/**
 移除所有边的布局规则
 */
- (void)dll_removeAllFlags;

/**
 依赖属性，依赖左边。
 */
@property (readonly, nonatomic) DLLLayoutRelative dll_left;

/**
 依赖属性，依赖右边。
 */
@property (readonly, nonatomic) DLLLayoutRelative dll_right;

/**
 依赖属性，依赖顶边。
 */
@property (readonly, nonatomic) DLLLayoutRelative dll_top;

/**
 依赖属性，依赖底边。
 */
@property (readonly, nonatomic) DLLLayoutRelative dll_bottom;

/**
 依赖属性，依赖宽度。
 */
@property (readonly, nonatomic) DLLLayoutRelative dll_width;

/**
 依赖属性，依赖高度。
 */
@property (readonly, nonatomic) DLLLayoutRelative dll_height;

/**
 依赖属性，依赖x轴中点。
 */
@property (readonly, nonatomic) DLLLayoutRelative dll_centerX;

/**
 依赖属性，依赖y轴中点。
 */
@property (readonly, nonatomic) DLLLayoutRelative dll_centerY;

@end
