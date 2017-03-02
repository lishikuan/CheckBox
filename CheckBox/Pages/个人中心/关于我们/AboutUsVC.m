//
//  AboutUsVC.m
//  CheckBox
//
//  Created by lsm on 16/12/25.
//  Copyright © 2016年 lsm. All rights reserved.
//

#import "AboutUsVC.h"

@interface AboutUsVC ()<UITableViewDataSource,UITableViewDelegate>
{
    int width;
    int height;
    UITableView * listView;
}

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //自定义tablebar
    UILabel * label = [[UILabel alloc]init];
    [label setText:@"关于我们"];
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
    self.automaticallyAdjustsScrollViewInsets = NO;
    listView = [[UITableView alloc]init];
    [listView setFrame:CGRectMake(0, 64, WIDTH, HEIGHT)];
    listView.dataSource = self;
    listView.delegate = self;
    [self.view addSubview:listView];
    [listView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //设置headerVIew
    UIView *view=[[UIView alloc] init];
    [view setFrame:CGRectMake(0, 0, WIDTH, 294/2)];
    [view setBackgroundColor:[UIColor whiteColor]];
    UIImageView * headerImageView = [[UIImageView alloc]init];
    headerImageView.frame=CGRectMake(WIDTH/2-113,56/2, 226, 90);
    //headerImageView重用
    [headerImageView setBackgroundColor:[UIColor whiteColor]];
    [headerImageView setImage:[UIImage imageNamed:@"banner"]];
    [view addSubview:headerImageView];
    [listView setTableHeaderView:view];
    //隐藏多余tablewviewcell
    [self setExtraCellLineHidden:listView];

}
#pragma listView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 294/2;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view=[[UIView alloc] init];
//    UIImageView * headerImageView = [[UIImageView alloc]init];
//    headerImageView.frame=CGRectMake(WIDTH/2-113,56/2, 226, 90);
//    //headerImageView重用
//    [headerImageView setBackgroundColor:[UIColor whiteColor]];
//    [headerImageView setImage:[UIImage imageNamed:@"banner"]];
//    [view addSubview:headerImageView];
//    return view;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.section];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]init];
        
        if (indexPath.row == 0) {
            UILabel * titleLabel = [[UILabel alloc] init];
            [titleLabel setTag:1001];
            
            UITextView * textView = [[UITextView alloc]init];
            textView.tag = 1002;
            
            [cell.contentView addSubview:titleLabel];
            [cell.contentView addSubview:textView];

        }
        if (indexPath.row == 1) {
            UILabel * versionLabel = [[UILabel alloc]init];
            versionLabel.tag = 1003;
            
            UILabel * companyLabel = [[UILabel alloc]init];
            companyLabel.tag = 1004;
            
            [cell.contentView addSubview:versionLabel];
            [cell.contentView addSubview:companyLabel];
        }
        
    }
    //cell重用
    if (indexPath.row == 0) {
        UILabel * titleLabel = (UILabel *)[cell viewWithTag:1001];
        [titleLabel setFrame:CGRectMake(0, 0, WIDTH, 32/2)];
        [titleLabel setFont:maxTextFont];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setText:@"“世舶会”----中华网旗下的海外购物平台"];
        [titleLabel setTextColor:[UIColor hexStringToColor:@"333333"]];
        
        UITextView * textView = (UITextView *)[cell viewWithTag:1002];
        [textView setFrame:CGRectMake(18/2, 32/2, WIDTH-18/2*2, HEIGHT-294/2-134/2-64-32/2)];
        [textView setFont:midTextFont];
        [textView setText:@"中华网旗下的海外购物平台中华网旗下的海外购物平台中华网旗下的海外购物平台中华网旗下的海外购物平台中华网旗下的海外购物平台中华网旗下的海外购物平台"];
        [textView setTextColor:[UIColor hexStringToColor:@"333333"]];
    }
    if (indexPath.row == 1) {
        UILabel * versionLabel = (UILabel *)[cell viewWithTag:1003];
        [versionLabel setFrame:CGRectMake(0, 0, WIDTH, 24/2)];
        [versionLabel setFont:midTextFont];
        [versionLabel setTextAlignment:NSTextAlignmentCenter];
        [versionLabel setText:@"版本号：1.0.1"];
        
        UILabel * companyLabel = (UILabel *)[cell viewWithTag:1004];
        [companyLabel setFrame:CGRectMake(0, 24/2+26/2, WIDTH, 18/2)];
        [companyLabel setFont:minTextFont];
        [companyLabel setTextAlignment:NSTextAlignmentCenter];
        [companyLabel setText:@"Copyright@2016 河南黑马科技有限公司 版权所有"];

    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return HEIGHT-294/2-134/2-64;
    }else if (indexPath.row == 1){
        return 134/2;
    }else{
        return 0;
    }
}
#pragma - mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//隐藏多余tableviewcell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

@end
