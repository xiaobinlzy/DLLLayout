//
//  UIScrollView+DLLLayout.h
//  Pods
//
//  Created by DLL on 2017/8/1.
//
//

#import <UIKit/UIKit.h>
#import "UIView+DLLLayout.h"

@interface UIScrollView (DLLLayout)

- (DLLLayoutFlag)dll_setContentLayout:(void(^)(DLLLayout *layout))layout;

@end
