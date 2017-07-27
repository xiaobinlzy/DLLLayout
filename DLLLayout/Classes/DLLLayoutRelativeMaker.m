//
//  DLLLayoutRelativeMaker.m
//  Pods
//
//  Created by DLL on 2017/7/19.
//
//

#import "DLLLayoutRelativeMaker.h"
#import "DLLLayout+Private.h"
#import "DLLLayoutRelativeMaker+Private.h"




@implementation DLLLayoutRelativeMaker

- (instancetype)init {
    self = [super init];
    if (self) {
        _bridge = [[DLLLayoutRelativeBridge alloc] init];
    }
    return self;
}


- (DLLLayoutRelativeBridge *)left {
    _bridge.type = DLLRelativeLeft;
    return _bridge;
}

- (DLLLayoutRelativeBridge *)right {
    _bridge.type = DLLRelativeRight;
    return _bridge;
}

- (DLLLayoutRelativeBridge *)width {
    _bridge.type = DLLRelativeWidth;
    return _bridge;
}

- (DLLLayoutRelativeBridge *)centerX {
    _bridge.type = DLLRelativeCenterX;
    return _bridge;
}

- (DLLLayoutRelativeBridge *)top {
    _bridge.type = DLLRelativeTop;
    return _bridge;
}

- (DLLLayoutRelativeBridge *)bottom {
    _bridge.type = DLLRelativeBottom;
    return _bridge;
}

- (DLLLayoutRelativeBridge *)height {
    _bridge.type = DLLRelativeHeight;
    return _bridge;
}

- (DLLLayoutRelativeBridge *)centerY {
    _bridge.type = DLLRelativeCenterY;
    return _bridge;
}

@end

@implementation DLLLayoutRelativeBridge

- (instancetype)init {
    self = [super init];
    if (self) {
        typeof(self) __weak weakSelf = self;
        _to = ^DLLLayout *(DLLLayoutRelative relative) {
            return [weakSelf layoutWithRelative:relative offset:0 multi:1];
        };
        _withOffset = ^DLLLayout *(DLLLayoutRelative relative, CGFloat offset) {
            return [weakSelf layoutWithRelative:relative offset:offset multi:1];
        };
        _withMulti = ^DLLLayout *(DLLLayoutRelative relative, CGFloat multi) {
            return [weakSelf layoutWithRelative:relative offset:0 multi:multi];
        };
    }
    return self;
}

- (DLLLayout *)layoutWithRelative:(DLLLayoutRelative)relative offset:(CGFloat)offset multi:(CGFloat)multi {
    
    DLLLayout *layout = self.layout;
    DLLLayoutValue *layoutValue = layout.layoutValue;
    
    DLLLayoutRule rule;
    rule.type = DLLLayoutRuleTypeRelative;
    rule.value = offset;
    rule.multi = multi;
    rule.relativeType = relative.type;
    rule.relativeView = relative.view;
    
    switch (self.type) {
        case DLLRelativeLeft: {
            DLLLayoutRuleGroup rules = layoutValue.xRules;
            rules.head = rule;
            layoutValue.xRules = rules;
            layoutValue.flag |= DLLLayoutFlagLeftMargin;
        }
            break;
            
        case DLLRelativeWidth: {
            DLLLayoutRuleGroup rules = layoutValue.xRules;
            rules.value = rule;
            layoutValue.xRules = rules;
            layoutValue.flag |= DLLLayoutFlagWidth;
        }
            break;
            
        case DLLRelativeRight: {
            DLLLayoutRuleGroup rules = layoutValue.xRules;
            rules.tail = rule;
            layoutValue.xRules = rules;
            layoutValue.flag |= DLLLayoutFlagRightMargin;
        }
            break;
            
        case DLLRelativeCenterX: {
            DLLLayoutRuleGroup rules = layoutValue.xRules;
            rules.center = rule;
            layoutValue.xRules = rules;
            layoutValue.flag |= DLLLayoutFlagCenterX;
        }
            break;
            
        case DLLRelativeTop: {
            DLLLayoutRuleGroup rules = layoutValue.yRules;
            rules.head = rule;
            layoutValue.yRules = rules;
            layoutValue.flag |= DLLLayoutFlagTopMargin;
        }
            break;
            
        case DLLRelativeHeight: {
            DLLLayoutRuleGroup rules = layoutValue.yRules;
            rules.value = rule;
            layoutValue.yRules = rules;
            layoutValue.flag |= DLLLayoutFlagHeight;
        }
            break;
            
        case DLLRelativeBottom: {
            DLLLayoutRuleGroup rules = layoutValue.yRules;
            rules.tail = rule;
            layoutValue.yRules = rules;
            layoutValue.flag |= DLLLayoutFlagBottomMargin;
        }
            break;
            
        case DLLRelativeCenterY: {
            DLLLayoutRuleGroup rules = layoutValue.yRules;
            rules.center = rule;
            layoutValue.yRules = rules;
            layoutValue.flag |= DLLLayoutFlagCenterY;
        }
            break;
            
    }
    
    
    
    
    return layout;
}

@end
