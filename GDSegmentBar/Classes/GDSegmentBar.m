//
//  GDSegmentBar.m
//  GDSegmentBar
//
//  Created by 陈伟涵 on 2017/11/21.
//  Copyright © 2017年 cweihan. All rights reserved.
//

#import "GDSegmentBar.h"
#import "UIView+GDSegmentBar.h"

#define kMinMargin 30

@interface GDSegmentBar()

@property (nonatomic, weak) UIScrollView *contentView;

@property (nonatomic, strong) NSMutableArray <UIButton *>*itemBtns;

@end


@implementation GDSegmentBar

+ (instancetype)segmentBarWithFrame:(CGRect)frame {
    
    GDSegmentBar *segmentBar = [[GDSegmentBar alloc] initWithFrame:frame];
    
    //创建内容承载视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.showsHorizontalScrollIndicator = NO;
    [segmentBar addSubview:scrollView];
    segmentBar.contentView = scrollView;
    
    return segmentBar;
}

- (void)setItems:(NSArray<NSString *> *)items {
    _items = items;
    
    //删除之前添加过多的组件
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    //根据所有的选项数据源,创建button，添加到内容视图
    for (NSString *item in items) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:item forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
    }
    
    //手动刷新布局
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    
    //计算margin
    CGFloat totalBtnWidth = 0;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        totalBtnWidth += btn.width;
    }
    
    CGFloat caculateMargin = (self.width - totalBtnWidth) / (self.itemBtns.count + 1);
    if (caculateMargin < kMinMargin) {
        caculateMargin = kMinMargin;
    }
    
    CGFloat lastX = caculateMargin;
    for (UIButton *btn in self.itemBtns) {
        // w,h
        [btn sizeToFit];
        
        btn.y = 0;
        btn.x = lastX;
        
        lastX += btn.width + caculateMargin;
    }
    self.contentView.contentSize = CGSizeMake(lastX, 0);

    
}


#pragma mark - lazy
- (NSMutableArray<UIButton *> *)itemBtns {
    if (_itemBtns == nil) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}




@end
