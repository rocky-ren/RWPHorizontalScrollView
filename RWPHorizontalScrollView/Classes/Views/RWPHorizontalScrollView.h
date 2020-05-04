//
//  RWPHorizontalScrollView.h
//  FBSnapshotTestCase
//
//  Created by a on 2020/5/4.
//

#import <UIKit/UIKit.h>

@protocol RWPHorizontalViewProtocol <NSObject>

@optional
/// 内容边距
- (UIEdgeInsets)contentInsets;

@required
/// 宽度
- (CGFloat)contentWidth;

@end


@interface RWPHorizontalScrollView : UIView

@property (strong, nonatomic) NSArray<UIView<RWPHorizontalViewProtocol> *> *itemViews;

/// 内容边距设置
@property (assign, nonatomic) UIEdgeInsets contentInsets;

/// 点击回调
@property (copy, nonatomic) void(^clickAtIndex)(NSInteger index);

@end

