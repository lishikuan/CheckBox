//
//  MyTabBarController.m
//  CheckBox
//
//  Created by lsm on 16/12/25.
//  Copyright © 2016年 lsm. All rights reserved.
//

#import "MyTabBarController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UITabBar appearance].translucent = NO;
    UITabBar *tabBar = self.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    // 对item设置相应地图片
    item0.tag = 0;
    item0.selectedImage = [[UIImage imageNamed:@"主页点击后"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item0.image = [[UIImage imageNamed:@"首页点击前"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.title = @"首页";
    item0.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    item1.tag = 1;
    item1.selectedImage = [[UIImage imageNamed:@"我的点击后"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item1.image = [[UIImage imageNamed:@"我的点击前"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.title = @"我的";
    item1.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [item setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    item0.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    if (item.tag == 0) {
        item.selectedImage = [[UIImage imageNamed:@"主页点击后"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
        item.image = [[UIImage imageNamed:@"首页点击前"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.title = @"首页";
        item.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }else if (item.tag == 1) {
        item.selectedImage = [[UIImage imageNamed:@"我的点击后"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
        item.image = [[UIImage imageNamed:@"我的点击前"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.title = @"我的";
        item.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
