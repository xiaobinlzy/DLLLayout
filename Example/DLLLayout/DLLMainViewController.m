//
//  DLLMainViewController.m
//  DLLLayout
//
//  Created by xiaobinlzy on 07/18/2017.
//  Copyright (c) 2017 xiaobinlzy. All rights reserved.
//


#import "DLLMainViewController.h"
#import <DLLLayout/DLLLayout.h>
#import "DLLTableViewCell.h"
#import "DLLMarginViewController.h"
#import "DLLCenterViewController.h"
#import "DLLListViewController.h"
#import "DLLCycleRelativeViewController.h"
#import "DLLAnimationViewController.h"
#import "DLLAffineTransformViewController.h"
#import "DLLAutoLayoutViewController.h"


@interface DLLMainViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation DLLMainViewController {
    UITableView *_tableView;
    NSArray *_data;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请横竖屏切换";
    
    _data = @[@"边距", @"居中", @"列表", @"循环依赖", @"视图动画", @"仿射变换", @"兼容自动布局"];
    
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
        case 2:
            viewController = [[DLLListViewController alloc] init];
            break;
        case 3:
            viewController = [[DLLCycleRelativeViewController alloc] init];
            break;
        case 4:
            viewController = [[DLLAnimationViewController alloc] init];
            break;
        case 5:
            viewController = [[DLLAffineTransformViewController alloc] init];
            break;
        case 6:
            viewController = [[DLLAutoLayoutViewController alloc] init];
            break;
    }
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
