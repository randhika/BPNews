//
//  MainViewController.m
//  BPNews
//
//  Created by bingcai on 16/1/16.
//  Copyright © 2016年 bingcai. All rights reserved.
//

#import "MainViewController.h"
#import "Utility.h"
#import "Config.h"
#import "BPTitleLabel.h"
#import "BPTableViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController {

    UIScrollView *smallScrollView;
    UIScrollView *bigScrollView;
    NSArray *arrayLists;
}

#pragma mark - ******************** 懒加载
- (NSArray *)contentList {

    if (arrayLists == nil) {
        arrayLists = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLs" ofType:@"plist"]];
    }
    return arrayLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = BARIMAGE(@"top_navi_bell_normal", @selector(headLine));
    self.navigationItem.rightBarButtonItem = BARIMAGE(@"top_navigation_square", @selector(search));
    
    smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, BP_SCREEN_WIDTH, 40)];
    smallScrollView.showsHorizontalScrollIndicator = NO;
    smallScrollView.showsVerticalScrollIndicator = NO;

    [self.view addSubview:smallScrollView];

    
    bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, BP_SCREEN_HEIGHT - 128, BP_SCREEN_WIDTH, 128)];
//    bigScrollView.delegate = self;
    [self.view addSubview:bigScrollView];
    
    [self addController];
    [self addLabel];
    
    CGFloat contentX = self.childViewControllers.count * BP_SCREEN_WIDTH;
    bigScrollView.contentSize = CGSizeMake(contentX, 0);
    bigScrollView.pagingEnabled = YES;
}

- (void) headLine {}
- (void) search {}

- (void) addController {

    for (int i = 0; i < self.contentList.count; i ++) {
        BPTableViewController *vc = [[BPTableViewController alloc] init];
        vc.title = arrayLists[i][@"title"];
        [self addChildViewController:vc];
    }
}

- (void) addLabel {

    for (int i = 0; i < 8; i ++) {
        CGFloat lblW = 70;
        CGFloat lblH = 40;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
        
        BPTitleLabel *label = [[BPTitleLabel alloc] init];
        UIViewController *vc = self.childViewControllers[i];
        label.text = vc.title;
        label.frame = CGRectMake(lblX, lblY, lblW, lblH);
        label.font = [UIFont fontWithName:@"HYQiHei" size:19];
//        label.font = [UIFont systemFontOfSize:19];
        
        [smallScrollView addSubview:label];
        label.tag = i;
        label.userInteractionEnabled = YES;
        
    }
    smallScrollView.contentSize = CGSizeMake(70 * 8, 0);
}

@end