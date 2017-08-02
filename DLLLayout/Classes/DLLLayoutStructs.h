//
//  DLLLayoutStructs.h
//  Pods
//
//  Created by DLL on 2017/7/19.
//
//

#import <Foundation/Foundation.h>
#import "DLLLayoutDefine.h"

extern const CGSize CGSizeUnknown;

BOOL CGSizeIsUnknown(CGSize size);

struct DLLLayoutAxisFrame {
    CGFloat origin;
    CGFloat value;
    BOOL isEstimated;
};

typedef struct DLLLayoutAxisFrame DLLLayoutAxisFrame;


typedef NS_ENUM(NSUInteger, DLLLayoutAxis) {
    DLLLayoutAxisX = 0,
    DLLLayoutAxisY = 1
};


typedef NS_ENUM(NSUInteger, DLLLayoutRuleType) {
    DLLLayoutRuleTypeValue,
    DLLLayoutRuleTypeRelative
};

struct DLLLayoutRule {
    DLLLayoutRuleType type;
    CGFloat value;
    CGFloat multi;
    CGFloat offset;
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
    DLLLayoutAxis view1Axis;
    void *view2;
    DLLLayoutAxis view2Axis;
};
typedef struct DLLLayoutRelativeViews DLLLayoutRelativeViews;

BOOL DLLLayoutRuleFlagIsNeedToCalculateValue(DLLLayoutRuleFlag flag);

DLLLayoutAxisFrame DLLLayoutAxisFrameFromRuleGroup(DLLLayoutRuleGroup rules, DLLLayoutAxisFrame frame, CGFloat max, UIView *view);
