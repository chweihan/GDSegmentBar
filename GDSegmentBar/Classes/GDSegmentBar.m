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
{
    UIButton *_lastBtn;
}

@property (nonatomic, weak) UIScrollView *contentView;

@property (nonatomic, strong) NSMutableArray <UIButton *>*itemBtns;

@property (nonatomic, strong) UIView *indicatorView;

@end


@implementation GDSegmentBar

+ (instancetype)segmentBarWithFrame:(CGRect)frame {
    GDSegmentBar *segmentBar = [[GDSegmentBar alloc] initWithFrame:frame];
    return segmentBar;
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    
    //数据过滤
    if (self.itemBtns.count == 0 || selectIndex < 0 || selectIndex > self.itemBtns.count - 1) {
        return;
    }

    _selectIndex = selectIndex;
    
    UIButton *btn = self.itemBtns[selectIndex];
    
    [self btnClick:btn];
}


- (void)setItems:(NSArray<NSString *> *)items {
    _items = items;
    
    //删除之前添加过多的组件
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    //根据所有的选项数据源,创建button，添加到内容视图
    for (NSString *item in items) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = self.itemBtns.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setTitle:item forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
    }
    
    //手动刷新布局
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - private
- (void)btnClick:(UIButton *)btn {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentBar:inIndex:toIndex:)]) {
        [self.delegate segmentBar:self inIndex:_lastBtn.tag toIndex:btn.tag];
    }
    
    _lastBtn.selected = NO;
    btn.selected = YES;
    _lastBtn = btn;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.width = btn.width;
        self.indicatorView.centerX = btn.centerX;
    }];
    
    CGFloat scrollX = btn.centerX - self.contentView.width * 0.5;
    
    if (scrollX < 0) {
        scrollX = 0;
    }
    
    if (scrollX > self.contentView.contentSize.width - self.contentView.width) {
        scrollX = self.contentView.contentSize.width - self.contentView.width;
    }
    
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];

}

#pragma mark - 布局
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
    
    if (self.itemBtns.count == 0) {
        return;
    }
    UIButton *btn = self.itemBtns[self.selectIndex];
    self.indicatorView.width = btn.width;
    self.indicatorView.centerX = btn.centerX;
    self.indicatorView.y = self.height - self.indicatorView.height;

}

#pragma mark - lazy
- (NSMutableArray<UIButton *> *)itemBtns {
    if (_itemBtns == nil) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}

- (UIView *)indicatorView {
    if (_indicatorView == nil) {
        CGFloat indicatorH = 2;
        UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - indicatorH, 0, indicatorH)];
        indicatorView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}

- (UIScrollView *)contentView {
    if (_contentView == nil) {
        //创建内容承载视图
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        _contentView = scrollView;
    }
    return _contentView;
}



@end
