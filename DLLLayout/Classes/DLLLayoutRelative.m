//
//  DLLLayoutRelative.m
//  Pods
//
//  Created by DLL on 2017/8/3.
//
//

#import "DLLLayoutRelative+Private.h"

@implementation DLLLayoutRelative

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.multipleValue = 1;
        
        DLLLayoutRelative __weak *weakSelf = self;
        _offset = ^DLLLayoutRelative *(CGFloat offset) {
            weakSelf.offsetValue = offset;
            return weakSelf;
        };
        
        _multiple = ^DLLLayoutRelative *(CGFloat multiple) {
            weakSelf.multipleValue = multiple;
            return weakSelf;
        };
        
        _regulation = ^DLLLayoutRelative *(CGFloat regulation) {
            weakSelf.regulationValue = regulation;
            return weakSelf;
        };
    }
    return self;
}

@end
