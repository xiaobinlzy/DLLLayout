//
//  DLLLayoutValue.m
//  Pods
//
//  Created by DLL on 2017/7/18.
//
//

#import "DLLLayoutValue.h"
#import "DLLLayout+Private.h"
#import "UIView+DLLLayoutPrivate.h"
#import "DLLLayoutRule.h"

void dll_updateFlag(DLLLayoutRuleFlag flag, DLLLayoutRuleFlag new) {
    
}


@implementation DLLLayoutValue

- (void)setFlag:(DLLLayoutFlag)flag {
    _flag = flag;
    _xRules.flag = flag & 0xF;
    _yRules.flag = (flag & 0xF0) >> 4;
}


- (CGRect)frameForView:(UIView *)view {
    CGRect frame = view.frame;
    CGSize size = view.superview.bounds.size;
    DLLLayoutFrame xFrame = {frame.origin.x, frame.size.width};
    DLLLayoutFrame yFrame = {frame.origin.y, frame.size.height};
    
    
    if (DLLLayoutRuleFlagIsNeedToCalculateValue(_xRules.flag) || DLLLayoutRuleFlagIsNeedToCalculateValue(_yRules.flag)) {
        DLLLayoutRuleGroup xRules = _xRules;
        DLLLayoutRuleGroup yRules = _yRules;
        CGSize calculatedSize;
        DLLLayoutRule value;
        value.type = DLLLayoutRuleTypeValue;
        
        if (!DLLLayoutRuleFlagIsNeedToCalculateValue(_xRules.flag)) {
            xFrame = DLLLayoutFrameFromRuleGroup(xRules, xFrame, size.width, view);
            calculatedSize = [view sizeThatFits:CGSizeMake(xFrame.value, CGFLOAT_MAX)];
            value.value = calculatedSize.height;
            yRules.value = value;
            yRules.flag |= DLLLayoutRuleFlagValue;
            yFrame = DLLLayoutFrameFromRuleGroup(yRules, yFrame, size.height, view);
        } else if (!DLLLayoutRuleFlagIsNeedToCalculateValue(_yRules.flag)) {
            yFrame = DLLLayoutFrameFromRuleGroup(yRules, yFrame, size.height, view);
            calculatedSize = [view sizeThatFits:CGSizeMake(CGFLOAT_MAX, yFrame.value)];
            value.value = calculatedSize.width;
            xRules.value = value;
            xRules.flag |= DLLLayoutRuleFlagValue;
            xFrame = DLLLayoutFrameFromRuleGroup(xRules, xFrame, size.width, view);
        } else {
            calculatedSize = [view sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
            
            value.value = calculatedSize.width;
            xRules.value = value;
            xRules.flag |= DLLLayoutRuleFlagValue;
            
            value.value = calculatedSize.height;
            yRules.value = value;
            yRules.flag |= DLLLayoutRuleFlagValue;
            
            xFrame = DLLLayoutFrameFromRuleGroup(xRules, xFrame, size.width, view);
            yFrame = DLLLayoutFrameFromRuleGroup(yRules, yFrame, size.height, view);
        }
    } else  {
        xFrame = DLLLayoutFrameFromRuleGroup(_xRules, xFrame, size.width, view);
        yFrame = DLLLayoutFrameFromRuleGroup(_yRules, yFrame, size.height, view);
    }
    return CGRectMake(xFrame.origin, yFrame.origin, xFrame.value, yFrame.value);
}

- (DLLLayoutRelativeViews)relativeViews {
    DLLLayoutRelativeViews views = {NULL, NULL, NULL, NULL};
    views = [self relativeViews:views byRules:_xRules ruleFlag:DLLLayoutRuleFlagValue];
    views = [self relativeViews:views byRules:_xRules ruleFlag:DLLLayoutRuleFlagHead];
    views = [self relativeViews:views byRules:_xRules ruleFlag:DLLLayoutRuleFlagTail];
    views = [self relativeViews:views byRules:_xRules ruleFlag:DLLLayoutRuleFlagCenter];
    views = [self relativeViews:views byRules:_yRules ruleFlag:DLLLayoutRuleFlagValue];
    views = [self relativeViews:views byRules:_yRules ruleFlag:DLLLayoutRuleFlagHead];
    views = [self relativeViews:views byRules:_yRules ruleFlag:DLLLayoutRuleFlagTail];
    views = [self relativeViews:views byRules:_yRules ruleFlag:DLLLayoutRuleFlagCenter];
    return views;
}

- (DLLLayoutRelativeViews)relativeViews:(DLLLayoutRelativeViews)views byRules:(DLLLayoutRuleGroup)rules ruleFlag:(DLLLayoutRuleFlag)flag {
    if (rules.flag & flag) {
        DLLLayoutRule rule;
        switch (flag) {
            case DLLLayoutRuleFlagValue:
                rule = rules.value;
                break;
            case DLLLayoutRuleFlagHead:
                rule = rules.head;
                break;
            case DLLLayoutRuleFlagTail:
                rule = rules.tail;
                break;
            case DLLLayoutRuleFlagCenter:
                rule = rules.center;
                break;
        }
        if (rule.type == DLLLayoutRuleTypeRelative) {
            void *view = rule.relativeView;
            if (views.view1 == NULL) {
                views.view1 = view;
            } else if (views.view2 == NULL) {
                views.view2 = view;
            } else if (views.view3 == NULL) {
                views.view3 = view;
            } else if (views.view4 == NULL) {
                views.view4 = view;
            }
        }
    }
    
    return views;
}

@end
