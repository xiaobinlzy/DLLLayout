//
//  DLLLayoutRelative.h
//  Pods
//
//  Created by DLL on 2017/8/3.
//
//

#import <Foundation/Foundation.h>

@interface DLLLayoutRelative : NSObject

/**
 数值偏移量。与regulation不同的是，offset是在multiple计算之后进行计算。
 */
@property (readonly, nonatomic) DLLLayoutRelative *(^offset)(CGFloat offset);

/**
 依赖的倍数
 */
@property (readonly, nonatomic) DLLLayoutRelative *(^multiple)(CGFloat multi);

/**
 数值偏移量。与offset不同的是，regulation是在multiple计算之前进行计算。
 */
@property (readonly, nonatomic) DLLLayoutRelative *(^regulation)(CGFloat value);

@end
