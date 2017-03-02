//
//  PersonalInfoVC.m
//  CheckBox
//
//  Created by lsm on 17/1/14.
//  Copyright © 2017年 lsm. All rights reserved.
//

#import "PersonalInfoVC.h"
#import "SKFieldView.h"
#import "JFProgressHUD.h"
#import "UploadUserInfoResponse.h"
#import "MyTakePhoto.h"
#import "SingletonFun.h"
#import "UIImageView+WebCache.h"
@interface PersonalInfoVC ()<TakePhotoDelegate>{
    NSMutableArray * titleArray;
    NSMutableArray * placeHolderArray;
    //用户基本信息参数
    NSString * name;
    NSString * company;
    NSString * job;
    NSString * email;
    MyTakePhoto * myTakePhoto;
}
@property (nonatomic, strong)UIScrollView * baseScrollView;
@property (nonatomic, strong)UIImageView * sectionImageView;
@property (nonatomic, strong)UIImageView * headImageView;
@property (nonatomic, strong)UIButton * photoButton;
@property (nonatomic, strong)UILabel * textLabel;
@property (nonatomic, strong)UIButton * commitButton;

@end

@implementation PersonalInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //自定义tablebar
    UILabel * label = [[UILabel alloc]init];
    [label setText:@"上传基本资料"];
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
    
    titleArray = [[NSMutableArray alloc] init];
    placeHolderArray = [[NSMutableArray alloc]init];
    
    [titleArray addObjectsFromArray:@[@"姓名",@"公司",@"职位",@"邮箱"]];
    [placeHolderArray addObjectsFromArray:@[@"请输入您的姓名",@"请输入您的公司名称",@"请输入您的职位",@"请输入您的邮箱"]];
    myTakePhoto = [[MyTakePhoto alloc]init];
    myTakePhoto.delegate = self;
    [myTakePhoto setInView:self.view viewController:self];
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
    [self.view setBackgroundColor:[UIColor hexStringToColor:@"f4f4f4"]];
    [self.view addSubview:self.baseScrollView];
    [self.baseScrollView addSubview:self.sectionImageView];
    [self.baseScrollView addSubview:self.headImageView];
    [self.baseScrollView addSubview:self.photoButton];
    [self.baseScrollView addSubview:self.textLabel];
    [self.baseScrollView addSubview:self.commitButton];
}
- (void)commitBtnMethod:(UIButton *)btn
{
    for (int i = 0; i < 4; i ++) {
        SKFieldView * fieldView = (SKFieldView *)[self.sectionImageView viewWithTag:i];
        UITextField * textField = (UITextField *)[fieldView viewWithTag:1001];
        if ([titleArray[i] isEqualToString:@"姓名"]) {
            name = textField.text;
        }else if ([titleArray[i] isEqualToString:@"公司"]){
            company = textField.text;
        }else if ([titleArray[i] isEqualToString:@"职位"]){
            job = textField.text;
        }else if ([titleArray[i] isEqualToString:@"邮箱"]){
            email = textField.text;
        }
    }
    [self requestMethod];
    
}
- (void)requestMethod
{
    NSString * userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    if (name.length == 0) {
        [JFProgressHUD showTextHUDInView:self.view text:@"名字不能为空" detailText:nil hideAfterDelay:1.5f];
    }else if (company.length == 0){
        [JFProgressHUD showTextHUDInView:self.view text:@"公司不能为空" detailText:nil hideAfterDelay:1.5f];
    }else if (job.length == 0){
        [JFProgressHUD showTextHUDInView:self.view text:@"职位不能为空" detailText:nil hideAfterDelay:1.5f];
    }else if (email.length == 0){
        [JFProgressHUD showTextHUDInView:self.view text:@"邮箱不能为空" detailText:nil hideAfterDelay:1.5f];
    }else if (userId.length == 0){
        [JFProgressHUD showTextHUDInView:self.view text:@"userId不能为空" detailText:nil hideAfterDelay:1.5f];
    }else{
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        NSString * strURL = [NSString stringWithFormat:@"%@/%@?name=%@&company=%@&job=%@&email=%@",kUploadUserInfoURL,userId,name,company,job,email];
        strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/plain", nil];
        [manager PUT:strURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            if (dict != nil)
            {
                NSLog(@"dict %@",dict);
                UploadUserInfoResponse * response = [[UploadUserInfoResponse alloc]initWithDictionary:dict];
                if ([response.status floatValue] == 200) {
                    //上传成功，跳转界面
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else if ([response.status floatValue] > 200 && [response.status floatValue] <400) {
                    //上传成功，跳转界面
                    [self.navigationController popViewControllerAnimated:YES];
                    
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
    
    
    
}
- (void)takePhotoMethod
{
     NSString * urlString = [NSString stringWithFormat:@"%@?type=%@&uid=%@",kUploadHeadImageURL,@"avatar",[SingletonFun shareInstance].loginResponse.body.userId];
    [myTakePhoto takePhotoToURL:urlString];
}
#pragma - mark TakePhotoDelegate
- (void)getTakePhotoResponse:(id)response
{
    TakePhotoResponse * takePhotoResponse = [[TakePhotoResponse alloc]initWithDictionary:(NSDictionary *)response];
    if ([takePhotoResponse.status floatValue] >= 200 && [takePhotoResponse.status floatValue] < 400) {
        TakePhotoEntity * entity = [[TakePhotoEntity alloc]initWithDictionary:response[@"body"][0]];
        if (entity.url.length > 0) {
            [self.headImageView setImageWithURL:[NSURL URLWithString:entity.url]];
            
        }
    }

}

#pragma - mark Setters && Getters
- (UIScrollView *)baseScrollView
{
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc]init];
        [_baseScrollView setFrame:self.view.frame];
        [_baseScrollView setContentSize:CGSizeMake(WIDTH, 660)];
    }
    return _baseScrollView;
}
- (UIImageView *)sectionImageView
{
    if (!_sectionImageView) {
        _sectionImageView = [[UIImageView alloc]init];
        [_sectionImageView setFrame:CGRectMake(18/2, 150/2, WIDTH - (18/2)*2, 562/2)];
        [_sectionImageView setImage:[UIImage imageNamed:@"圆角矩形-7"]];
        [_sectionImageView.layer setCornerRadius:4.0f];
        _sectionImageView.userInteractionEnabled = YES;
        for (int i = 0; i < 4; i ++) {
            SKFieldView * fieldView = [[SKFieldView alloc]initWithFrame:CGRectMake(0, 154/2+92/2*i, WIDTH - (18/2)*2, 92/2)];
            fieldView.tag = i;
            [fieldView setTitle:[NSString stringWithFormat:@"%@",titleArray[i]]];
            [fieldView setPlaceHolder:[NSString stringWithFormat:@"%@",placeHolderArray[i]]];
            if ([SingletonFun shareInstance].loginResponse.body.name.length > 0&& [titleArray[i] isEqualToString:@"姓名"]) {
                [fieldView.textField setText:[SingletonFun shareInstance].loginResponse.body.name];
            }
            if ([SingletonFun shareInstance].loginResponse.body.company.length > 0&& [titleArray[i] isEqualToString:@"公司"]) {
                [fieldView.textField setText:[SingletonFun shareInstance].loginResponse.body.company];
            }

            if ([SingletonFun shareInstance].loginResponse.body.email.length > 0&& [titleArray[i] isEqualToString:@"邮箱"]) {
                [fieldView.textField setText:[SingletonFun shareInstance].loginResponse.body.email];
            }

            [fieldView setImage:[UIImage imageNamed:@"标识"]];
            [_sectionImageView addSubview:fieldView];
        }
    }
    return _sectionImageView;
}
- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
        [_headImageView setFrame:CGRectMake((WIDTH - (142/2))/2, 48/2, 142/2, 142/2)];
        [_headImageView.layer setCornerRadius:142/2/2];
        [_headImageView.layer setBorderWidth:5/2];
        [_headImageView.layer setBorderColor:NavigationBarTintColor.CGColor];
        [_headImageView setImage:[UIImage imageNamed:@"头像"]];
        [_headImageView.layer setMasksToBounds:YES];
        //[_headImageView setImageWithURL:[NSURL URLWithString:[SingletonFun shareInstance].loginResponse.body.userId] placeholderImage:[UIImage imageNamed:@"头像"]];
    }
    return _headImageView;
}
- (UIButton *)photoButton
{
    if (!_photoButton) {
        _photoButton = [[UIButton alloc]init];
        [_photoButton setFrame:CGRectMake(WIDTH/2+(142/2)/2-15, 152/2, 46/2, 46/2)];
        [_photoButton.layer setCornerRadius:46/2/2];
        [_photoButton.layer setBorderWidth:5/2];
        [_photoButton.layer setBorderColor:NavigationBarTintColor.CGColor];
        [_photoButton setBackgroundImage:[UIImage imageNamed:@"矢量智能对象"] forState:UIControlStateNormal];
        [_photoButton addTarget:self action:@selector(takePhotoMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoButton;
}
- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        [_textLabel setFrame:CGRectMake((WIDTH - (142/2))/2, 152/2+46/2+22/2, 142/2, 24/2)];
        [_textLabel setTextColor:NavigationBarTintColor];
        [_textLabel setFont:midTextFont];
        [_textLabel setTextAlignment:NSTextAlignmentCenter];
        [_textLabel setText:@"请上传头像"];
        [_textLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _textLabel;
}
- (UIButton *)commitButton
{
    if (!_commitButton) {
        _commitButton = [[UIButton alloc]init];
        [_commitButton setFrame:CGRectMake((WIDTH-(660)/2)/2, 782/2, 660/2, 90/2)];
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_commitButton.titleLabel setFont:midTextFont];
        [_commitButton setBackgroundColor:NavigationBarTintColor];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton.layer setCornerRadius:4.0f];
        [_commitButton addTarget:self action:@selector(commitBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
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
