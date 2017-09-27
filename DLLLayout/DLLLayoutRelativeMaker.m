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
#import "DLLLayoutRelative+Private.h"
#import "UIView+DLLLayoutPrivate.h"




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
        _to = ^DLLLayout *(DLLLayoutRelative *relative) {
            return [weakSelf layoutWithRelative:relative];
        };
    }
    return self;
}

- (DLLLayout *)layoutWithRelative:(DLLLayoutRelative *)relative {
    
    DLLLayout *layout = self.layout;
    
    DLLLayoutRule rule;
    rule.type = DLLLayoutRuleTypeRelative;
    rule.value = relative.regulationValue;
    rule.multi = relative.multipleValue;
    rule.offset = relative.offsetValue;
    rule.relativeType = relative.type;
    rule.relativeView = (__bridge void *)relative.view;
    
    switch (self.type) {
        case DLLRelativeLeft: {
            DLLLayoutRuleGroup rules = layout.xRules;
            rules.head = rule;
            layout.xRules = rules;
            layout.flag |= DLLLayoutFlagLeftMargin;
        }
            break;
            
        case DLLRelativeWidth: {
            DLLLayoutRuleGroup rules = layout.xRules;
            rules.value = rule;
            layout.xRules = rules;
            layout.flag |= DLLLayoutFlagWidth;
        }
            break;
            
        case DLLRelativeRight: {
            DLLLayoutRuleGroup rules = layout.xRules;
            rules.tail = rule;
            layout.xRules = rules;
            layout.flag |= DLLLayoutFlagRightMargin;
        }
            break;
            
        case DLLRelativeCenterX: {
            DLLLayoutRuleGroup rules = layout.xRules;
            rules.center = rule;
            layout.xRules = rules;
            layout.flag |= DLLLayoutFlagCenterX;
        }
            break;
            
        case DLLRelativeTop: {
            DLLLayoutRuleGroup rules = layout.yRules;
            rules.head = rule;
            layout.yRules = rules;
            layout.flag |= DLLLayoutFlagTopMargin;
        }
            break;
            
        case DLLRelativeHeight: {
            DLLLayoutRuleGroup rules = layout.yRules;
            rules.value = rule;
            layout.yRules = rules;
            layout.flag |= DLLLayoutFlagHeight;
        }
            break;
            
        case DLLRelativeBottom: {
            DLLLayoutRuleGroup rules = layout.yRules;
            rules.tail = rule;
            layout.yRules = rules;
            layout.flag |= DLLLayoutFlagBottomMargin;
        }
            break;
            
        case DLLRelativeCenterY: {
            DLLLayoutRuleGroup rules = layout.yRules;
            rules.center = rule;
            layout.yRules = rules;
            layout.flag |= DLLLayoutFlagCenterY;
        }
            break;
            
    }
    
    
    return layout;
}

@end
