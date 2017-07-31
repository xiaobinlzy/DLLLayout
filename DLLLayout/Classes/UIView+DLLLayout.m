//
//  UIView+DLLLayout.m
//  Pods
//
//  Created by DLL on 2017/7/18.
//
//

#import <objc/runtime.h>
#import "DLLLayout+Private.h"
#import "UIView+DLLLayoutPrivate.h"
#import "DLLLayoutFunction.h"


@implementation UIView (DLLLayout)

#pragma mark - layout swizzling
+ (void)load {
    dll_swizzleMethod(self, @selector(layoutSubviews), @selector(dll_layoutSubviews));
}

+ (void)initialize {
    dll_swizzleMethod(self, @selector(invalidateIntrinsicContentSize), @selector(dll_invalidateIntrinsicContentSize));
}

- (void)dll_layoutSubviews {
    NSArray *subviews = self.subviews;
    if (self.dll_layout.flag) {
        dll_removeViewConstraints(self);
    }
    dll_layoutSubviews(subviews);
    [self dll_layoutSubviews];
}

- (void)dll_invalidateIntrinsicContentSize {
    [self dll_invalidateIntrinsicContentSize];
    [self.dll_layout setNeedsUpdateContentSize];
}

#pragma mark - dll layout

- (DLLLayout *)dll_layout {
    return objc_getAssociatedObject(self, @selector(dll_layout));
}

- (void)dll_setLayout:(void (^)(DLLLayout *))layout {
    NSAssert(layout, @"layout can not be nil.");
    DLLLayout *layoutObj = [self dll_getLayout];
    layoutObj.flag = 0;
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
        layout.view = self;
        objc_setAssociatedObject(self, @selector(dll_layout), layout, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return layout;
}


- (void)dll_updateFrame {
    self.dll_layout.hasLayout = NO;
    DLLLayout *superValue = self.superview.dll_layout;
    if (superValue.flag) {
        DLLLayoutRelativeViews superRelativeViewsX = superValue.relativeViewsX;
        DLLLayoutRelativeViews superRelativeViewsY = superValue.relativeViewsY;
        void *pView = (__bridge void *)self;
        if ((superRelativeViewsX.view1 == pView || superRelativeViewsX.view2 == pView || superRelativeViewsY.view1 == pView || superRelativeViewsY.view2 == pView) && superValue.hasLayout) {
            [self.superview dll_updateFrame];
            return;
        }
    }
    dll_resetViewFrame(self);
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


- (void)dll_removeAllFlags {
    self.dll_layout.flag = 0;
}

- (void)dll_removeLayoutFlag:(DLLLayoutFlag)flag {
    self.dll_layout.flag &= ~flag;
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


