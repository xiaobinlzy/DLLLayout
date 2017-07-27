//
//  DLLLayoutDefine.h
//  Pods
//
//  Created by DLL on 2017/7/19.
//
//

#ifndef DLLLayoutDefine_h
#define DLLLayoutDefine_h

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSUInteger, DLLLayoutFlag) {
    DLLLayoutFlagWidth = 1 << 0,
    DLLLayoutFlagLeftMargin = 1 << 1,
    DLLLayoutFlagRightMargin = 1 << 2,
    DLLLayoutFlagCenterX = 1 << 3,
    
    DLLLayoutFlagHeight = 1 << 4,
    DLLLayoutFlagTopMargin = 1 << 5,
    DLLLayoutFlagBottomMargin = 1 << 6,
    DLLLayoutFlagCenterY = 1 << 7,
    
};


typedef NS_ENUM(NSUInteger, DLLLayoutRelativeType) {
    DLLRelativeLeft,
    DLLRelativeRight,
    DLLRelativeTop,
    DLLRelativeBottom,
    DLLRelativeWidth,
    DLLRelativeHeight,
    DLLRelativeCenterX,
    DLLRelativeCenterY
};


struct DLLLayoutRelative {
    void *view;
    DLLLayoutRelativeType type;
};

typedef struct DLLLayoutRelative DLLLayoutRelative;

#endif /* DLLLayoutDefine_h */
