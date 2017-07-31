//
//  DLLLayout+Private.h
//  Pods
//
//  Created by DLL on 2017/7/18.
//
//

#import "DLLLayout.h"
#import "DLLLayoutStructs.h"

@interface DLLLayout ()


@property (assign, nonatomic) DLLLayoutFlag flag;

@property (assign, nonatomic) DLLLayoutRuleGroup xRules;

@property (assign, nonatomic) DLLLayoutRuleGroup yRules;

@property (assign, nonatomic) BOOL hasLayoutX;

@property (assign, nonatomic) BOOL hasLayoutY;

@property (assign, nonatomic) BOOL hasLayout;

@property (assign, nonatomic) UIView *view;

@property (readonly, nonatomic) DLLLayoutRelativeViews relativeViewsX;

@property (readonly, nonatomic) DLLLayoutRelativeViews relativeViewsY;

- (DLLLayoutAxisFrame)axisFrameForAxis:(DLLLayoutAxis)axis;

- (void)setNeedsUpdateContentSize;

@end
