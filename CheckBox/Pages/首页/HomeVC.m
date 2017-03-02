//
//  HomeVC.m
//  CheckBox
//
//  Created by lsm on 16/12/15.
//  Copyright © 2016年 lsm. All rights reserved.
//

#import "HomeVC.h"
#import "HomeHeaderView.h"
#import "SDCycleScrollView.h"
#import "SingletonFun.h"
#import "NotificationCenterVC.h"
@interface HomeVC ()<HomeHeaderViewDelegate>
@property (nonatomic, strong)UILabel * unReadLabel;/*未读消息数*/
@property (nonatomic, strong) UIScrollView *baseScrollView; /*父视图*/
@property (nonatomic, strong) HomeHeaderView *heaederView;   /*头视图*/
@property (nonatomic, assign) CGFloat headerViewHeight; /*头视图高度*/
@property (nonatomic, strong) NSArray *bannerDataArray; /*banner数据*/

@property (nonatomic, strong) UIView * firstSectionView;
@property (nonatomic, assign) CGFloat firstSectionViewHeight; /*第一视图高度*/
@property (nonatomic, strong) UILabel * accountLabel;//额度值
@property (nonatomic, strong) UILabel * accTextLabel;//可用额度
@property (nonatomic, strong) UILabel * accTitleLabel;//我的额度

@property (nonatomic, strong) UIButton * borrowButton;//开始借款
@end

@implementation HomeVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    [self.unReadLabel setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //自定义tablebar
    UILabel * label = [[UILabel alloc]init];
    [label setText:@"首页"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [label setFrame:CGRectMake(0, 0, 100, 40)];
    [label setFont:[UIFont systemFontOfSize:18 weight:20]];
    self.navigationItem.titleView = label;
    //右侧按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"消息"] style:UIBarButtonItemStylePlain target:self action:@selector(jumpToNotificationCenterMethod)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:self.unReadLabel];
     //tablebar背景色
    [self.navigationController.navigationBar setBarTintColor:NavigationBarTintColor];
    
    _headerViewHeight = CYCLE_HEIGHT / 375.0 * WIDTH;
    _firstSectionViewHeight = 308/2;
    
    [self addContentView];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.unReadLabel setHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Customed Methods
- (void)jumpToNotificationCenterMethod
{
    NotificationCenterVC * notificationCenterVC = [[NotificationCenterVC alloc]init];
    notificationCenterVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:notificationCenterVC animated:YES];
    [self.unReadLabel setHidden:YES];
}
- (void)addContentView
{
    
    [self.view addSubview:self.baseScrollView];
    [self.baseScrollView addSubview:self.heaederView];
    [self.baseScrollView addSubview:self.firstSectionView];
    [self.baseScrollView addSubview:self.borrowButton];
    
    [self.firstSectionView addSubview:self.accountLabel];
    [self.firstSectionView addSubview:self.accTextLabel];
    [self.firstSectionView addSubview:self.accTitleLabel];
    
    [self.borrowButton setTitle:@"开始借款" forState:UIControlStateNormal];
    
    [self.accountLabel setText:[NSString stringWithFormat:@"%@",[SingletonFun shareInstance].loginResponse.body.totalCredit]];
    [self.accTextLabel setText:@"(可用额度)"];
    [self.accTitleLabel setText:@"我的额度"];
    
     self.heaederView.delegate = self;
    
}
- (void)setContent
{
    NSMutableArray *picArr = [NSMutableArray array];
    for (NSDictionary *dic in _bannerDataArray)
    {
        [picArr addObject:[dic objectForKey:@"pic"]];
    }
    
    _heaederView.cycleScrollView.imageURLStringsGroup = picArr;
    _heaederView.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
}
- (void)borrowButonMethod:(UIButton *)btn
{
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:@"uploadPersonalInfoVCID" sender:self];
    
}
#pragma - mark Setters & Getters
- (UILabel *)unReadLabel
{
    int viewWidth = 12;
    if (!_unReadLabel) {
        _unReadLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-15-viewWidth/2, viewWidth/2, viewWidth, viewWidth)];
        [_unReadLabel setBackgroundColor:[UIColor whiteColor]];
        [_unReadLabel setTextColor:NavigationBarTintColor];
        [_unReadLabel.layer setCornerRadius:viewWidth/2];
        [_unReadLabel.layer setMasksToBounds:YES];
        [_unReadLabel setFont:minTextFont];
        [_unReadLabel setAdjustsFontSizeToFitWidth:YES];
        [_unReadLabel setText:@"0"];
        [_unReadLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _unReadLabel;
}
- (UIScrollView *)baseScrollView
{
    if (!_baseScrollView)
    {
        _baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _baseScrollView.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
        _baseScrollView.userInteractionEnabled = YES;
        [_baseScrollView setContentSize:CGSizeMake(WIDTH, 660)];
    }
    
    return _baseScrollView;
}

- (HomeHeaderView *)heaederView
{
    if (!_heaederView)
    {
        _heaederView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, _headerViewHeight)];
    }
    
    return _heaederView;
}

- (UIView *)firstSectionView
{
    if (!_firstSectionView)
    {
        _firstSectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+_headerViewHeight, WIDTH, _firstSectionViewHeight)];
        _firstSectionView.backgroundColor = [UIColor whiteColor];
        
    }
    
    return _firstSectionView;
}
- (UILabel *)accountLabel
{
    if (!_accountLabel) {
        _accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 54/2, WIDTH, 100/2)];
        [_accountLabel setFont:[UIFont systemFontOfSize:30 weight:8]];
        [_accountLabel setTextColor:NavigationBarTintColor];
        [_accountLabel setTextAlignment:NSTextAlignmentCenter];
        
    }
    return _accountLabel;
}

- (UILabel *)accTextLabel
{
    if (!_accTextLabel) {
        _accTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 192/2, WIDTH, 22/2)];
        [_accTextLabel setFont:midTextFont];
        [_accTextLabel setTextColor:[UIColor lightGrayColor]];
        [_accTextLabel setTextAlignment:NSTextAlignmentCenter];
        
    }
    return _accTextLabel;
}
- (UILabel *)accTitleLabel
{
    if (!_accTitleLabel) {
        _accTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 240/2, WIDTH, 36/2)];
        [_accTitleLabel setFont:[UIFont systemFontOfSize:20]];
        [_accTitleLabel setTextColor:[UIColor blackColor]];
        [_accTitleLabel setTextAlignment:NSTextAlignmentCenter];
        
    }
    return _accTitleLabel;
}
- (UIButton *)borrowButton
{
    if (!_borrowButton) {
        _borrowButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2-150, 64+_headerViewHeight+_firstSectionViewHeight+30, 300, 40)];
        _borrowButton.layer.cornerRadius = 4.f;
        [_borrowButton setBackgroundColor:NavigationBarTintColor];
        [_borrowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_borrowButton.titleLabel setFont:maxTextFont];
        [_borrowButton addTarget:self action:@selector(borrowButonMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _borrowButton;
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
