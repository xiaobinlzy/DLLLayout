//
//  DLLViewController.m
//  DLLLayout
//
//  Created by xiaobinlzy on 07/18/2017.
//  Copyright (c) 2017 xiaobinlzy. All rights reserved.
//


#import "DLLViewController.h"
#import <DLLLayout/DLLLayout.h>
#import "DLLTableViewCell.h"
#import "DLLMarginViewController.h"
#import "DLLCenterViewController.h"


@interface DLLViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation DLLViewController {
    UITableView *_tableView;
    NSArray *_data;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请横竖屏切换";
    
    _data = @[@"边距", @"居中", @"Hello world.", @"Hello world.", @"Hello world.", @"Hello world.", @"Hello world.", @"Hello world.", @"Hello world.", @"Hello world.", @"Hello world."];
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView dll_setLayout:^(DLLLayout *layout) {
        layout.margin(UIEdgeInsetsZero);
    }];
    [self.view addSubview:_tableView];
}


#pragma mark - table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"DLLTableViewCell";
    DLLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[DLLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.text = _data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = nil;
    switch (indexPath.row) {
        case 0:
            viewController = [[DLLMarginViewController alloc] init];
            break;
        case 1:
            viewController = [[DLLCenterViewController alloc] init];
            break;
        
    }
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
