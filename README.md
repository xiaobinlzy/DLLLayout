# DLLLayout

[![CI Status](http://img.shields.io/travis/xiaobinlzy/DLLLayout.svg?style=flat)](https://travis-ci.org/xiaobinlzy/DLLLayout)
[![Version](https://img.shields.io/cocoapods/v/DLLLayout.svg?style=flat)](http://cocoapods.org/pods/DLLLayout)
[![License](https://img.shields.io/cocoapods/l/DLLLayout.svg?style=flat)](http://cocoapods.org/pods/DLLLayout)
[![Platform](https://img.shields.io/cocoapods/p/DLLLayout.svg?style=flat)](http://cocoapods.org/pods/DLLLayout)

## Introduce
DLLLayout 是一个基于 UIView.frame 的轻量级 iOS 布局框架。相比苹果的 AutoLayout，它有着更友善的 API 和更高的性能，虽然功能上不如 AutoLayout 大又全，比如不支持 greaterThan、lesserThan、priority 等，但也能够满足90%以上的业务场景。在性能上，如果需要通过视图内容自适应宽高（例如 UILabel、UIButton 根据内容计算宽高），布局耗时为苹果 AutoLayout 的 1/2 左右；反之如果设置了视图的宽高，布局耗时只有苹果 AutoLayout 的不到 1/8，并且能够兼容 UIView.transform。

## Theory
给 UIView 设置布局规则，通过 hook UIView.layoutSubviews，在这个方法里对设置过布局规则的视图设置 frame，实现布局功能。因为布局活动触发在系统的 layoutSubviews 之前，所以仍然可以通过重写子类的 layoutSubviews 来实现自己的布局。

## Example

克隆仓库后，在Example目录下先运行 `pod install`，就可以运行演示工程。

## Requirement
iOS 6.0 +

## Installation

DLLLayout 可以通过 [CocoaPods](http://cocoapods.org) 获得。 只需要在你的 Podfile 中添加如下代码：

```ruby
pod "DLLLayout"
```

## Usage
通常来说，一个视图的布局是一个矩形，**所以需要能够得到四条边的位置才能够进行布局**。但是一些视图，不如 UILabel、UIButton、UIImageView 等等，需要根据它们的内容来自动计算宽高，那么如果我们对这些视图不设置足够的条件，也会根据他们的内容自动计算出布局所用的宽高，不过这样会有一定的性能消耗。**如果不能够得到视图四边的位置，则会抛出异常。**
<br/>
在 UIView 实例化之后就可以对它设置布局规则，不需要像 AutoLayout 一样先加入到视图层级中再设置。

```Objective-C
	UIView *view = [[UIView alloc] init];
	// 给 view 设置布局规则
	[view dll_setLayout:^(DLLLayout *layout) {
		layout.width(100)	// 宽度100
		.height(50)	// 高度50
		.centerX(0)	// x轴在父视图居中 偏移量0
		.topMargin(50);	// 相对父视图顶边距50
	}];
```

也可以设置视图的相对依赖关系。**注意：只能依赖同一视图层级下的子视图，或者是自己的父、子视图。**

```Objective-C
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor redColor];
    UIView *leftInnerView = [[UIView alloc] init];
    leftInnerView.backgroundColor = [UIColor yellowColor];
    UIView *rightInnerView = [[UIView alloc] init];
    rightInnerView.backgroundColor = [UIColor blueColor];
    [containerView addSubview:leftInnerView];
    [containerView addSubview:rightInnerView];
    // containerView是父视图，leftInnerView和rightInnerView是两个子视图
    
    // 父视图宽度300，高度100，x和y都居中
    [containerView dll_setLayout:^(DLLLayout *layout) {
        layout.width(300)
        .height(100)
        .centerX(0)
        .centerY(0);
    }];
    
    // leftInnerView的宽度是父视图宽度的0.5倍少15，高度比父视图的高度少20，左边距10，y轴居中
    [leftInnerView dll_setLayout:^(DLLLayout *layout) {
        layout.relative.width.to(containerView.dll_width.multiple(0.5).offset(-15))
        .relative.height.to(containerView.dll_height.offset(-20))
        .leftMargin(10)
        .centerY(0);
    }];
    
    // leftInnerView的宽度是父视图宽度的0.5倍少15，高度比父视图的高度少20，右边距10，y轴居中
    [rightInnerView dll_setLayout:^(DLLLayout *layout) {
        layout.relative.width.to(containerView.dll_width.multiple(0.5).offset(-15))
        .relative.height.to(leftInnerView.dll_height)
        .rightMargin(10)
        .centerY(0);
    }];
```

在 UIViewAnimation 中，因为要实时更新视图的 frame，所以在使用 DLLLayout 更新布局规则之后，**需要手动调用 dll_updateFrame 方法来立即更新 frame。**

```Objective-C
    [UIView animateWithDuration:0.25 animations:^{
        [view dll_updateLayout:^(DLLLayout *layout) {
            layout.width(300);
        }];
        // 更新布局规则之后，手动调用dll_updateFrame方法，立即更新frame。
        [view dll_updateFrame];
    }];
```

## Feature
1. 比 Auto Layout 性能更高。
2. 支持 Affine Transform。

## Author

xiaobinlzy, xiaobinlzy@163.com

## License

DLLLayout is available under the MIT license. See the LICENSE file for more info.


## Update Log
##### 0.1.1
支持 UIView.transform。
