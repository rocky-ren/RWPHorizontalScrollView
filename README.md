# RWPHorizontalScrollView

[![CI Status](https://img.shields.io/travis/rwpnyn@163.com/RWPHorizontalScrollView.svg?style=flat)](https://travis-ci.org/rwpnyn@163.com/RWPHorizontalScrollView)
[![Version](https://img.shields.io/cocoapods/v/RWPHorizontalScrollView.svg?style=flat)](https://cocoapods.org/pods/RWPHorizontalScrollView)
[![License](https://img.shields.io/cocoapods/l/RWPHorizontalScrollView.svg?style=flat)](https://cocoapods.org/pods/RWPHorizontalScrollView)
[![Platform](https://img.shields.io/cocoapods/p/RWPHorizontalScrollView.svg?style=flat)](https://cocoapods.org/pods/RWPHorizontalScrollView)

## Example
// 横向滚动的试图，可高度自定义，使用方便；但无复用机制，数据量多请慎用


// 新建一个View，并实现代理方法
#import "RWPHorizontalScrollView.h"

@interface ItemView : UIView <RWPHorizontalViewProtocol>

@end

#import "ItemView.h"

@implementation ItemView

- (CGFloat)contentWidth {
    return 200;
}

- (UIEdgeInsets)contentInsets {
    return UIEdgeInsetsMake(0, 0, 0, 10);
}

@end



RWPHorizontalScrollView *horizontalScrollView = [[RWPHorizontalScrollView alloc] init];
horizontalScrollView.backgroundColor = [UIColor whiteColor];
horizontalScrollView.contentInsets = UIEdgeInsetsMake(10, 10, 10, 0);

[self.view addSubview:horizontalScrollView];
[horizontalScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.mas_equalTo(0);
    make.top.mas_equalTo(100);
    make.height.mas_equalTo(200);
}];

NSMutableArray *items = [NSMutableArray array];
for (int i=0; i<10; i++) {
    ItemView *itemV = [[ItemView alloc] init];
    itemV.backgroundColor = [UIColor redColor];
    itemV.userInteractionEnabled = NO;
    [items addObject:itemV];
}

horizontalScrollView.itemViews = items;

[horizontalScrollView setClickAtIndex:^(NSInteger index) {
    
}];



## Requirements

## Installation

RWPHorizontalScrollView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RWPHorizontalScrollView'
```

## Author

rwpnyn@163.com, rwpnyn@163.com

## License

RWPHorizontalScrollView is available under the MIT license. See the LICENSE file for more info.
