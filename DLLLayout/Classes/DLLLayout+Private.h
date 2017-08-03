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



@property (assign, nonatomic) BOOL needsLayout;

- (BOOL)needsLayoutForAxis:(DLLLayoutAxis)axis;

- (void)setNeedsLayout:(BOOL)needsLayout forAxis:(DLLLayoutAxis)axis;



- (void)setCalculating:(BOOL)calculating relative:(int)index forAxis:(DLLLayoutAxis)axis;

- (BOOL)isCalculatingRelative:(int)index forAxis:(DLLLayoutAxis)axis;

- (BOOL)isCalculatingRelativeForAxis:(DLLLayoutAxis)axis;





- (BOOL)hasEstimatedRelative:(int)index forAxis:(DLLLayoutAxis)axis;

- (void)setEstimated:(BOOL)estimated relative:(int)index forAxis:(DLLLayoutAxis)axis;


@property (assign, nonatomic) UIView *view;

@property (readonly, nonatomic) DLLLayoutRelativeViews relativeViewsX;

@property (readonly, nonatomic) DLLLayoutRelativeViews relativeViewsY;



- (DLLLayoutAxisFrame)axisFrameForAxis:(DLLLayoutAxis)axis;

- (void)setNeedsUpdateContentSize;


@end
