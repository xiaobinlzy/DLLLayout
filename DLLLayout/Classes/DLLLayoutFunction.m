//
//  DLLLayoutFunction.m
//  Pods
//
//  Created by DLL on 2017/7/31.
//
//

#import "DLLLayoutFunction.h"
#import "UIView+DLLLayoutPrivate.h"
#import <objc/runtime.h>

void dll_setupSubviewsHasNotLayout(NSArray *subviews) {
    for (UIView *view in subviews) {
        if (view.dll_layout.hasLayout) {
            view.dll_layout.hasLayout = NO;
            dll_setupSubviewsHasNotLayout(view.subviews);
        }
    }
}




void dll_resetViewFrame(UIView *view) {
    DLLLayout *value = view.dll_layout;
    if (value.flag == 0 || value.hasLayout) {
        return;
    }
    
    [value axisFrameForAxis:DLLLayoutAxisX];
    [value axisFrameForAxis:DLLLayoutAxisY];
}




void dll_layoutSubviewsRecursively(NSArray *subviews) {
    dll_setupSubviewsHasNotLayout(subviews);
    for (UIView *view in subviews) {
        dll_resetViewFrame(view);
        dll_layoutSubviewsRecursively(view.subviews);
    }
}


void dll_layoutSubviews(NSArray *subviews) {
    dll_setupSubviewsHasNotLayout(subviews);
    for (UIView *view in subviews) {
        dll_resetViewFrame(view);
    }
}

void dll_removeViewConstraints(UIView *view) {
    view.autoresizingMask = UIViewAutoresizingNone;
    view.translatesAutoresizingMaskIntoConstraints = YES;
    NSArray *subviews = view.subviews;
    for (UIView *view in subviews) {
        dll_removeViewConstraints(view);
    }
}

void dll_swizzleMethod(Class class, SEL origin, SEL target) {
    Method originMethod = class_getInstanceMethod(class, origin);
    Method targetMethod = class_getInstanceMethod(class, target);
    if (class_addMethod(class, target, method_getImplementation(targetMethod), method_getTypeEncoding(targetMethod))) {
        IMP superOriginIMP = class_getMethodImplementation(class_getSuperclass(class), origin);
        if (!class_addMethod(class, origin, superOriginIMP, method_getTypeEncoding(originMethod))) {
            method_setImplementation(originMethod, superOriginIMP);
        }
    } else {
        
        if (class_addMethod(class, origin, method_getImplementation(targetMethod), method_getTypeEncoding(targetMethod))) {
            class_replaceMethod(class, target, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        } else {
            method_exchangeImplementations(originMethod, targetMethod);
        }
    }
}
