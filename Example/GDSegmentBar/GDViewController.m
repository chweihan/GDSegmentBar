//
//  GDViewController.m
//  GDSegmentBar
//
//  Created by 327708740@qq.com on 11/22/2017.
//  Copyright (c) 2017 327708740@qq.com. All rights reserved.
//

#import "GDViewController.h"
#import "GDSegmentBar.h"

@interface GDViewController ()<GDSegmentBarDelegate>

@property (nonatomic, weak) GDSegmentBar *segmentBar;

@end

@implementation GDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    self.segmentBar.items = @[@"专辑", @"声音", @"下载中", @"专辑", @"声音", @"下载中", @"专辑", @"声音", @"下载中", @"专辑", @"声音", @"下载中"];



    
}

#pragma mark - GDSegmentBarDelegate
- (void)segmentBar:(GDSegmentBar *)segmentBar inIndex:(NSInteger)inIndex toIndex:(NSInteger)toIndex {
    
    NSLog(@"inIndex -- %zd toIndex -- %zd",inIndex,toIndex);
    
}

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.segmentBar.selectIndex = 3;
}

#pragma mark - lazy
- (GDSegmentBar *)segmentBar {
    if (_segmentBar == nil) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        GDSegmentBar *segmentBar = [GDSegmentBar segmentBarWithFrame:CGRectMake(0, 64, width, 30)];
        segmentBar.backgroundColor = [UIColor greenColor];
        segmentBar.delegate = self;
        [self.view addSubview:segmentBar];
        _segmentBar = segmentBar;
    }
    return _segmentBar;
}

@end
