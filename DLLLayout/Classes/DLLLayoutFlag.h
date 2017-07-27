//
//  DLLLayoutFlag.h
//  Pods
//
//  Created by DLL on 2017/7/21.
//
//

#ifndef DLLLayoutFlag_h
#define DLLLayoutFlag_h


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



#endif /* DLLLayoutFlag_h */
