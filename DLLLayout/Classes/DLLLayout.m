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
#import "UIView+DLLLayoutPrivate.h"
#import "DLLLayoutFunction.h"


static int const DLLNeedsLayoutX = 1 << 0;
static int const DLLNeedsLayoutY = 1 << 1;

static int const DLLCalculatingLayoutX = 1 << 4;

static int const DLLCalculatingLayoutY = 1 << 8;

@implementation DLLLayout {
    int _calculateLayoutFlag;
    CGSize _calculatedBaseSize;
    CGSize _calculatedSize;
}
#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _relative = [[DLLLayoutRelativeMaker alloc] init];
        _relative.bridge.layout = self;
        
        DLLLayout __weak *weakSelf = self;
        _width = ^DLLLayout *(CGFloat width) {
            weakSelf.flag |= DLLLayoutFlagWidth;
            DLLLayoutRuleGroup rules = weakSelf.xRules;
            rules.value.type = DLLLayoutRuleTypeValue;
            rules.value.value = width;
            weakSelf.xRules = rules;
            return weakSelf;
        };
        
        _height = ^DLLLayout *(CGFloat height) {
            weakSelf.flag |= DLLLayoutFlagHeight;
            DLLLayoutRuleGroup rules = weakSelf.yRules;
            rules.value.type = DLLLayoutRuleTypeValue;
            rules.value.value = height;
            weakSelf.yRules = rules;
            return weakSelf;
        };
        
        _leftMargin = ^DLLLayout *(CGFloat leftMargin) {
            weakSelf.flag |= DLLLayoutFlagLeftMargin;
            DLLLayoutRuleGroup rules = weakSelf.xRules;
            rules.head.type = DLLLayoutRuleTypeValue;
            rules.head.value = leftMargin;
            weakSelf.xRules = rules;
            return weakSelf;
        };
        
        _rightMargin = ^DLLLayout *(CGFloat rightMargin) {
            weakSelf.flag |= DLLLayoutFlagRightMargin;
            DLLLayoutRuleGroup rules = weakSelf.xRules;
            rules.tail.type = DLLLayoutRuleTypeValue;
            rules.tail.value = rightMargin;
            weakSelf.xRules = rules;
            return weakSelf;
        };
        
        _topMargin = ^DLLLayout *(CGFloat topMargin) {
            weakSelf.flag |= DLLLayoutFlagTopMargin;
            DLLLayoutRuleGroup rules = weakSelf.yRules;
            rules.head.type = DLLLayoutRuleTypeValue;
            rules.head.value = topMargin;
            weakSelf.yRules = rules;
            return weakSelf;
        };
        
        _bottomMargin = ^DLLLayout *(CGFloat bottomMargin) {
            weakSelf.flag |= DLLLayoutFlagBottomMargin;
            DLLLayoutRuleGroup rules = weakSelf.yRules;
            rules.tail.type = DLLLayoutRuleTypeValue;
            rules.tail.value = bottomMargin;
            weakSelf.yRules = rules;
            return weakSelf;
        };
        
        _centerX = ^DLLLayout *(CGFloat centerX) {
            weakSelf.flag |= DLLLayoutFlagCenterX;
            DLLLayoutRuleGroup rules = weakSelf.xRules;
            rules.center.type = DLLLayoutRuleTypeValue;
            rules.center.value = centerX;
            weakSelf.xRules = rules;
            return weakSelf;
        };
        
        _centerY = ^DLLLayout *(CGFloat centerY) {
            weakSelf.flag |= DLLLayoutFlagCenterY;
            DLLLayoutRuleGroup rules = weakSelf.yRules;
            rules.center.type = DLLLayoutRuleTypeValue;
            rules.center.value = centerY;
            weakSelf.yRules = rules;
            return weakSelf;
        };
        
        _margin = ^DLLLayout *(UIEdgeInsets edgeInsets) {
            weakSelf.flag |= DLLLayoutFlagLeftMargin | DLLLayoutFlagRightMargin | DLLLayoutFlagTopMargin | DLLLayoutFlagBottomMargin;
            DLLLayoutRuleGroup xRules = weakSelf.xRules;
            DLLLayoutRuleGroup yRules = weakSelf.yRules;
            
            xRules.head.type = DLLLayoutRuleTypeValue;
            xRules.head.value = edgeInsets.left;
            xRules.tail.type = DLLLayoutRuleTypeValue;
            xRules.tail.value = edgeInsets.right;
            
            yRules.head.type = DLLLayoutRuleTypeValue;
            yRules.head.value = edgeInsets.top;
            yRules.tail.type = DLLLayoutRuleTypeValue;
            yRules.tail.value = edgeInsets.bottom;
            
            weakSelf.xRules = xRules;
            weakSelf.yRules = yRules;
            
            return weakSelf;
        };
        
    }
    return self;
}

#pragma mark - layout
- (DLLLayoutAxisFrame)axisFrameForAxis:(DLLLayoutAxis)axis {
    CGRect frame = _view.frame;
    DLLLayoutAxisFrame axisFrame = {0, 0, NO};
    DLLLayoutRelativeViews relativeViews;
    DLLLayoutRuleGroup rules;
    
    switch (axis) {
        case DLLLayoutAxisX:
            axisFrame.origin = frame.origin.x;
            axisFrame.value = frame.size.width;
            if (!self.needsLayoutX) {
                return axisFrame;
            }
            relativeViews = self.relativeViewsX;
            rules = self.xRules;
            break;
            
        case DLLLayoutAxisY:
            axisFrame.origin = frame.origin.y;
            axisFrame.value = frame.size.height;
            if (!self.needsLayoutY) {
                return axisFrame;
            }
            relativeViews = self.relativeViewsY;
            rules = self.yRules;
            break;
    }
    int relativeViewEstimated = 0;
    if (relativeViews.view1 && ![self isCalculatingRelative:0 forAxis:axis]) {
        UIView *view = (__bridge UIView *)relativeViews.view1;
        [self setCalculating:YES relative:0 forAxis:axis];
        relativeViewEstimated |= [view.dll_layout axisFrameForAxis:relativeViews.view1Axis].isEstimated ? (1 << 0) : 0;
        [self setCalculating:NO relative:0 forAxis:axis];
    }
    if (relativeViews.view2 && ![self isCalculatingRelative:1 forAxis:axis]) {
        UIView *view = (__bridge UIView *)relativeViews.view2;
        [self setCalculating:YES relative:1 forAxis:axis];
        relativeViewEstimated |= [view.dll_layout axisFrameForAxis:relativeViews.view2Axis].isEstimated ? (1 << 1) : 0;
        [self setCalculating:NO relative:1 forAxis:axis];
    }
    
    CGFloat superValue;
    switch (axis) {
        case DLLLayoutAxisX:
            superValue = _view.superview.bounds.size.width;
            break;
            
        case DLLLayoutAxisY:
            superValue = _view.superview.bounds.size.height;
            break;
    }
    
    if (DLLLayoutRuleFlagIsNeedToCalculateValue(rules.flag)) {
        // 自适应
        CGSize calculatedSize;
        DLLLayoutRuleGroup otherRules;
        switch (axis) {
            case DLLLayoutAxisX:
                otherRules = self.yRules;
                break;
                
            case DLLLayoutAxisY:
                otherRules = self.xRules;
                break;
        }
        DLLLayoutRule valueRule;
        valueRule.type = DLLLayoutRuleTypeValue;
        if (DLLLayoutRuleFlagIsNeedToCalculateValue(otherRules.flag)) {
            calculatedSize = [self sizeThatFitsValue:CGFLOAT_MAX axis:axis];
        } else {
            calculatedSize = [self sizeThatFitsValue:[self axisFrameForAxis:!axis].value axis:axis];
        }
        switch (axis) {
            case DLLLayoutAxisX:
                valueRule.value = calculatedSize.width;
                break;
                
            case DLLLayoutAxisY:
                valueRule.value = calculatedSize.height;
                break;
        }
        
        rules.value = valueRule;
        rules.flag |= DLLLayoutRuleFlagValue;
        
    }
    axisFrame = DLLLayoutAxisFrameFromRuleGroup(rules, axisFrame, superValue, _view);
    
    frame = _view.frame;
    
    BOOL isCalculatingRelative = [self isCalculatingRelative:0 forAxis:axis] || [self isCalculatingRelative:1 forAxis:axis];
    BOOL isEstimated = relativeViewEstimated != 0 || isCalculatingRelative;
    switch (axis) {
        case DLLLayoutAxisX:
            frame.origin.x = axisFrame.origin;
            frame.size.width = axisFrame.value;
            break;
            
        case DLLLayoutAxisY:
            frame.origin.y = axisFrame.origin;
            frame.size.height = axisFrame.value;
            break;
    }
    _view.frame = frame;
    axisFrame.isEstimated = isEstimated;
    
    if (!isCalculatingRelative) {
        
        if (relativeViewEstimated & 1) {
            UIView *view = (__bridge UIView *)relativeViews.view1;
            [view.dll_layout setNeedsLayout:YES forAxis:axis];
            [view.dll_layout axisFrameForAxis:relativeViews.view1Axis];
        }
        if (relativeViewEstimated & 1 << 1) {
            UIView *view = (__bridge UIView *)relativeViews.view2;
            [view.dll_layout setNeedsLayout:YES forAxis:axis];
            [view.dll_layout axisFrameForAxis:relativeViews.view2Axis];
        }
        
        [self setNeedsLayout:NO forAxis:axis];
    }
    
    return axisFrame;
}

- (void)setNeedsUpdateContentSize {
    _calculatedBaseSize = CGSizeZero;
    _calculatedSize = CGSizeZero;
}

- (CGSize)sizeThatFitsValue:(CGFloat)value axis:(DLLLayoutAxis)axis {
    CGSize size = CGSizeUnknown;
    switch (axis) {
        case DLLLayoutAxisX:
            size.height = value;
            break;
            
        case DLLLayoutAxisY:
            size.width = value;
            break;
    }
    if (CGSizeEqualToSize(size, _calculatedBaseSize)) {
        return _calculatedSize;
    } else {
        _calculatedBaseSize = size;
        _calculatedSize = [_view sizeThatFits:_calculatedBaseSize];
        _calculatedSize = CGSizeMake(ceil(_calculatedSize.width), ceil(_calculatedSize.height));
        return _calculatedSize;
    }
}


- (DLLLayoutRelativeViews)relativeViewsX {
    DLLLayoutRelativeViews views = {NULL, 0, NULL, 0};
    views = [self relativeViews:views byRules:_xRules ruleFlag:DLLLayoutRuleFlagValue];
    views = [self relativeViews:views byRules:_xRules ruleFlag:DLLLayoutRuleFlagHead];
    views = [self relativeViews:views byRules:_xRules ruleFlag:DLLLayoutRuleFlagTail];
    views = [self relativeViews:views byRules:_xRules ruleFlag:DLLLayoutRuleFlagCenter];
    return views;
}

- (DLLLayoutRelativeViews)relativeViewsY {
    DLLLayoutRelativeViews views = {NULL, 0, NULL, 0};
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
        
        DLLLayoutAxis axis;
        switch (rule.relativeType) {
            case DLLRelativeLeft:
            case DLLRelativeRight:
            case DLLRelativeWidth:
            case DLLRelativeCenterX:
                axis = DLLLayoutAxisX;
                break;
                
            case DLLRelativeTop:
            case DLLRelativeBottom:
            case DLLRelativeHeight:
            case DLLRelativeCenterY:
                axis = DLLLayoutAxisY;
                break;
        }
        
        if (rule.type == DLLLayoutRuleTypeRelative) {
            void *view = rule.relativeView;
            if (views.view1 == NULL) {
                views.view1 = view;
                views.view1Axis = axis;
            } else if (views.view2 == NULL) {
                views.view2 = view;
                views.view2Axis = axis;
            }
        }
    }
    
    return views;
}

#pragma mark - flag
- (BOOL)needsLayout {
    return _calculateLayoutFlag;
}

- (void)setNeedsLayout:(BOOL)needsLayout {
    _calculateLayoutFlag = DLLNeedsLayoutX | DLLNeedsLayoutY;
}

- (void)setNeedsLayoutX:(BOOL)needsLayoutX {
    if (needsLayoutX) {
        _calculateLayoutFlag |= DLLNeedsLayoutX;
    } else {
        _calculateLayoutFlag &= ~DLLNeedsLayoutX;
    }
}

- (BOOL)needsLayoutX {
    return _calculateLayoutFlag & DLLNeedsLayoutX;
}

- (void)setNeedsLayoutY:(BOOL)needsLayoutY {
    if (needsLayoutY) {
        _calculateLayoutFlag |= DLLNeedsLayoutY;
    } else {
        _calculateLayoutFlag &= ~DLLNeedsLayoutY;
    }
}

- (BOOL)needsLayoutY {
    return _calculateLayoutFlag & DLLNeedsLayoutY;
}

- (void)setCalculating:(BOOL)calculating relative:(int)index forAxis:(DLLLayoutAxis)axis {
    int mask = 0;
    switch (axis) {
        case DLLLayoutAxisX:
            mask = DLLCalculatingLayoutX << index;
            break;
            
        case DLLLayoutAxisY:
            mask = DLLCalculatingLayoutY << index;
            break;
    }
    
    if (calculating) {
        _calculateLayoutFlag |= mask;
    } else {
        _calculateLayoutFlag &= ~mask;
    }
}

- (BOOL)isCalculatingRelative:(int)index forAxis:(DLLLayoutAxis)axis {
    switch (axis) {
        case DLLLayoutAxisX:
            return _calculateLayoutFlag & (DLLCalculatingLayoutX << index);
        case DLLLayoutAxisY:
            return _calculateLayoutFlag & (DLLCalculatingLayoutY << index);
    }
    return NO;
}


- (void)setFlag:(DLLLayoutFlag)flag {
    _flag = flag;
    _xRules.flag = flag & 0xF;
    _yRules.flag = (flag & 0xF0) >> 4;
    self.needsLayout = YES;
}

- (void)setNeedsLayout:(BOOL)needsLayout forAxis:(DLLLayoutAxis)axis {
    switch (axis) {
        case DLLLayoutAxisX:
            [self setNeedsLayoutX:needsLayout];
            break;
            
        case DLLLayoutAxisY:
            [self setNeedsLayoutY:needsLayout];
            break;
    }
}

- (BOOL)needsLayoutForAxis:(DLLLayoutAxis)axis {
    switch (axis) {
        case DLLLayoutAxisX:
            return _calculateLayoutFlag & DLLNeedsLayoutX;
            
        case DLLLayoutAxisY:
            return _calculateLayoutFlag & DLLNeedsLayoutY;
            break;
    }
    return NO;
    
}
@end

