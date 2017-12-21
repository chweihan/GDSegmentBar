//
//  GDViewController.m
//  GDSegmentBar
//
//  Created by 327708740@qq.com on 11/22/2017.
//  Copyright (c) 2017 327708740@qq.com. All rights reserved.
//

#import "GDViewController.h"
#import "GDSegmentViewController.h"

@interface GDViewController ()

@property (nonatomic, weak) GDSegmentViewController *segmentVC;

@end

@implementation GDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    
    NSArray *items = @[@"专辑", @"声音", @"下载中"];

    // 添加几个自控制器
    // 在contentView, 展示子控制器的视图内容
    
    UIViewController *vc1 = [UIViewController new];
    vc1.view.backgroundColor = [UIColor redColor];
    
    UIViewController *vc2 = [UIViewController new];
    vc2.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *vc3 = [UIViewController new];
    vc3.view.backgroundColor = [UIColor yellowColor];
    
    
    [self.segmentVC setUpWithItems:items childVCs:@[vc1, vc2, vc3]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *items = @[@"专辑专辑", @"声xxx音", @"下载中xxxx", @"下载中xxxx", @"下载中xxxx"];
        
        // 添加几个自控制器
        // 在contentView, 展示子控制器的视图内容
        
        UIViewController *vc1 = [UIViewController new];
        vc1.view.backgroundColor = [UIColor redColor];
        
        UIViewController *vc2 = [UIViewController new];
        vc2.view.backgroundColor = [UIColor greenColor];
        
        UIViewController *vc3 = [UIViewController new];
        vc3.view.backgroundColor = [UIColor yellowColor];
        
        UIViewController *vc4 = [UIViewController new];
        vc4.view.backgroundColor = [UIColor greenColor];
        
        UIViewController *vc5 = [UIViewController new];
        vc5.view.backgroundColor = [UIColor yellowColor];
        
        
        [self.segmentVC setUpWithItems:items childVCs:@[vc1, vc2, vc3, vc4, vc5]];
        
        
    });
    
    
    
    
}

#pragma mark - lazy
- (GDSegmentViewController *)segmentVC {
    if (_segmentVC == nil) {
        GDSegmentViewController *vc = [[GDSegmentViewController alloc] init];
        [self addChildViewController:vc];
        _segmentVC = vc;
    }
    return _segmentVC;
}


@end
