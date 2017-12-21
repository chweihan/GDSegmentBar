//
//  GDSegmentViewController.m
//  GDSegmentBar_Example
//
//  Created by 陈伟涵 on 2017/11/27.
//  Copyright © 2017年 327708740@qq.com. All rights reserved.
//

#import "GDSegmentViewController.h"
#import "GDSegmentBar.h"
#import "UIView+GDSegmentBar.h"

@interface GDSegmentViewController ()<GDSegmentBarDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) GDSegmentBar *segmentBar;

@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation GDSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;

}

#pragma mark - public
- (void)setUpWithItems:(NSArray<NSString *> *)items childVCs:(NSArray<UIViewController *> *)childVCs {
    NSAssert(items.count != 0 || items.count != childVCs.count, @"个数不一致，请检查");
    
    self.segmentBar.items = items;
    
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];

    // 添加几个自控制器
    // 在chontentView，展示子控制器的视图内容
    for (UIViewController *vc in childVCs) {
        [self addChildViewController:vc];
    }
    
    self.contentView.contentSize = CGSizeMake(items.count * self.view.width, 0);
    
    self.segmentBar.selectIndex = 0;
}

- (void)showChildVCViewAtIndex:(NSInteger)index {
    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count - 1) {
        return;
    }
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.contentView.width, 0, self.contentView.width, self.contentView.height);
    [self.contentView addSubview:vc.view];
    
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.width, 0)];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    
    self.segmentBar.frame = CGRectMake(0, 60, self.view.width, 35);
    
    CGFloat contentViewY = self.segmentBar.y + self.segmentBar.height;
    CGRect contentFrame = CGRectMake(0, contentViewY, self.view.width, self.view.height - contentViewY);
    self.contentView.frame = contentFrame;
}

#pragma mark - 选项卡代理方法
- (void)segmentBar:(GDSegmentBar *)segmentBar inIndex:(NSInteger)inIndex toIndex:(NSInteger)toIndex {
    NSLog(@"%zd----%zd", inIndex, toIndex);
    [self showChildVCViewAtIndex:toIndex];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 计算最后的索引
    NSInteger index = self.contentView.contentOffset.x / self.contentView.width;
    
    self.segmentBar.selectIndex = index;
}



#pragma mark - lazy
- (GDSegmentBar *)segmentBar {
    if (!_segmentBar) {
        GDSegmentBar *segmentBar = [GDSegmentBar segmentBarWithFrame:CGRectZero];
        segmentBar.delegate = self;
        segmentBar.backgroundColor = [UIColor greenColor];
        [self.view addSubview:segmentBar];
        _segmentBar = segmentBar;
    }
    return _segmentBar;
}

- (UIScrollView *)contentView {
    if (_contentView == nil) {
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.delegate = self;
        contentView.pagingEnabled = YES;
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

@end
