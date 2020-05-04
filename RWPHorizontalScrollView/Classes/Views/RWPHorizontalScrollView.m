//
//  RWPHorizontalScrollView.m
//  FBSnapshotTestCase
//
//  Created by a on 2020/5/4.
//

#import "RWPHorizontalScrollView.h"

#import "ReactiveObjC.h"

#import "Masonry.h"

@interface RWPHorizontalScrollView ()

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *scrollContentViewBg;

@property (strong, nonatomic) UIView *scrollContentView;

@property (assign, nonatomic) CGFloat contentW;

@end

@implementation RWPHorizontalScrollView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self __init];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self __init];
}

- (void)__init {
    [self addViews];
    [self makeLayouts];
    [self bindSignals];
}

- (void)addViews {
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.scrollContentViewBg];
    [self.scrollContentViewBg addSubview:self.scrollContentView];
}

- (void)makeLayouts {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [self.scrollContentViewBg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.scrollView.mas_height);
        make.edges.mas_equalTo(self.scrollView);
    }];
}

- (void)bindSignals {
    @weakify(self)
    [RACObserve(self, itemViews) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self refreshItems];
    }];
    [RACObserve(self, contentInsets) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self reMakeContentView];
    }];
}

- (void)refreshItems {
    for (UIView *v in self.scrollContentView.subviews) {
        [v removeFromSuperview];
    }
    
    self.contentW = 0;
    for (NSInteger index=0; index<self.itemViews.count; index++) {
        
        UIControl *itemView = [[UIControl alloc] init];
        itemView.backgroundColor = [UIColor clearColor];
        itemView.tag = index;
        @weakify(self)
        [[itemView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.clickAtIndex) {
                self.clickAtIndex(x.tag);
            }
        }];
        
        UIView<RWPHorizontalViewProtocol> *itemContent = self.itemViews[index];
        
        [self.scrollContentView addSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(self.contentW);
            make.width.mas_equalTo(itemContent.contentWidth);
        }];
        
        [itemView addSubview:itemContent];
        [itemContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(itemContent.contentInsets.left);
            make.top.mas_equalTo(itemContent.contentInsets.top);
            make.right.mas_equalTo(-itemContent.contentInsets.right);
            make.bottom.mas_equalTo(-itemContent.contentInsets.bottom);
        }];
    
        self.contentW += itemContent.contentWidth;
    }
    
    [self reMakeContentView];
}

- (void)reMakeContentView {
    [self.scrollContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentInsets.top);
        make.left.mas_equalTo(self.contentInsets.left);
        make.right.mas_equalTo(-self.contentInsets.right);
        make.bottom.mas_equalTo(-self.contentInsets.bottom);
        make.width.mas_equalTo(self.contentW);
    }];
}

#pragma mark - getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
    }
    return _scrollView;
}

- (UIView *)scrollContentViewBg {
    if (!_scrollContentViewBg) {
        _scrollContentViewBg = [[UIView alloc] init];
        _scrollContentViewBg.backgroundColor = [UIColor clearColor];
    }
    return _scrollContentViewBg;
}

- (UIView *)scrollContentView {
    if (!_scrollContentView) {
        _scrollContentView = [[UIView alloc] init];
        _scrollContentView.clipsToBounds = YES;
        _scrollContentView.backgroundColor = [UIColor clearColor];
    }
    return _scrollContentView;
}


@end
