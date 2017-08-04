//
//  UIView+DLLLayoutPrivate.h
//  Pods
//
//  Created by DLL on 2017/7/19.
//
//

#import <UIKit/UIKit.h>
#import "DLLLayout+Private.h"

@interface UIView (DLLLayoutPrivate)

@property (readonly, nonatomic) DLLLayout *dll_layout;


- (void)dll_layoutSubviews;

@end
