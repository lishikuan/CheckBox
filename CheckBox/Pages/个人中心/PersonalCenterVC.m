//
//  PersonalCenterVC.m
//  CheckBox
//
//  Created by lsm on 16/12/17.
//  Copyright © 2016年 lsm. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "UIImageView+WebCache.h"
#import "AboutUsVC.h"
#import "NotificationCenterVC.h"
#import "MeSettingTableViewController.h"
#import "PersonalInfoVC.h"
#import "SingletonFun.h"
#import "JFProgressHUD.h"
#define INFO_VIEW_HEIGHT 568/2
#define IMAGEVIEW_HEIGHT 250/2

typedef enum : NSUInteger {
    ButtonType_Message = 1,
    ButtonType_Order,
    ButtonType_Baby,
    ButtonType_Suggestion,
} ButtonType;


@interface PersonalCenterVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView * listView;
    NSArray * titleArray;
    NSMutableArray * textArray;
    
}
@property (nonatomic, strong) UIView      *tableHeaderView;     //表头视图
@property (nonatomic, strong) UITableView *tableView;           //列表
@property (nonatomic, strong) UIView      *infoView;            //表视图个人信息父视图
@property (nonatomic, strong) UIImageView *userImageView;       //用户头像
//@property (nonatomic, strong) UIImageView *sexImageView;        //用户性别
@property (nonatomic, strong) UILabel     *userNameLabel;       //用户姓名
//@property (nonatomic, strong) UILabel     *userPhaseLabel;      //用户生理状态 1、备孕中 2、治疗中
@property (nonatomic, strong) UIButton    *messageButton;       //消息按钮
@property (nonatomic, strong) UIButton    *orderButton;         //订单按钮
@property (nonatomic, strong) UIButton    *babyButton;          //宝贝计划按钮
@property (nonatomic, strong) UIButton    *suggestionButton;    //医生建议按钮
//@property (nonatomic, strong) UILabel     *messageCountLabel;   //消息条数
@property (nonatomic, strong) NSArray     *dataArray;           //表单列表内容数组
@property (nonatomic, strong) NSArray     *imageDataArray;      //表单列表图片内容数组
@end

@implementation PersonalCenterVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"我的";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    [self.navigationController.navigationBar setTintColor:[UIColor hexStringToColor:@"666666"]];
    [self.navigationController.navigationBar setBarTintColor:kNavWhiteColor];
//    titleArray = @[@"上传个人资料",@"上传图片",@"个人设置",@"消息中心",@"关于我们"];
//    textArray = [[NSMutableArray alloc]init];
//    [textArray addObjectsFromArray:@[@"添加",@"添加",@"",@"",@""]];
    [self addContentView];
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor hexStringToColor:@"f5f5f5"];
    
    _dataArray = @[@[@"消息中心",@"关于我们"],@[@"个人设置"]];
    _imageDataArray = @[@[@"消息",@"关于我们"],@[@"个人设置"]];
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - mark custom methods
- (void)addContentView{
//    listView = [[UITableView alloc]init];
//    [listView setFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
//    listView.dataSource = self;
//    listView.delegate = self;
//    [self.view addSubview:listView];
    
    //设置用户头像
    if (listView != nil)
    {
        [_userImageView setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"head_mem_girl"]];
    }
    else
    {
        [_userImageView setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"head_mem_boy"]];
    }
    [_userImageView setBackgroundColor:NavigationBarTintColor];
    //设置用户名称
    _userNameLabel.text = @"nickname";
    
    //计算用户名所占frame
    CGRect rect = [_userNameLabel.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    CGFloat width = rect.size.width;
    CGRect labelFrame = _userNameLabel.frame;
    labelFrame.size.width = width;
    _userNameLabel.frame = labelFrame;
    
//    //设置用户性别视图层，紧跟在label后
//    if (listView != nil)
//    {
//        UIImage *girlImage = [UIImage imageNamed:@"newSelf_girl"];
//        _sexImageView.frame = CGRectMake(CGRectGetMaxX(_userNameLabel.frame) + 10, _userNameLabel.frame.origin.y, girlImage.size.width, girlImage.size.height);
//        _sexImageView.image = girlImage;
//    }
//    else
//    {
//        UIImage *boyImage = [UIImage imageNamed:@"newSelf_boy"];
//        _sexImageView.frame = CGRectMake(CGRectGetMaxX(_userNameLabel.frame) + 10, _userNameLabel.frame.origin.y, boyImage.size.width, boyImage.size.height);
//        _sexImageView.image = boyImage;
//    }
    
//    NSArray *stageStrArray = @[@"自然备孕",@"治疗备孕",@"降调",@"前期准备",@"胚胎移植",@"取卵",@"促排"];
//    
//    int stageCount = 0;
//    
//    if (stageCount <= 7 && stageCount>0)
//    {
//        _userPhaseLabel.text = [stageStrArray objectAtIndex:stageCount - 1];
//    }

}
- (void)backBtnMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)pushToInfomationVC
{
    PersonalInfoVC * personalInfoVC = [[PersonalInfoVC alloc]init];
    personalInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personalInfoVC animated:YES];
}
- (void)getUserInfoMethod
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString * strURL = [NSString stringWithFormat:@"%@/%@?visitorId=%@",kGetUserInfoURL,[SingletonFun shareInstance].loginResponse.body.userId,@"2"];
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/plain", nil];
    [manager POST:strURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        if (dict != nil)
        {
            NSLog(@"dict %@",dict);
            
            LoginResponse * response = nil;
            NSMutableDictionary *responseEntity = (NSMutableDictionary *)dict;
            
            response = [[LoginResponse alloc] initWithDictionary:responseEntity];
            NSLog(@"%@",response.message);
            
            if ([response.status floatValue] == 200) {
                
               
            }else if ([response.status floatValue] > 200 && [response.status floatValue] <400) {
                
                
                
            }else if ([response.status floatValue] >= 400 && [response.status floatValue] < 500) {
                [JFProgressHUD showTextHUDInView:self.view text:response.message detailText:nil hideAfterDelay:1.5];
                
            }else if ([response.status floatValue] > 500) {
                [JFProgressHUD showTextHUDInView:self.view text:response.message detailText:nil hideAfterDelay:1.5];
                
            }else{
                //登录失败，返回登录界面
                [JFProgressHUD showTextHUDInView:self.view text:response.message detailText:nil hideAfterDelay:1.5];
            }
        }
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [JFProgressHUD showTextHUDInView:self.view text:@"网络错误，请检查网络设置" detailText:nil hideAfterDelay:1.5];
         NSLog(@"ERROR %@",error);
         
     }];

}
#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_dataArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor hexStringToColor:@"333333"];
        cell.textLabel.font = midTextFont;
    }
    
    NSString *imageName = _imageDataArray[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
    
    return cell;
}

#pragma - mark listview delegate


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor hexStringToColor:@"f5f5f5"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else if(section == 1){
        return 10;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108/2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NotificationCenterVC * notificationCenterVC = [[NotificationCenterVC alloc]init];
            notificationCenterVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:notificationCenterVC animated:YES];
        }
        if (indexPath.row == 1) {
            AboutUsVC * aboutUsVC = [[AboutUsVC alloc]init];
            aboutUsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutUsVC animated:YES];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MeSettingTableViewController * settingVC = [[MeSettingTableViewController alloc]init];
            settingVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingVC animated:YES];
        }
    }
}
#pragma mark - Setters && Getters

- (UIView *)tableHeaderView
{
    if (!_tableHeaderView)
    {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, INFO_VIEW_HEIGHT)];
        
        //个人信息父视图
        _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, INFO_VIEW_HEIGHT)];
        _infoView.backgroundColor = [UIColor orangeColor];

        [_tableHeaderView addSubview:_infoView];
        
        //箭头
        UIImage *arrowImage = [UIImage imageNamed:@"newSelf_jiantou"];
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, arrowImage.size.width, arrowImage.size.height)];
        arrowImageView.image = arrowImage;
        arrowImageView.center = CGPointMake(WIDTH - 30, INFO_VIEW_HEIGHT / 2 + 10);
        arrowImageView.userInteractionEnabled = YES;
        [_infoView addSubview:arrowImageView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, INFO_VIEW_HEIGHT - 0.5, WIDTH, 0.5)];
        lineView.backgroundColor = [UIColor hexStringToColor:@"dddddd"];
        [_infoView addSubview:lineView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToInfomationVC)];
        [_infoView addGestureRecognizer:tapGesture];
        
        [_infoView addSubview:self.userImageView];
        [_infoView addSubview:self.userNameLabel];
//        [_infoView addSubview:self.sexImageView];
//        [_infoView addSubview:self.userPhaseLabel];
        
//        [_tableHeaderView addSubview:self.messageButton];
//        [_tableHeaderView addSubview:self.orderButton];
//        [_tableHeaderView addSubview:self.babyButton];
//        [_tableHeaderView addSubview:self.suggestionButton];
        
        //        [self.messageButton addSubview:self.messageCountLabel];
    }
    
    return _tableHeaderView;
}

- (UIImageView *)userImageView
{
    if (!_userImageView)
    {
        //用户头像
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH-IMAGEVIEW_HEIGHT)/2, 160/2, IMAGEVIEW_HEIGHT, IMAGEVIEW_HEIGHT)];
        _userImageView.layer.cornerRadius = _userImageView.frame.size.width / 2;
        _userImageView.layer.masksToBounds = YES;
        _userImageView.layer.borderWidth = 10/2;
        _userImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_userImageView setBackgroundColor:NavigationBarTintColor];
    }
    
    return _userImageView;
}

- (UILabel *)userNameLabel
{
    if (!_userNameLabel)
    {
        //用户名
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userImageView.frame), CGRectGetMaxY(_userImageView.frame)+60/2, IMAGEVIEW_HEIGHT, 34/2)];
        _userNameLabel.text = @"患者姓名";
        _userNameLabel.textColor = [UIColor whiteColor];
        [_userNameLabel setTextAlignment:NSTextAlignmentCenter];
        _userNameLabel.font = [UIFont systemFontOfSize:17];
        _userNameLabel.userInteractionEnabled = YES;
    }
    
    return _userNameLabel;
}

//- (UIImageView *)sexImageView
//{
//    if (!_sexImageView)
//    {
//        //用户性别
//        UIImage *sexImage = [UIImage imageNamed:@"newSelf_girl"];
//        _sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userNameLabel.frame), _userNameLabel.frame.origin.y, sexImage.size.width, sexImage.size.height)];
//        _sexImageView.image = sexImage;
//        _sexImageView.userInteractionEnabled = YES;
//    }
//    
//    return _sexImageView;
//}

//- (UILabel *)userPhaseLabel
//{
//    if (!_userPhaseLabel)
//    {
//        //用户所处状态label
//        _userPhaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImageView.frame) + 20, CGRectGetMaxY(_userNameLabel.frame) + 8, 100, 20)];
//        _userPhaseLabel.textColor = [UIColor hexStringToColor:@"999999"];
//        _userPhaseLabel.font = [UIFont systemFontOfSize:12];
//    }
//    
//    return _userPhaseLabel;
//}

- (UIButton *)messageButton
{
    if (!_messageButton)
    {
        UIImage *messageButtonImage = [UIImage imageNamed:@"newSelf_news"];
        _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageButton.frame = CGRectMake(0, CGRectGetMaxY(_infoView.frame) + 12, WIDTH / 4, WIDTH / 4);
        [_messageButton setTitle:@"确认中" forState:UIControlStateNormal];
        [_messageButton setTitleColor:[UIColor hexStringToColor:@"666666"] forState:UIControlStateNormal];
        [_messageButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_messageButton.titleLabel sizeToFit];
        [_messageButton setImage:messageButtonImage forState:UIControlStateNormal];
        [_messageButton setImage:messageButtonImage forState:UIControlStateHighlighted];
        [_messageButton setBackgroundColor:[UIColor whiteColor]];
        [_messageButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_messageButton setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [_messageButton setTitleEdgeInsets:UIEdgeInsetsMake(WIDTH / 4.0 / (375 / 4.0) * 64, (_messageButton.bounds.size.width - _messageButton.titleLabel.bounds.size.width) * 0.5 - _messageButton.imageView.bounds.size.width, 0, 0)];
        [_messageButton setImageEdgeInsets:UIEdgeInsetsMake(WIDTH / 4.0 / (375 / 4.0) * 18, (_messageButton.bounds.size.width - _messageButton.imageView.bounds.size.width) * 0.5, 0, 0)];
        [_messageButton setTag:ButtonType_Message];
        [_messageButton addTarget:self action:@selector(serviceButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _messageButton;
}

- (UIButton *)orderButton
{
    if (!_orderButton)
    {
        UIImage *orderButtonImage = [UIImage imageNamed:@"newSelf_plan"];
        _orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _orderButton.frame = CGRectMake(CGRectGetMaxX(_messageButton.frame), _messageButton.frame.origin.y, _messageButton.frame.size.width, _messageButton.frame.size.height);
        [_orderButton setTitle:@"待支付" forState:UIControlStateNormal];
        [_orderButton setTitleColor:[UIColor hexStringToColor:@"666666"] forState:UIControlStateNormal];
        [_orderButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_orderButton.titleLabel sizeToFit];
        [_orderButton setImage:orderButtonImage forState:UIControlStateNormal];
        [_orderButton setImage:orderButtonImage forState:UIControlStateHighlighted];
        [_orderButton setBackgroundColor:[UIColor whiteColor]];
        [_orderButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_orderButton setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [_orderButton setTitleEdgeInsets:UIEdgeInsetsMake(WIDTH / 4.0 / (375 / 4.0) * 64, (_orderButton.bounds.size.width - _orderButton.titleLabel.bounds.size.width) * 0.5 - _orderButton.imageView.bounds.size.width, 0, 0)];
        [_orderButton setImageEdgeInsets:UIEdgeInsetsMake(WIDTH / 4.0 / (375 / 4.0) * 18, (_orderButton.bounds.size.width - _orderButton.imageView.bounds.size.width) * 0.5, 0, 0)];
        [_orderButton setBackgroundColor:[UIColor whiteColor]];
        [_orderButton setTag:ButtonType_Order];
        [_orderButton addTarget:self action:@selector(serviceButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _orderButton;
}

- (UIButton *)babyButton
{
    if (!_babyButton)
    {
        UIImage *babyButtonImage = [UIImage imageNamed:@"newSelf_order"];
        _babyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _babyButton.frame = CGRectMake(CGRectGetMaxX(_orderButton.frame), _orderButton.frame.origin.y, _orderButton.frame.size.width, _orderButton.frame.size.height);
        [_babyButton setTitle:@"服务中" forState:UIControlStateNormal];
        [_babyButton setTitleColor:[UIColor hexStringToColor:@"666666"] forState:UIControlStateNormal];
        [_babyButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_babyButton.titleLabel sizeToFit];
        [_babyButton setImage:babyButtonImage forState:UIControlStateNormal];
        [_babyButton setImage:babyButtonImage forState:UIControlStateHighlighted];
        [_babyButton setBackgroundColor:[UIColor whiteColor]];
        [_babyButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_babyButton setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [_babyButton setTitleEdgeInsets:UIEdgeInsetsMake(WIDTH / 4.0 / (375 / 4.0) * 64, (_babyButton.bounds.size.width - _babyButton.titleLabel.bounds.size.width) * 0.5 - _babyButton.imageView.bounds.size.width, 0, 0)];
        [_babyButton setImageEdgeInsets:UIEdgeInsetsMake(WIDTH / 4.0 / (375 / 4.0) * 18, (_babyButton.bounds.size.width - _babyButton.imageView.bounds.size.width) * 0.5, 0, 0)];
        [_babyButton setBackgroundColor:[UIColor whiteColor]];
        [_babyButton setTag:ButtonType_Baby];
        [_babyButton addTarget:self action:@selector(serviceButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _babyButton;
}

- (UIButton *)suggestionButton
{
    if (!_suggestionButton)
    {
        UIImage *suggestionButtonImage = [UIImage imageNamed:@"newSelf_doctor"];
        _suggestionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _suggestionButton.frame = CGRectMake(CGRectGetMaxX(_babyButton.frame), _babyButton.frame.origin.y, _babyButton.frame.size.width, _babyButton.frame.size.height);
        [_suggestionButton setTitle:@"已完成" forState:UIControlStateNormal];
        [_suggestionButton setTitleColor:[UIColor hexStringToColor:@"666666"] forState:UIControlStateNormal];
        [_suggestionButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_suggestionButton.titleLabel sizeToFit];
        [_suggestionButton setBackgroundColor:[UIColor redColor]];
        [_suggestionButton setImage:suggestionButtonImage forState:UIControlStateNormal];
        [_suggestionButton setImage:suggestionButtonImage forState:UIControlStateHighlighted];
        [_suggestionButton setBackgroundColor:[UIColor whiteColor]];
        [_suggestionButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_suggestionButton setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [_suggestionButton setTitleEdgeInsets:UIEdgeInsetsMake(WIDTH / 4.0 / (375 / 4.0) * 64, (_suggestionButton.bounds.size.width - _suggestionButton.titleLabel.bounds.size.width) * 0.5 - _suggestionButton.imageView.bounds.size.width, 0, 0)];
        [_suggestionButton setBackgroundColor:[UIColor whiteColor]];
        [_suggestionButton setImageEdgeInsets:UIEdgeInsetsMake(WIDTH / 4.0 / (375 / 4.0) * 18, (_suggestionButton.bounds.size.width - _suggestionButton.imageView.bounds.size.width) * 0.5, 0, 0)];
        [_suggestionButton setTag:ButtonType_Suggestion];
        [_suggestionButton addTarget:self action:@selector(serviceButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _suggestionButton;
}

//- (UILabel *)messageCountLabel
//{
//    if (!_messageCountLabel)
//    {
//        _messageCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 8.0 + 8, WIDTH / 4.0 / (375 / 4.0) * 18, 25, 14)];
//        _messageCountLabel.textColor = [UIColor whiteColor];
//        _messageCountLabel.textAlignment = NSTextAlignmentCenter;
//        _messageCountLabel.font = [UIFont systemFontOfSize:9];
//        _messageCountLabel.backgroundColor = [UIColor hexStringToColor:@"ff8871"];
//        _messageCountLabel.layer.cornerRadius = 7;
//        _messageCountLabel.layer.masksToBounds = YES;
//        _messageCountLabel.hidden = YES;
//    }
//
//    return _messageCountLabel;
//}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 15)];
        footerView.backgroundColor = [UIColor hexStringToColor:@"f5f5f5"];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 50) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor hexStringToColor:@"f5f5f5"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.rowHeight = 50;
        _tableView.tableFooterView = footerView;
    }
    
    return _tableView;
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
