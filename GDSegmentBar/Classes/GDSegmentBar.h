//
//  GDSegmentBar.h
//  GDSegmentBar
//
//  Created by 陈伟涵 on 2017/11/21.
//  Copyright © 2017年 cweihan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GDSegmentBar;

@protocol GDSegmentBarDelegate <NSObject>


/**
 代理方法，告诉外界，内部的点击数据

 @param segmentBar segmentBar
 @param inIndex 选中的索引
 @param toIndex 上一个索引
 */
- (void)segmentBar:(GDSegmentBar *)segmentBar inIndex:(NSInteger)inIndex toIndex:(NSInteger)toIndex;

@end

@interface GDSegmentBar : UIView


/**
 快速创建方法

 @param frame frame
 @return segmentBar
 */
+ (instancetype)segmentBarWithFrame:(CGRect)frame;


/** 代理 */
@property (nonatomic, weak) id<GDSegmentBarDelegate> delegate;

/** 数据源 */
@property (nonatomic, strong) NSArray <NSString *>*items;

/** 当前选中的索引 */
@property (nonatomic, assign) NSInteger selectIndex;

@end
