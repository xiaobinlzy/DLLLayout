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
