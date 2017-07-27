//
//  DLLLayoutRelativeMaker.h
//  Pods
//
//  Created by DLL on 2017/7/19.
//
//

#import <Foundation/Foundation.h>
#import "DLLLayoutDefine.h"

@class DLLLayout, DLLLayoutRelativeBridge;

@interface DLLLayoutRelativeMaker : NSObject

@property (nonatomic, readonly) DLLLayoutRelativeBridge *left;

@property (nonatomic, readonly) DLLLayoutRelativeBridge *right;

@property (nonatomic, readonly) DLLLayoutRelativeBridge *width;

@property (nonatomic, readonly) DLLLayoutRelativeBridge *centerX;

@property (nonatomic, readonly) DLLLayoutRelativeBridge *top;

@property (nonatomic, readonly) DLLLayoutRelativeBridge *bottom;

@property (nonatomic, readonly) DLLLayoutRelativeBridge *height;

@property (nonatomic, readonly) DLLLayoutRelativeBridge *centerY;

@end


@interface DLLLayoutRelativeBridge : NSObject


@property (nonatomic, readonly) DLLLayout *(^to)(DLLLayoutRelative relative);

@property (nonatomic, readonly) DLLLayout *(^withOffset)(DLLLayoutRelative relative, CGFloat offset);

@property (nonatomic, readonly) DLLLayout *(^withMulti)(DLLLayoutRelative relative, CGFloat multi);

@end
