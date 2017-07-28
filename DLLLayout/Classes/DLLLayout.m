//
//  DLLLayout.m
//  Pods
//
//  Created by DLL on 2017/7/18.
//
//

#import "DLLLayout.h"
#import "DLLLayout+Private.h"
#import "DLLLayoutRelativeMaker+Private.h"






@interface DLLLayout ()
@end


@implementation DLLLayout {
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _layoutValue = [[DLLLayoutValue alloc] init];
        _relative = [[DLLLayoutRelativeMaker alloc] init];
        _relative.bridge.layout = self;
        
        typeof(self) __weak weakSelf = self;
        DLLLayoutValue * __weak value = self.layoutValue;
        _width = ^DLLLayout *(CGFloat width) {
            value.flag |= DLLLayoutFlagWidth;
            DLLLayoutRuleGroup rules = value.xRules;
            rules.value.type = DLLLayoutRuleTypeValue;
            rules.value.value = width;
            value.xRules = rules;
            return weakSelf;
        };
        
        _height = ^DLLLayout *(CGFloat height) {
            value.flag |= DLLLayoutFlagHeight;
            DLLLayoutRuleGroup rules = value.yRules;
            rules.value.type = DLLLayoutRuleTypeValue;
            rules.value.value = height;
            value.yRules = rules;
            return weakSelf;
        };
        
        _leftMargin = ^DLLLayout *(CGFloat leftMargin) {
            value.flag |= DLLLayoutFlagLeftMargin;
            DLLLayoutRuleGroup rules = value.xRules;
            rules.head.type = DLLLayoutRuleTypeValue;
            rules.head.value = leftMargin;
            value.xRules = rules;
            return weakSelf;
        };
        
        _rightMargin = ^DLLLayout *(CGFloat rightMargin) {
            value.flag |= DLLLayoutFlagRightMargin;
            DLLLayoutRuleGroup rules = value.xRules;
            rules.tail.type = DLLLayoutRuleTypeValue;
            rules.tail.value = rightMargin;
            value.xRules = rules;
            return weakSelf;
        };
        
        _topMargin = ^DLLLayout *(CGFloat topMargin) {
            value.flag |= DLLLayoutFlagTopMargin;
            DLLLayoutRuleGroup rules = value.yRules;
            rules.head.type = DLLLayoutRuleTypeValue;
            rules.head.value = topMargin;
            value.yRules = rules;
            return weakSelf;
        };
        
        _bottomMargin = ^DLLLayout *(CGFloat bottomMargin) {
            value.flag |= DLLLayoutFlagBottomMargin;
            DLLLayoutRuleGroup rules = value.yRules;
            rules.tail.type = DLLLayoutRuleTypeValue;
            rules.tail.value = bottomMargin;
            value.yRules = rules;
            return weakSelf;
        };
        
        _centerX = ^DLLLayout *(CGFloat centerX) {
            value.flag |= DLLLayoutFlagCenterX;
            DLLLayoutRuleGroup rules = value.xRules;
            rules.center.type = DLLLayoutRuleTypeValue;
            rules.center.value = centerX;
            value.xRules = rules;
            return weakSelf;
        };
        
        _centerY = ^DLLLayout *(CGFloat centerY) {
            value.flag |= DLLLayoutFlagCenterY;
            DLLLayoutRuleGroup rules = value.yRules;
            rules.center.type = DLLLayoutRuleTypeValue;
            rules.center.value = centerY;
            value.yRules = rules;
            return weakSelf;
        };
        
        _margin = ^DLLLayout *(UIEdgeInsets edgeInsets) {
            value.flag |= DLLLayoutFlagLeftMargin | DLLLayoutFlagRightMargin | DLLLayoutFlagTopMargin | DLLLayoutFlagBottomMargin;
            DLLLayoutRuleGroup xRules = value.xRules;
            DLLLayoutRuleGroup yRules = value.yRules;
            
            xRules.head.type = DLLLayoutRuleTypeValue;
            xRules.head.value = edgeInsets.left;
            xRules.tail.type = DLLLayoutRuleTypeValue;
            xRules.tail.value = edgeInsets.right;
            
            yRules.head.type = DLLLayoutRuleTypeValue;
            yRules.head.value = edgeInsets.top;
            yRules.tail.type = DLLLayoutRuleTypeValue;
            yRules.tail.value = edgeInsets.bottom;
            
            value.xRules = xRules;
            value.yRules = yRules;
            
            return weakSelf;
        };

    }
    return self;
}

@end

