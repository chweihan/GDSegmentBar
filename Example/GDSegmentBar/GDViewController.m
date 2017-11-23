//
//  GDViewController.m
//  GDSegmentBar
//
//  Created by 327708740@qq.com on 11/22/2017.
//  Copyright (c) 2017 327708740@qq.com. All rights reserved.
//

#import "GDViewController.h"
#import "GDSegmentBar.h"

@interface GDViewController ()

@end

@implementation GDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    
    GDSegmentBar *segmentBar = [GDSegmentBar segmentBarWithFrame:CGRectMake(0, 64, width, 30)];
    segmentBar.backgroundColor = [UIColor greenColor];
    [self.view addSubview:segmentBar];
    
    segmentBar.items = @[@"专辑", @"声音", @"下载中", @"专辑", @"声音", @"下载中", @"专辑", @"声音", @"下载中", @"专辑", @"声音", @"下载中"];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
