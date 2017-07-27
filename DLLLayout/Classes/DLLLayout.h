//
//  DLLLayout.h
//  Pods
//
//  Created by DLL on 2017/7/18.
//
//

#import <Foundation/Foundation.h>
#import "DLLLayoutDefine.h"
#import "UIView+DLLLayout.h"
#import "DLLLayoutRelativeMaker.h"


@class DLLLayout, DLLLayoutValue, DLLLayoutRelativeMaker;
typedef DLLLayout *(^DLLLayoutNumberValue)(CGFloat);


@interface DLLLayout : NSObject


@property (nonatomic, readonly) DLLLayoutNumberValue width;

@property (nonatomic, readonly) DLLLayoutNumberValue height;

@property (nonatomic, readonly) DLLLayoutNumberValue leftMargin;

@property (nonatomic, readonly) DLLLayoutNumberValue rightMargin;

@property (nonatomic, readonly) DLLLayoutNumberValue topMargin;

@property (nonatomic, readonly) DLLLayoutNumberValue bottomMargin;

@property (nonatomic, readonly) DLLLayoutNumberValue centerY;

@property (nonatomic, readonly) DLLLayoutNumberValue centerX;


@property (nonatomic, readonly) DLLLayoutRelativeMaker *relative;

@end


