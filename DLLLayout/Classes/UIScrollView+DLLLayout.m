//
//  UIScrollView+DLLLayout.m
//  Pods
//
//  Created by DLL on 2017/8/1.
//
//

#import "UIScrollView+DLLLayoutPrivate.h"
#import "UIView+DLLLayoutPrivate.h"
#import <objc/runtime.h>
#import "DLLLayoutFunction.h"
#import "DLLLayout+Private.h"

@implementation UIScrollView (DLLLayout)


- (DLLLayout *)dll_getContentLayout {
    DLLLayout *layout = [self dll_contentLayout];
    if (layout == nil) {
        layout = [[DLLLayout alloc] init];
        layout.view = self;
        objc_setAssociatedObject(self, @selector(dll_contentLayout), layout, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return layout;
}

- (DLLLayoutFlag)dll_setContentLayout:(void (^)(DLLLayout *))layout {
    DLLLayout *layoutObj = self.dll_contentLayout;
    layout(layoutObj);
    return layoutObj.flag;
}



@end
