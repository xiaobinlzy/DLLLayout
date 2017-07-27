//
//  UIView+DLLLayoutPrivate.m
//  Pods
//
//  Created by DLL on 2017/7/19.
//
//

#import "UIView+DLLLayoutPrivate.h"
#import <objc/runtime.h>

@implementation UIView (DLLLayoutPrivate)

- (DLLLayout *)dll_layout {
    return objc_getAssociatedObject(self, @selector(dll_layout));
}

@end
