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
#import "DLLLayoutRelative+Private.h"


@implementation UIView (DLLLayout)

#pragma mark - layout swizzling
+ (void)load {
    dll_swizzleMethod(self, @selector(layoutSubviews), @selector(dll_layoutSwizzleLayoutSubviews));
}

+ (void)initialize {
    dll_swizzleMethod(self, @selector(invalidateIntrinsicContentSize), @selector(dll_layoutSwizzleInvalidateIntrinsicContentSize));
}


- (void)dll_layoutSwizzleLayoutSubviews {
    [self dll_layoutSubviews];
    [self dll_layoutSwizzleLayoutSubviews];
}

- (void)dll_layoutSwizzleInvalidateIntrinsicContentSize {
    [self dll_layoutSwizzleInvalidateIntrinsicContentSize];
    [self.dll_layout setNeedsUpdateContentSize];
}

- (void)dll_dealloc {
    // TODO
}

#pragma mark - dll layout
- (void)dll_layoutSubviews {
    DLLLayout *layoug = self.dll_layout;
    if (layoug.flag) {
        dll_removeViewConstraints(self);
    }
    NSArray *subviews = self.subviews;

    
    for (UIView *view in subviews) {
        dll_resetViewFrame(view);
    }
}

- (DLLLayout *)dll_layout {
    return objc_getAssociatedObject(self, @selector(dll_layout));
}

- (DLLLayoutFlag)dll_setLayout:(void (^)(DLLLayout *))layout {
    NSAssert(layout, @"layout can not be nil.");
    DLLLayout *layoutObj = [self dll_getLayout];
    layoutObj.flag = 0;
    layout(layoutObj);
    layoutObj.needsLayout = YES;
    return layoutObj.flag;
}

- (DLLLayoutFlag)dll_updateLayout:(void (^)(DLLLayout *))layout {
    NSAssert(layout, @"layout can not be nil.");
    DLLLayout *layoutObj = [self dll_getLayout];
    layout(layoutObj);
    layoutObj.needsLayout = YES;
    return layoutObj.flag;
}

- (DLLLayout *)dll_getLayout {
    DLLLayout *layout = self.dll_layout;
    if (layout == nil) {
        layout = [[DLLLayout alloc] init];
        layout.view = self;
        objc_setAssociatedObject(self, @selector(dll_layout), layout, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return layout;
}


- (void)dll_updateFrame {
    self.dll_layout.needsLayout = YES;
    DLLLayout *superValue = self.superview.dll_layout;
    if (superValue.flag) {
        DLLLayoutRelativeViews superRelativeViewsX = superValue.relativeViewsX;
        DLLLayoutRelativeViews superRelativeViewsY = superValue.relativeViewsY;
        void *pView = (__bridge void *)self;
        if ((superRelativeViewsX.view1 == pView || superRelativeViewsX.view2 == pView || superRelativeViewsY.view1 == pView || superRelativeViewsY.view2 == pView) || superValue.needsLayout) {
            [self.superview dll_updateFrame];
            return;
        }
    }
    dll_layoutSubviewsRecursively(self.superview);
}


- (void)dll_removeAllFlags {
    self.dll_layout.flag = 0;
}

- (DLLLayoutFlag)dll_removeLayoutFlag:(DLLLayoutFlag)flag {
    DLLLayout *layout = self.dll_layout;
    layout.flag &= ~flag;
    return layout.flag;
}


#pragma mark - dll property
- (DLLLayoutRelative *)dll_width {
    DLLLayoutRelative *relative = [[DLLLayoutRelative alloc] init];
    relative.view = self;
    relative.type = DLLRelativeWidth;
    return relative;
}

- (DLLLayoutRelative *)dll_height {
    DLLLayoutRelative *relative = [[DLLLayoutRelative alloc] init];
    relative.view = self;
    relative.type = DLLRelativeHeight;
    return relative;
}

- (DLLLayoutRelative *)dll_left {
    DLLLayoutRelative *relative = [[DLLLayoutRelative alloc] init];
    relative.view = self;
    relative.type = DLLRelativeLeft;
    return relative;
}

- (DLLLayoutRelative *)dll_right {
    DLLLayoutRelative *relative = [[DLLLayoutRelative alloc] init];
    relative.view = self;
    relative.type = DLLRelativeRight;
    return relative;
}

- (DLLLayoutRelative *)dll_top {
    DLLLayoutRelative *relative = [[DLLLayoutRelative alloc] init];
    relative.view = self;
    relative.type = DLLRelativeTop;
    return relative;
}

- (DLLLayoutRelative *)dll_bottom {
    DLLLayoutRelative *relative = [[DLLLayoutRelative alloc] init];
    relative.view = self;
    relative.type = DLLRelativeBottom;
    return relative;
}

- (DLLLayoutRelative *)dll_centerX {
    DLLLayoutRelative *relative = [[DLLLayoutRelative alloc] init];
    relative.view = self;
    relative.type = DLLRelativeCenterX;
    return relative;
}

- (DLLLayoutRelative *)dll_centerY {
    DLLLayoutRelative *relative = [[DLLLayoutRelative alloc] init];
    relative.view = self;
    
    relative.type = DLLRelativeCenterY;
    return relative;
}

@end


