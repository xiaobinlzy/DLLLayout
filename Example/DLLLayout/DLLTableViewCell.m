//
//  DLLTableViewCell.m
//  DLLLayout
//
//  Created by DLL on 2017/7/27.
//  Copyright © 2017年 xiaobinlzy. All rights reserved.
//

#import "DLLTableViewCell.h"
#import <DLLLayout/DLLLayout.h>

@implementation DLLTableViewCell {
    UILabel *_textLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _textLabel = [[UILabel alloc] init];
        [_textLabel dll_setLayout:^(DLLLayout *layout) {
            layout.centerY(0)
            .leftMargin(20)
            .rightMargin(20);
        }];
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

- (void)setText:(NSString *)text {
    _textLabel.text = text;
}

- (NSString *)text {
    return _textLabel.text;
}

@end
