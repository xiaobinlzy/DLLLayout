//
//  UIView+DLLLayout.m
//  Pods
//
//  Created by DLL on 2017/7/18.
//
//

#import <objc/runtime.h>
#import "DLLLayoutValue.h"
#import "DLLLayout+Private.h"
#import "UIView+DLLLayoutPrivate.h"

void dll_setupSubviewsHasNotLayout(NSArray *subviews) {
    for (UIView *view in subviews) {
        if (view.dll_layout.layoutValue.hasLayout) {
            view.dll_layout.layoutValue.hasLayout = NO;
            dll_setupSubviewsHasNotLayout(view.subviews);
        }
    }
}

void dll_resetViewFrame(UIView *view) {
    DLLLayoutValue *value = view.dll_layout.layoutValue;
    if (value.flag == 0 || value.hasLayout) {
        return;
    }
    
    DLLLayoutRelativeViews relativeViews = value.relativeViews;
    if (relativeViews.view1) {
        dll_resetViewFrame((__bridge UIView *)relativeViews.view1);
    }
    if (relativeViews.view2) {
        dll_resetViewFrame((__bridge UIView *)relativeViews.view2);
    }
    if (relativeViews.view3) {
        dll_resetViewFrame((__bridge UIView *)relativeViews.view3);
    }
    if (relativeViews.view4) {
        dll_resetViewFrame((__bridge UIView *)relativeViews.view4);
    }
    view.frame = [value frameForView:view];
    value.hasLayout = YES;
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
    method_exchangeImplementations(originMethod, targetMethod);
}

@implementation UIView (DLLLayout)

#pragma mark - layout swizzling
+ (void)load {
    dll_swizzleMethod(self, @selector(layoutSubviews), @selector(dll_layoutSubviews));
}


- (void)dll_layoutSubviews {
    NSArray *subviews = self.subviews;
    if (self.dll_layout.layoutValue.flag) {
        dll_removeViewConstraints(self);
    }
    dll_layoutSubviews(subviews);
    [self dll_layoutSubviews];
}


#pragma mark - dll layout
- (void)dll_setLayout:(void (^)(DLLLayout *))layout {
    NSAssert(layout, @"layout can not be nil.");
    DLLLayout *layoutObj = [self dll_getLayout];
    layoutObj.layoutValue.flag = 0;
    layout(layoutObj);
}

- (void)dll_updateLayout:(void (^)(DLLLayout *))layout {
    NSAssert(layout, @"layout can not be nil.");
    DLLLayout *layoutObj = [self dll_getLayout];
    layout(layoutObj);
}

- (DLLLayout *)dll_getLayout {
    DLLLayout *layout = [self dll_layout];
    if (layout == nil) {
        layout = [[DLLLayout alloc] init];
        objc_setAssociatedObject(self, @selector(dll_layout), layout, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return layout;
}


- (void)dll_updateFrame {
    self.dll_layout.layoutValue.hasLayout = NO;
    
    DLLLayoutValue *superValue = self.superview.dll_layout.layoutValue;
    if (superValue.flag) {
        DLLLayoutRelativeViews superRelativeViews = superValue.relativeViews;
        void *pView = (__bridge void *)self;
        if ((superRelativeViews.view1 == pView || superRelativeViews.view2 == pView || superRelativeViews.view3 == pView || superRelativeViews.view4 == pView) && superValue.hasLayout) {
            [self.superview dll_updateFrame];
            return;
        }
    }
    
    dll_resetViewFrame(self);
    [self setNeedsLayout];
    [self layoutIfNeeded];
}



#pragma mark - dll property
- (DLLLayoutRelative)dll_width {
    return (DLLLayoutRelative){(__bridge void *)self, DLLRelativeWidth};
}

- (DLLLayoutRelative)dll_height {
    return (DLLLayoutRelative){(__bridge void *)self, DLLRelativeHeight};
}

- (DLLLayoutRelative)dll_left {
    return (DLLLayoutRelative){(__bridge void *)self, DLLRelativeLeft};
}

- (DLLLayoutRelative)dll_right {
    return (DLLLayoutRelative){(__bridge void *)self, DLLRelativeRight};
}

- (DLLLayoutRelative)dll_top {
    return (DLLLayoutRelative){(__bridge void *)self, DLLRelativeTop};
}

- (DLLLayoutRelative)dll_bottom {
    return (DLLLayoutRelative){(__bridge void *)self, DLLRelativeBottom};
}

- (DLLLayoutRelative)dll_centerX {
    return (DLLLayoutRelative){(__bridge void *)self, DLLRelativeCenterX};
}

- (DLLLayoutRelative)dll_centerY {
    return (DLLLayoutRelative){(__bridge void *)self, DLLRelativeCenterY};
}

@end
