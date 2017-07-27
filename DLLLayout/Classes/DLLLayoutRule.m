//
//  DLLLayoutRule.m
//  Pods
//
//  Created by DLL on 2017/7/19.
//
//

#import "DLLLayoutRule.h"
#import "UIView+DLLLayoutPrivate.h"
#import "DLLLayout+Private.h"

CGFloat DLLLayoutRuleValue(DLLLayoutRule rule) {
    switch (rule.type) {
        case DLLLayoutRuleTypeValue:
            return rule.value;
            
        case DLLLayoutRuleTypeRelative: {
            CGRect frame = ((__bridge UIView *)rule.relativeView).frame;
            switch (rule.relativeType) {
                case DLLRelativeLeft:
                    return CGRectGetMinX(frame) + rule.value;
                    
                case DLLRelativeRight:
                    return CGRectGetMaxX(frame) + rule.value;
                    
                case DLLRelativeWidth:
                    return CGRectGetWidth(frame) * rule.multi + rule.value;
                    
                case DLLRelativeCenterX:
                    return CGRectGetMidX(frame) + rule.value;
                    
                case DLLRelativeTop:
                    return CGRectGetMinY(frame) + rule.value;
                    
                case DLLRelativeBottom:
                    return CGRectGetMaxY(frame) + rule.value;
                    
                case DLLRelativeHeight:
                    return CGRectGetHeight(frame) * rule.multi + rule.value;
                    
                case DLLRelativeCenterY:
                    return CGRectGetMidY(frame) + rule.value;
            }
        }
            
    }
    return 0;
}


BOOL DLLLayoutRuleFlagIsNeedToCalculateValue(DLLLayoutRuleFlag flag) {
    switch (flag) {
        case DLLLayoutRuleFlagHead:
        case DLLLayoutRuleFlagTail:
        case DLLLayoutRuleFlagCenter:
            return YES;
            
        default:
            return NO;
    }
}


DLLLayoutFrame DLLLayoutFrameFromRuleGroup(DLLLayoutRuleGroup rules, DLLLayoutFrame frame, CGFloat max, UIView *view) {
    switch ((int)rules.flag) {
        case DLLLayoutRuleFlagValue | DLLLayoutRuleFlagHead:
            frame.value = DLLLayoutRuleValue(rules.value);
            frame.origin = DLLLayoutRuleValue(rules.head);
            break;
            
        case DLLLayoutRuleFlagValue | DLLLayoutRuleFlagTail:
            frame.value = DLLLayoutRuleValue(rules.value);
            switch (rules.tail.type) {
                case DLLLayoutRuleTypeValue:
                    frame.origin = max - rules.tail.value - frame.value;
                    break;
                    
                case DLLLayoutRuleTypeRelative:
                    frame.origin = DLLLayoutRuleValue(rules.tail) - frame.value;
                    break;
            }
            break;
            
        case DLLLayoutRuleFlagValue | DLLLayoutRuleFlagCenter:
            frame.value = DLLLayoutRuleValue(rules.value);
            CGFloat center = 0;
            switch (rules.center.type) {
                case DLLLayoutRuleTypeValue:
                    center = max / 2 + rules.center.value;
                    
                    break;
                    
                case DLLLayoutRuleTypeRelative:
                    center = DLLLayoutRuleValue(rules.center);
                    break;
            }
            frame.origin = center - frame.value / 2;
            break;
            
        case DLLLayoutRuleFlagHead | DLLLayoutRuleFlagTail:
            frame.origin = DLLLayoutRuleValue(rules.head);
            switch (rules.tail.type) {
                case DLLLayoutRuleTypeValue:
                    frame.value = max - frame.origin - rules.tail.value;
                    break;
                    
                case DLLLayoutRuleTypeRelative:
                    frame.value = DLLLayoutRuleValue(rules.tail) - frame.origin;
                    break;
            }
            break;
            
        case DLLLayoutRuleFlagCenter | DLLLayoutRuleFlagHead: {
            frame.origin = DLLLayoutRuleValue(rules.head);
            CGFloat center = 0;
            switch (rules.center.type) {
                case DLLLayoutRuleTypeValue:
                    center = max / 2 + rules.center.value;
                    break;
                    
                case DLLLayoutRuleTypeRelative:
                    center = DLLLayoutRuleValue(rules.center);
                    break;
            }
            frame.value = 2 * (center - frame.origin);
        }
            break;
            
        case DLLLayoutRuleFlagCenter | DLLLayoutRuleFlagTail: {
            CGFloat middle = 0;
            switch (rules.center.type) {
                case DLLLayoutRuleTypeValue:
                    middle = max / 2 + rules.center.value;
                    break;
                    
                case DLLLayoutRuleTypeRelative:
                    middle = DLLLayoutRuleValue(rules.center);
                    break;
            }
            CGFloat tail = 0;
            switch (rules.tail.type) {
                case DLLLayoutRuleTypeValue:
                    tail = max - rules.tail.value;
                    break;
                    
                case DLLLayoutRuleTypeRelative:
                    tail = DLLLayoutRuleValue(rules.tail);
                    break;
            }
            frame.value = 2 * (tail - middle);
            frame.origin = max - tail - frame.value;
        }
            break;
            
        default: {
            DLLLayoutFlag flag = view.dll_layout.layoutValue.flag;
            NSMutableString *flags = [[NSMutableString alloc] init];
            if (flag & DLLLayoutFlagWidth) {
                [flags appendString:@" Width "];
            }
            if (flag & DLLLayoutFlagLeftMargin) {
                [flags appendString:@" Left "];
            }
            if (flag & DLLLayoutFlagRightMargin) {
                [flags appendString:@" Right "];
            }
            if (flag & DLLLayoutFlagCenterX) {
                [flags appendString:@" CenterX "];
            }
            if (flag & DLLLayoutFlagHeight) {
                [flags appendString:@" Height "];
            }
            if (flag & DLLLayoutFlagTopMargin) {
                [flags appendString:@" Top "];
            }
            if (flag & DLLLayoutFlagBottomMargin) {
                [flags appendString:@" Bottom "];
            }
            if (flag & DLLLayoutFlagCenterY) {
                [flags appendString:@" CenterY "];
            }
            
            
            @throw [NSException exceptionWithName:@"DLLLayoutException" reason:[NSString stringWithFormat:@"%@ 布局条件错误: %@", view, flags] userInfo:nil];
        }
            break;
    }
    
    return frame;
}
