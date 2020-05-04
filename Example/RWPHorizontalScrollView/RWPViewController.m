//
//  RWPViewController.m
//  RWPHorizontalScrollView
//
//  Created by rwpnyn@163.com on 05/04/2020.
//  Copyright (c) 2020 rwpnyn@163.com. All rights reserved.
//

#import "RWPViewController.h"

#import "RWPHorizontalScrollView.h"

#import "ItemView.h"

#import "ReactiveObjC.h"

#import "Masonry.h"

@interface RWPViewController ()

@end

@implementation RWPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
