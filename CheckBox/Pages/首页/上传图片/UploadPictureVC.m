//
//  UploadPictureVC.m
//  CheckBox
//
//  Created by lsm on 16/12/11.
//  Copyright © 2016年 lsm. All rights reserved.
//

#import "UploadPictureVC.h"
#import "MyTakePhoto.h"
#import "SingletonFun.h"
#import "UIImageView+WebCache.h"
#import "UploadSuccessVC.h"
@interface UploadPictureVC ()<UIActionSheetDelegate,UIScrollViewDelegate,TakePhotoDelegate>{
    //拍照
    UIActionSheet *myActionSheet;//下拉菜单
    int sectionViewHeight;
    MyTakePhoto * myTakePhoto;//拍照
    int typeInt;//照片类型：1、正面；2、反面；3、半身照
}
@property (nonatomic, strong)UIScrollView * baseScrollView;
@property (nonatomic, strong)UIView * firstSectionView;
@property (nonatomic, strong)UIImageView * firstTitleImageView;
@property (nonatomic, strong)UILabel * firstTitleLabel;
@property (nonatomic, strong)UIImageView * firstFaceImageView;
@property (nonatomic, strong)UILabel * firstFaceLabel;
@property (nonatomic, strong)UIImageView * firstBackImageView;
@property (nonatomic, strong)UILabel * firstBackLabel;

@property (nonatomic, strong)UIView * secondSectionView;
@property (nonatomic, strong)UIImageView * secondTitleImageView;
@property (nonatomic, strong)UILabel * secondTitleLabel;
@property (nonatomic, strong)UILabel * secondText1Label;
@property (nonatomic, strong)UILabel * secondText2Label;
@property (nonatomic, strong)UILabel * secondText3Label;
@property (nonatomic, strong)UILabel * secondText4Label;
@property (nonatomic, strong)UIImageView * secondFaceImageView;
@property (nonatomic, strong)UIButton * secondFaceButton;

@property (nonatomic, strong)UIButton * commitButton;
@end

@implementation UploadPictureVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //自定义tablebar
    UILabel * label = [[UILabel alloc]init];
    [label setText:@"完善资料"];
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
    myTakePhoto = [[MyTakePhoto alloc]init];
    myTakePhoto.delegate = self;
    [myTakePhoto setInView:self.view viewController:self];
    sectionViewHeight = 200;
    [self addContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - mark custom methods
- (void)addContentView
{
    [self.view addSubview:self.baseScrollView];
    
    [self.baseScrollView addSubview:self.firstSectionView];
    [self.baseScrollView addSubview:self.secondSectionView];
    [self.baseScrollView addSubview:self.commitButton];
    
    [self.firstSectionView addSubview:self.firstTitleImageView];
    [self.firstSectionView addSubview:self.firstTitleLabel];
    [self.firstSectionView addSubview:self.firstFaceImageView];
    [self.firstSectionView addSubview:self.firstFaceLabel];
    [self.firstSectionView addSubview:self.firstBackImageView];
    [self.firstSectionView addSubview:self.firstBackLabel];
    
    [self.secondSectionView addSubview:self.secondTitleImageView];
    [self.secondSectionView addSubview:self.secondTitleLabel];
    [self.secondSectionView addSubview:self.secondText1Label];
    [self.secondSectionView addSubview:self.secondText2Label];
    [self.secondSectionView addSubview:self.secondText3Label];
    [self.secondSectionView addSubview:self.secondText4Label];
    [self.secondSectionView addSubview:self.secondFaceImageView];
    [self.secondSectionView addSubview:self.secondFaceButton];
}
- (void)backBtnMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma - mark methods
- (void)faceIDTapMethod:(UITapGestureRecognizer *)tap
{
    NSString * urlString = [NSString stringWithFormat:@"%@?type=%@&uid=%@",kUploadFaceIDImageURL,@"sfzzm",[SingletonFun shareInstance].loginResponse.body.userId];
    typeInt = 1;
    [myTakePhoto takePhotoToURL:urlString];
}
- (void)backIDTapMethod:(UITapGestureRecognizer *)tap
{
    NSString * urlString = [NSString stringWithFormat:@"%@?type=%@&uid=%@",kUploadBackIDImageURL,@"sfzfm",[SingletonFun shareInstance].loginResponse.body.userId];
    typeInt = 2;
    [myTakePhoto takePhotoToURL:urlString];
}

- (void)secondFaceIDTapMethod:(UITapGestureRecognizer *)tap
{
    NSString * urlString = [NSString stringWithFormat:@"%@?type=%@&uid=%@",kUploadSecondFaceIDImageURL,@"sfz",[SingletonFun shareInstance].loginResponse.body.userId];
    typeInt = 3;
    [myTakePhoto takePhotoToURL:urlString];
}
- (void)secondFaceButtonMethod:(UIButton *)btn
{
    NSString * urlString = [NSString stringWithFormat:@"%@?type=%@&uid=%@",kUploadSecondFaceIDImageURL,@"sfz",[SingletonFun shareInstance].loginResponse.body.userId];
    typeInt = 3;
    [myTakePhoto takePhotoToURL:urlString];
}
- (void)commitButtonMethod:(UIButton *)btn
{
    UploadSuccessVC * uploadSuccessVC = [[UploadSuccessVC alloc]init];
    uploadSuccessVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:uploadSuccessVC animated:YES];
}
#pragma - mark TakePhotoDelegete
- (void)getTakePhotoResponse:(id)response
{
    NSLog(@"%@",response);
    TakePhotoResponse * takePhotoResponse = [[TakePhotoResponse alloc]initWithDictionary:(NSDictionary *)response];
    if ([takePhotoResponse.status floatValue] >= 200 && [takePhotoResponse.status floatValue] < 400) {
        TakePhotoEntity * entity = [[TakePhotoEntity alloc]initWithDictionary:response[@"body"][0]];
        if (entity.url.length > 0) {
            if (typeInt == 1) {
                [self.firstFaceImageView setImageWithURL:[NSURL URLWithString:entity.url]];
            }
            if (typeInt == 2) {
                [self.firstBackImageView setImageWithURL:[NSURL URLWithString:entity.url]];
            }
            if (typeInt == 3) {
                [self.secondFaceImageView setImageWithURL:[NSURL URLWithString:entity.url]];
            }
        }
    }
}
#pragma - mark Setters && Getters
- (UIScrollView *)baseScrollView
{
    if (!_baseScrollView)
    {
        _baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _baseScrollView.contentSize = CGSizeMake(WIDTH, 660 );
        _baseScrollView.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
        _baseScrollView.delegate = self;
        _baseScrollView.userInteractionEnabled = YES;
    }
    
    return _baseScrollView;
}
- (UIView *)firstSectionView
{
    if (!_firstSectionView)
    {
        _firstSectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, sectionViewHeight)];
        _firstSectionView.backgroundColor = [UIColor whiteColor];
        
    }
    
    return _firstSectionView;
}
- (UIImageView *)firstTitleImageView
{
    if (!_firstTitleImageView) {
        _firstTitleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10+(30-85/6)/2, 74/6, 85/6)];
        [_firstTitleImageView setImage:[UIImage imageNamed:@"红五角星"]];
    }
    return _firstTitleImageView;
}
- (UILabel *)firstTitleLabel
{
    if (!_firstTitleLabel) {
        _firstTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+30, 10, WIDTH-15*2-30, 30)];
        [_firstTitleLabel setTextColor:[UIColor hexStringToColor:@"666666"]];
        [_firstTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [_firstTitleLabel setFont:maxTextFont];
        [_firstTitleLabel setText:@"请上传身份证照片:"];
    }
    return _firstTitleLabel;
}
- (UIImageView *)firstFaceImageView
{
    if (!_firstFaceImageView) {
        _firstFaceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(45, 50, (WIDTH-100)/2, 100)];
        [_firstFaceImageView setImage:[UIImage imageNamed:@"ID正面"]];
        UITapGestureRecognizer * faceIDTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(faceIDTapMethod:)];
        [_firstFaceImageView addGestureRecognizer:faceIDTap];
        _firstFaceImageView.userInteractionEnabled = YES;
    }
    return _firstFaceImageView;
}
- (UILabel *)firstFaceLabel
{
    if (!_firstFaceLabel) {
        _firstFaceLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+30, 160, (WIDTH-100)/2, 30)];
        [_firstFaceLabel setTextColor:[UIColor hexStringToColor:@"666666"]];
        [_firstFaceLabel setTextAlignment:NSTextAlignmentCenter];
        [_firstFaceLabel setFont:midTextFont];
        [_firstFaceLabel setText:@"身份证正面"];
    }
    return _firstFaceLabel;
}
- (UIImageView *)firstBackImageView
{
    if (!_firstBackImageView) {
        _firstBackImageView = [[UIImageView alloc]initWithFrame:CGRectMake(45+40+(WIDTH-100)/2, 50, (WIDTH-100)/2, 100)];
        [_firstBackImageView setImage:[UIImage imageNamed:@"ID反面"]];
        UITapGestureRecognizer * backIDTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backIDTapMethod:)];
        [_firstBackImageView addGestureRecognizer:backIDTap];
        _firstBackImageView.userInteractionEnabled = YES;
    }
    return _firstBackImageView;
}
- (UILabel *)firstBackLabel
{
    if (!_firstBackLabel) {
        _firstBackLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+30+40+(WIDTH-100)/2, 160, (WIDTH-100)/2, 30)];
        [_firstBackLabel setTextColor:[UIColor hexStringToColor:@"666666"]];
        [_firstBackLabel setTextAlignment:NSTextAlignmentCenter];
        [_firstBackLabel setFont:midTextFont];
        [_firstBackLabel setText:@"身份证反面"];
    }
    return _firstBackLabel;
}

- (UIView *)secondSectionView
{
    if (!_secondSectionView)
    {
        _secondSectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+sectionViewHeight, WIDTH, sectionViewHeight)];
        _secondSectionView.backgroundColor = [UIColor whiteColor];
        
    }
    return _secondSectionView;
}
- (UIImageView *)secondTitleImageView
{
    if (!_secondTitleImageView) {
        _secondTitleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10+(30-85/6)/2, 74/6, 85/6)];
        [_secondTitleImageView setImage:[UIImage imageNamed:@"红五角星"]];
    }
    return _secondTitleImageView;
}
- (UILabel *)secondTitleLabel
{
    if (!_secondTitleLabel) {
        _secondTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+30, 10, WIDTH-15*2-30, 30)];
        [_secondTitleLabel setTextColor:[UIColor hexStringToColor:@"666666"]];
        [_secondTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [_secondTitleLabel setFont:maxTextFont];
        [_secondTitleLabel setText:@"请上传手持身份证半身照:"];
    }
    return _secondTitleLabel;
}
- (UILabel *)secondText1Label
{
    if (!_secondText1Label) {
        _secondText1Label = [[UILabel alloc]initWithFrame:CGRectMake(15+30, 50, (WIDTH-100)/2, 30)];
        [_secondText1Label setFont:maxTextFont];
        [_secondText1Label setTextAlignment:NSTextAlignmentLeft];
        [_secondText1Label setTextColor:NavigationBarTintColor];
        [_secondText1Label setText:@"要求："];
    }
    
    return _secondText1Label;
}
- (UILabel *)secondText2Label
{
    if (!_secondText2Label) {
        _secondText2Label = [[UILabel alloc]initWithFrame:CGRectMake(15+30, 50+30, (WIDTH-100)/2, 30)];
        [_secondText2Label setFont:midTextFont];
        [_secondText2Label setTextAlignment:NSTextAlignmentLeft];
        [_secondText2Label setTextColor:NavigationBarTintColor];
        [_secondText2Label setText:@"1、免冠近照"];
    }
    
    return _secondText2Label;
}
- (UILabel *)secondText3Label
{
    if (!_secondText3Label) {
        _secondText3Label = [[UILabel alloc]initWithFrame:CGRectMake(15+30, 50+30*2, (WIDTH-100)/2, 30)];
        [_secondText3Label setFont:midTextFont];
        [_secondText3Label setTextAlignment:NSTextAlignmentLeft];
        [_secondText3Label setTextColor:NavigationBarTintColor];
        [_secondText3Label setText:@"2、五官无遮挡"];
    }
    
    return _secondText3Label;
}
- (UILabel *)secondText4Label
{
    if (!_secondText4Label) {
        _secondText4Label = [[UILabel alloc]initWithFrame:CGRectMake(15+30, 50+30*3, (WIDTH-100)/2, 30)];
        [_secondText4Label setFont:midTextFont];
        [_secondText4Label setTextAlignment:NSTextAlignmentLeft];
        [_secondText4Label setTextColor:NavigationBarTintColor];
        [_secondText4Label setText:@"3、证件全部信息清晰"];
    }
    
    return _secondText4Label;
}
- (UIImageView *)secondFaceImageView
{
    if (!_secondFaceImageView) {
        _secondFaceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(45+40+(WIDTH-100)/2+((WIDTH-100)/2-162/2)/2, 50, 162/2, 162/2)];
        [_secondFaceImageView setImage:[UIImage imageNamed:@"椭圆-1-拷贝"]];
        UITapGestureRecognizer * secondFaceIDTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondFaceIDTapMethod:)];
        [_secondFaceImageView addGestureRecognizer:secondFaceIDTap];
        _secondFaceImageView.userInteractionEnabled = YES;
    }
    return _secondFaceImageView;
}
- (UIButton *)secondFaceButton
{
    if (!_secondFaceButton) {
        _secondFaceButton = [[UIButton alloc]initWithFrame:CGRectMake(15+30+40+(WIDTH-100)/2, 160, (WIDTH-100)/2, 30)];
        [_secondFaceButton setBackgroundColor:[UIColor lightGrayColor]];
        [_secondFaceButton.layer setCornerRadius:4.0f];
        [_secondFaceButton setTitle:@"点击上传" forState:UIControlStateNormal];
        [_secondFaceButton addTarget:self action:@selector(secondFaceButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secondFaceButton;
}

- (UIButton *)commitButton
{
    if (!_commitButton) {
        _commitButton = [[UIButton alloc]initWithFrame:CGRectMake(50, sectionViewHeight*2+10+50, WIDTH-100, 40)];
        [_commitButton setBackgroundColor:NavigationBarTintColor];
        [_commitButton.layer setCornerRadius:4.0f];
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(commitButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
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
