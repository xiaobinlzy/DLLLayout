//
//  DLLLayoutValue.h
//  Pods
//
//  Created by DLL on 2017/7/18.
//
//

#import <Foundation/Foundation.h>
#import "DLLLayoutRule.h"


@interface DLLLayoutValue : NSObject

@property (assign, nonatomic) DLLLayoutFlag flag;

@property (assign, nonatomic) DLLLayoutRuleGroup xRules;

@property (assign, nonatomic) DLLLayoutRuleGroup yRules;

@property (assign, nonatomic) BOOL hasLayout;

- (CGRect)frameForView:(UIView *)view;


@property (readonly, nonatomic) DLLLayoutRelativeViews relativeViews;

@end
