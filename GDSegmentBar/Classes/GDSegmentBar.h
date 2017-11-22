//
//  GDSegmentBar.h
//  GDSegmentBar
//
//  Created by 陈伟涵 on 2017/11/21.
//  Copyright © 2017年 cweihan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDSegmentBar : UIView

+ (instancetype)segmentBarWithFrame:(CGRect)frame;

@property (nonatomic, strong) NSArray <NSString *>*items;

@end
