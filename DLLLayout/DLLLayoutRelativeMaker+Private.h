//
//  DLLLayoutRelativeMaker+Private.h
//  Pods
//
//  Created by DLL on 2017/7/20.
//
//

#import <DLLLayout/DLLLayout.h>


@interface DLLLayoutRelativeMaker ()


@property (strong, nonatomic, readonly) DLLLayoutRelativeBridge *bridge;

@end



@interface DLLLayoutRelativeBridge ()


@property (assign, nonatomic) DLLLayoutRelativeType type;

@property (assign, nonatomic) DLLLayout *layout;

@end
