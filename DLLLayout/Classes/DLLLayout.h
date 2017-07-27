//
//  DLLLayout.h
//  Pods
//
//  Created by DLL on 2017/7/18.
//
//

#import <Foundation/Foundation.h>
#import "DLLLayoutDefine.h"
#import "UIView+DLLLayout.h"
#import "DLLLayoutRelativeMaker.h"


@class DLLLayout, DLLLayoutValue, DLLLayoutRelativeMaker;
typedef DLLLayout *(^DLLLayoutNumberValue)(CGFloat);


/**
 通过DLLLayout这个类来定义布局规则，也可以根据内容自动适应视图的宽度和高度。
 */
@interface DLLLayout : NSObject


/**
 设置宽度
 */
@property (nonatomic, readonly) DLLLayoutNumberValue width;

/**
 设置高度
 */
@property (nonatomic, readonly) DLLLayoutNumberValue height;

/**
 设置相对父视图的左边距
 */
@property (nonatomic, readonly) DLLLayoutNumberValue leftMargin;

/**
 设置相对父视图的右边距
 */
@property (nonatomic, readonly) DLLLayoutNumberValue rightMargin;

/**
 设置相对父视图的顶边距
 */
@property (nonatomic, readonly) DLLLayoutNumberValue topMargin;

/**
 设置相对父视图的底边距
 */
@property (nonatomic, readonly) DLLLayoutNumberValue bottomMargin;

/**
 设置相对父视图Y轴居中和偏移量
 */
@property (nonatomic, readonly) DLLLayoutNumberValue centerY;

/**
 设置相对父视图X轴居中和偏移量
 */
@property (nonatomic, readonly) DLLLayoutNumberValue centerX;


/**
 设置依赖关系，只能依赖父视图和同一层级子视图。
 */
@property (nonatomic, readonly) DLLLayoutRelativeMaker *relative;

@end


