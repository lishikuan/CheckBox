//
//  NotificationCenterDetailVC.m
//  CheckBox
//
//  Created by lsm on 16/12/25.
//  Copyright © 2016年 lsm. All rights reserved.
//

#import "NotificationCenterDetailVC.h"

@interface NotificationCenterDetailVC ()<UIScrollViewDelegate>
{
    UIScrollView * myScrollView;
    UITextView * mainTextView;
}


@end

@implementation NotificationCenterDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //自定义tablebar
    UILabel * label = [[UILabel alloc]init];
    [label setText:@"消息详情"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [label setFrame:CGRectMake(0, 0, 100, 40)];
    [label setFont:[UIFont systemFontOfSize:18 weight:20]];
    self.navigationItem.titleView = label;
    //左侧按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnMethod)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //tablebar背景色
    [self.navigationController.navigationBar setBarTintColor:NavigationBarTintColor];
    [self.tabBarController.tabBar setHidden:YES];
    
    //添加视图
    [self addContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - mark custom methods
- (void)backBtnMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addContentView
{
    //清除小红点，标记所有已读
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CustomXiTongXiaoXi"];
    
    myScrollView = [[UIScrollView alloc]init];
    [myScrollView setBackgroundColor:[UIColor whiteColor]];
    [myScrollView setFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    myScrollView.delegate = self;
    myScrollView.scrollEnabled = YES;
    int viewX = 20;
    int viewY = 20;
    int viewHeight = 30;
    int mainTextViewHeight = HEIGHT/2;
    //标题
    UILabel * titleLabel = [[UILabel alloc]init];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor hexStringToColor:@"333333"]];
    if ([[self.userInfo allKeys] containsObject:@"title"]) {
        [titleLabel setText:self.userInfo[@"title"]];
    }else{
        
        [titleLabel setText:@""];
    }
    
    [titleLabel setFrame:CGRectMake(viewX, viewY, WIDTH-viewX*2, viewHeight-10)];
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    [titleLabel setNumberOfLines:0];
    [titleLabel setAdjustsFontSizeToFitWidth:YES];
    
    //日期
    UILabel * timeLabel = [[UILabel alloc]init];
    [timeLabel setTextAlignment:NSTextAlignmentCenter];
    [timeLabel setTextColor:[UIColor hexStringToColor:@"666666"]];
    if ([[self.userInfo allKeys]containsObject:@"createdTime"]) {
        [timeLabel setText:[NSString stringWithFormat:@"%@",self.userInfo[@"createdTime"]]];
        
    }else{
        [timeLabel setText:[NSString stringWithFormat:@""]];
    }
    
    [timeLabel setFrame:CGRectMake(viewX, viewY+viewHeight-10, WIDTH-viewX*2, viewHeight)];
    [timeLabel setFont:[UIFont systemFontOfSize:14]];
    [timeLabel setNumberOfLines:0];
    [timeLabel setAdjustsFontSizeToFitWidth:YES];
    
    //分割线
    UILabel * lineLabel = [[UILabel alloc]init];
    [lineLabel setTextAlignment:NSTextAlignmentLeft];
    [lineLabel setBackgroundColor:[UIColor hexStringToColor:@"#f0eff5"]];
    [lineLabel setFrame:CGRectMake(viewX, viewY+viewHeight*2, WIDTH-viewX*2, 1)];
    
    //内容
    mainTextView = [[UITextView alloc]init];
    if ([[self.userInfo allKeys] containsObject:@"content"]) {
        [mainTextView setText:self.userInfo[@"content"]];
    }else{
        
        [mainTextView setText:@""];
    }
    
    mainTextView.textColor=[UIColor grayColor];
    [mainTextView setFont:[UIFont systemFontOfSize:14]];
    [mainTextView setFrame:CGRectMake(viewX, viewY+viewHeight*2+4, WIDTH-viewX*2, mainTextViewHeight)];
    mainTextView.editable = NO;
    
    
    [myScrollView addSubview:titleLabel];
    [myScrollView addSubview:timeLabel];
    [myScrollView addSubview:lineLabel];
    [myScrollView addSubview:mainTextView];
    [self.view addSubview:myScrollView];
    
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
