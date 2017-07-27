//
//  DLLLayoutRule.h
//  Pods
//
//  Created by DLL on 2017/7/19.
//
//

#import <Foundation/Foundation.h>
#import "DLLLayoutDefine.h"
#import "DLLLayoutFlag.h"



struct DLLLayoutFrame {
    CGFloat origin;
    CGFloat value;
};

typedef struct DLLLayoutFrame DLLLayoutFrame;





typedef NS_ENUM(NSUInteger, DLLLayoutRuleType) {
    DLLLayoutRuleTypeValue,
    DLLLayoutRuleTypeRelative
};

struct DLLLayoutRule {
    DLLLayoutRuleType type;
    CGFloat value;
    CGFloat multi;
    void *relativeView;
    DLLLayoutRelativeType relativeType;
};

typedef struct DLLLayoutRule DLLLayoutRule;



typedef NS_ENUM(NSUInteger, DLLLayoutRuleFlag) {
    DLLLayoutRuleFlagValue = 1 << 0,
    DLLLayoutRuleFlagHead = 1 << 1,
    DLLLayoutRuleFlagTail = 1 << 2,
    DLLLayoutRuleFlagCenter = 1 << 3
};

struct DLLLayoutRuleGroup {
    DLLLayoutRuleFlag flag;
    DLLLayoutRule value;
    DLLLayoutRule head;
    DLLLayoutRule tail;
    DLLLayoutRule center;
};
typedef struct DLLLayoutRuleGroup DLLLayoutRuleGroup;




struct DLLLayoutRelativeViews {
    void *view1;
    void *view2;
    void *view3;
    void *view4;
};
typedef struct DLLLayoutRelativeViews DLLLayoutRelativeViews;

BOOL DLLLayoutRuleFlagIsNeedToCalculateValue(DLLLayoutRuleFlag flag);

DLLLayoutFrame DLLLayoutFrameFromRuleGroup(DLLLayoutRuleGroup rules, DLLLayoutFrame frame, CGFloat max, UIView *view);
