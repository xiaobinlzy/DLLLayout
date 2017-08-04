//
//  DLLLayoutRelative.h
//  Pods
//
//  Created by DLL on 2017/8/3.
//
//

#import <Foundation/Foundation.h>

@interface DLLLayoutRelative : NSObject

@property (readonly, nonatomic) DLLLayoutRelative *(^offset)(CGFloat offset);

@property (readonly, nonatomic) DLLLayoutRelative *(^multiple)(CGFloat multi);

@property (readonly, nonatomic) DLLLayoutRelative *(^regulation)(CGFloat value);

@end
