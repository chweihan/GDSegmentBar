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

- (void)segmentBar:(GDSegmentBar *)segmentBar inIndex:(NSInteger)inIndex toIndex:(NSInteger)toIndex;

@end

@interface GDSegmentBar : UIView

+ (instancetype)segmentBarWithFrame:(CGRect)frame;

@property (nonatomic, strong) NSArray <NSString *>*items;

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, weak) id<GDSegmentBarDelegate> delegate;

@end
