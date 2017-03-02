//
//  MeSettingTableViewController.m
//  BobcareCustomPage19
//
//  Created by lishikuan on 15/7/7.
//  Copyright (c) 2015年 com.01wisdom. All rights reserved.
//

#import "MeSettingTableViewController.h"
#import "PersonalInfoVC.h"
#import "MeSettingChangePasswordViewController.h"

#import "JFProgressHUD.h"
@interface MeSettingTableViewController ()<UIActionSheetDelegate>
{
    int width;
    int height;
    //
    NSString * xiaoxiString;//存储是否开启消息提醒
}
@end

@implementation MeSettingTableViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //自定义tablebar
    UILabel * label = [[UILabel alloc]init];
    [label setText:@"个人设置"];
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
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)backBtnMethod
{
    //返回
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) viewDidLayoutSubviews {
    CGRect viewBounds = self.view.bounds;
    CGFloat topBarOffset = self.topLayoutGuide.length;
    viewBounds.origin.y = topBarOffset*-1;
    self.view.bounds = viewBounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    [self setExtraCellLineHidden:self.tableView];
     NSString * remoteNotificationFlag = [[NSUserDefaults  standardUserDefaults]objectForKey:@"remoteNotificationFlag"];
    if ([remoteNotificationFlag isEqualToString:@"1"]) {
        xiaoxiFlag = 1;
        xiaoxiString = @"1";
    }else{
        xiaoxiFlag = 0;
        xiaoxiString = @"0";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 1;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else if (section == 1) {
        return 10;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]init];
        [cell.textLabel setFont:midTextFont];
        [cell.textLabel setTextColor:[UIColor hexStringToColor:@"333333"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 2) {
            UIButton * addButton = [[UIButton alloc]init];
            [addButton setTag:1];
            [addButton setFrame:CGRectMake(width-70, 5, 60, 30)];
            [addButton setBackgroundImage:[UIImage imageNamed:@"椭圆-6-拷贝"] forState:UIControlStateNormal];
            [cell.contentView addSubview:addButton];
        }
    }
    //cell重用
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell.textLabel setText:@"修改个人资料"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        if (indexPath.row == 1) {
            [cell.textLabel setText:@"修改密码"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        if (indexPath.row == 2) {
            [cell.textLabel setText:@"设置消息提醒"];
            UIButton * addButton = (UIButton *)[cell viewWithTag:1];
            if (xiaoxiFlag) {
                [addButton setBackgroundImage:[UIImage imageNamed:@"椭圆-6"] forState:UIControlStateNormal];
                xiaoxiString = @"1";
            }else{
                [addButton setBackgroundImage:[UIImage imageNamed:@"椭圆-6-拷贝"] forState:UIControlStateNormal];
                xiaoxiString = @"0";
            }
            [addButton addTarget:self action:@selector(xiaoxiButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [cell.textLabel setText:@"退出"];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108/2;
}
#pragma - mark tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //跳转至修改个人资料
            PersonalInfoVC * personalInfoVC = [[PersonalInfoVC alloc]init];
            personalInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:personalInfoVC animated:YES];

        }
        if (indexPath.row == 1) {
            //跳转到修改密码页面
            MeSettingChangePasswordViewController *changePasswordVC = [[MeSettingChangePasswordViewController alloc] init];
            changePasswordVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:changePasswordVC animated:YES];
        }
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToLogin" object:nil];
        }
        
    }
}
#pragma tableView button-methods
static bool xiaoxiFlag = 0;//0，否；1，是。
- (void)xiaoxiButtonMethod:(UIButton *)btn
{
    xiaoxiFlag = !xiaoxiFlag;
    if (xiaoxiFlag) {
        [btn setBackgroundImage:[UIImage imageNamed:@"椭圆-6"] forState:UIControlStateNormal];
        xiaoxiString = @"1";
        [JFProgressHUD showTextHUDInView:self.view text:@"开启消息提醒" detailText:nil hideAfterDelay:1.5];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"remoteNotificationFlag"];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"椭圆-6-拷贝"] forState:UIControlStateNormal];
        xiaoxiString = @"0";
        [JFProgressHUD showTextHUDInView:self.view text:@"关闭消息提醒" detailText:nil hideAfterDelay:1.5];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"remoteNotificationFlag"];
    }
}

//隐藏多余tableviewcell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}



@end
