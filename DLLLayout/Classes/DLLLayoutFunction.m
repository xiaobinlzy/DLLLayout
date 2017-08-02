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




void dll_resetViewFrame(UIView *view) {
    DLLLayout *value = view.dll_layout;
    if (view.superview.dll_layout == nil) {
        [value setNeedsLayout:YES];
    }
    
    if (value.flag == 0 || !value.needsLayout) {
        return;
    }
    
    [value axisFrameForAxis:DLLLayoutAxisX force:NO];
    [value axisFrameForAxis:DLLLayoutAxisY force:NO];
}




void dll_layoutSubviewsRecursively(UIView *view) {
    NSArray *subviews = view.subviews;
    for (UIView *view in subviews) {
        view.dll_layout.needsLayout = YES;
    }
    for (UIView *view in subviews) {
        dll_resetViewFrame(view);
        dll_layoutSubviewsRecursively(view);
    }
}


void dll_layoutSubviews(UIView *view) {
    NSArray *subviews = view.subviews;
    for (UIView *view in subviews) {
        view.dll_layout.needsLayout = YES;
    }
    for (UIView *view in subviews) {
        dll_resetViewFrame(view);
    }
}

void dll_removeViewConstraints(UIView *view) {
    view.autoresizingMask = UIViewAutoresizingNone;
    view.translatesAutoresizingMaskIntoConstraints = YES;
//    NSArray *subviews = view.subviews;
//    for (UIView *view in subviews) {
//        dll_removeViewConstraints(view);
//    }
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
