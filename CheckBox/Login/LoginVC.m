//
//  LoginVC.m
//  CheckBox
//
//  Created by lsm on 16/12/11.
//  Copyright © 2016年 lsm. All rights reserved.
//

#define BUTTON_WIDTH 25
#define THIRD_BUTTON_WIDTH 38
#define THIRD_BUTTON_DISTINCE 30
//#define kRedirectURI    @"http://www.bobcare.com"

#import "LoginVC.h"
#import "RegisterVC.h"
#import "ForgetPasswordVC.h"
#import "JFProgressHUD.h"
#import "UtilFun.h"
#import "LoginResponse.h"
#import "SingletonFun.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
@interface LoginVC ()<UITextFieldDelegate>{

    UITextField *_userNameTF;
    UITextField *_passwordTF;
    UIImageView *_imageView;
    UIButton *_registerButton;
    UIButton *_loginButton;
    UIButton *_forgetPwdButton;
    UIButton *_protocalButton;
//    MBProgressHUD *_HUD;
    
    UITextField * oldPasswordTextField;
    BOOL _isSecure;
    UIButton *_button;
    
    //第三方登录
//    TencentOAuth *_tencentOAth;
    NSString *tencentOpenId;

}
@property (nonatomic, strong)UIScrollView * baseScrollView;
@property (nonatomic, strong) UIButton *qqLoginButton;
@property (nonatomic, strong) UIButton *wechatLoginButton;
@property (nonatomic, strong) UIButton *weiboLoginButton;
@property (nonatomic, strong) UIImageView *attentionImageView;


@end

@implementation LoginVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"wechatDidLoginNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weiboDidLoginNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginVCForgetPasswordButtonMethod" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"登录";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setTintColor:[UIColor hexStringToColor:@"666666"]];
    [self.navigationController.navigationBar setBarTintColor:NavigationBarTintColor];
    //添加视图
    [self addContentView];
    
//    //添加第三方登录
//    [self.view addSubview:self.wechatLoginButton];
//    [self.view addSubview:self.qqLoginButton];
//    [self.view addSubview:self.weiboLoginButton];
//    [self.view addSubview:self.attentionImageView];
//    //判断是否有微信
//    if (![WXApi isWXAppSupportApi]){
//        [self hidWeChatMethod];
//    }
    
//    NSString *versionStr = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    NSString *requestVersionStr = [SingletonFun shareInstance].versionStr;
//    
//    if ([versionStr isEqualToString:requestVersionStr] || [JFUtils isBlankString:requestVersionStr])
//    {
//        [self.wechatLoginButton setHidden:YES];
//        [self.qqLoginButton setHidden:YES];
//        [self.weiboLoginButton setHidden:YES];
//        [self.attentionImageView setHidden:YES];
//    }
//    
//    //跳转到主界面
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatDidLoginNotification:) name:@"wechatDidLoginNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPrePayNotification:) name:@"wechatPrePayNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiboDidLoginNotification:) name:@"weiboDidLoginNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forgetPasswordButtonMethod) name:@"loginVCForgetPasswordButtonMethod" object:nil];
}
- (void)addContentView
{
    [self.view addSubview:self.baseScrollView];
    self.baseScrollView.userInteractionEnabled = YES;
    //添加手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMethod:)];
    [self.baseScrollView addGestureRecognizer:tap];
    
    //添加视图
    UIView *logoBaseView = [[UIView alloc] initWithFrame:CGRectMake(15, 64 + 20, screenWidth - 15 * 2, 160)];
    [self.baseScrollView addSubview:logoBaseView];
    UIImageView * logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(logoBaseView.frame.size.width/2-80, 0, 160, 160)];
    [logoImageView setBackgroundColor:NavigationBarTintColor];
    [logoBaseView addSubview:logoImageView];
    
    UIView *userBaseView = [[UIView alloc] initWithFrame:CGRectMake(15, 64 + 200 + 24, screenWidth - 15 * 2, 50)];
    [userBaseView.layer setBorderWidth:1.5];
    [userBaseView.layer setBorderColor:[UIColor hexStringToColor:@"f4f4f4"].CGColor];
    [self.baseScrollView addSubview:userBaseView];
    
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, userBaseView.frame.size.height)];
    userLabel.text = @"+86";
    userLabel.font = [UIFont systemFontOfSize:17];
    userLabel.textAlignment = NSTextAlignmentCenter;
    userLabel.textColor = [UIColor hexStringToColor:@"666666"];
    [userLabel.layer setBorderWidth:0.5];
    [userLabel.layer setBorderColor:[UIColor hexStringToColor:@"f4f4f4"].CGColor];
    [userBaseView addSubview:userLabel];
    
    _userNameTF = [[UITextField  alloc] initWithFrame:CGRectMake(60, 0, userBaseView.frame.size.width - userLabel.frame.size.width, userBaseView.frame.size.height)];
    _userNameTF.keyboardType = UIKeyboardTypeNumberPad;
    _userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userNameTF.placeholder = @"  请输入您的手机号";
    [_userNameTF setTintColor:[UIColor blueColor]];
    _userNameTF.delegate = self;
    _userNameTF.tag = 1000;
    _userNameTF.font = [UIFont fontWithName:@"System" size:16];
    [_userNameTF.layer setBorderWidth:0.5];
    [_userNameTF.layer setBorderColor:[UIColor hexStringToColor:@"f4f4f4"].CGColor];
    _userNameTF.userInteractionEnabled = YES;
    [userBaseView addSubview:_userNameTF];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"username"]!=nil) {
        _userNameTF.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    }
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, userBaseView.frame.size.height - 1, userBaseView.frame.size.width, 1)];
    line1.backgroundColor = [UIColor hexStringToColor:@"dddddd"];
    [userBaseView addSubview:line1];
    
    UIView *pwdBaseView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(userBaseView.frame) + 24, userBaseView.frame.size.width, userBaseView.frame.size.height)];
    [pwdBaseView.layer setBorderWidth:1.5];
    [pwdBaseView.layer setBorderColor:[UIColor hexStringToColor:@"f4f4f4"].CGColor];
    [self.baseScrollView addSubview:pwdBaseView];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_WIDTH);
    _button.center = CGPointMake(pwdBaseView.frame.size.width - BUTTON_WIDTH + 5, pwdBaseView.frame.size.height/2);
    [_button setBackgroundImage:[UIImage imageNamed:@"cleartext_con"] forState:UIControlStateNormal];
    [_button setTintColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]];
    [_button addTarget:self action:@selector(buttonMethod) forControlEvents:UIControlEventTouchUpInside];
    [pwdBaseView addSubview:_button];
    
    UILabel *pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -1, 0, pwdBaseView.frame.size.height)];
    pwdLabel.text = @"密   码";
    pwdLabel.font = [UIFont systemFontOfSize:17];
    pwdLabel.textAlignment = NSTextAlignmentCenter;
    pwdLabel.textColor = [UIColor hexStringToColor:@"666666"];
    [pwdBaseView addSubview:pwdLabel];
    
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pwdLabel.frame) + 10, 0, pwdBaseView.frame.size.width - pwdLabel.frame.size.width - _button.frame.size.width*1.5 - 10, pwdBaseView.frame.size.height)];
    _passwordTF.secureTextEntry = YES;
    _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTF.placeholder = @"请输入登录密码";
    [_passwordTF setTintColor:[UIColor blueColor]];
    _passwordTF.delegate = self;
    _passwordTF.tag = 1001;
    _passwordTF.font = [UIFont fontWithName:@"System" size:16];
    [pwdBaseView addSubview:_passwordTF];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, pwdBaseView.frame.size.height - 1, pwdBaseView.frame.size.width, 1)];
    line2.backgroundColor = [UIColor hexStringToColor:@"dddddd"];
    [pwdBaseView addSubview:line2];
    
    
    _forgetPwdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forgetPwdButton setFrame:CGRectMake(pwdBaseView.frame.origin.x, CGRectGetMaxY(pwdBaseView.frame)+ 40, 80, 40)];
    [_forgetPwdButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [_forgetPwdButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_forgetPwdButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    //uibutton标题左对齐
    _forgetPwdButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_forgetPwdButton addTarget:self action:@selector(forgetPasswordButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.baseScrollView addSubview:_forgetPwdButton];
    
    _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerButton.frame = CGRectMake(screenWidth - 10 - 80, _forgetPwdButton.frame.origin.y, 80, 40);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"注册账号"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [_registerButton setAttributedTitle:str forState:UIControlStateNormal];
    [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_registerButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_registerButton.layer setBorderColor:lightGreenColor.CGColor];
    [_registerButton addTarget:self action:@selector(registerButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.baseScrollView addSubview:_registerButton];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setFrame:CGRectMake(pwdBaseView.frame.origin.x, CGRectGetMaxY(_forgetPwdButton.frame) + 10, screenWidth- 15 * 2, pwdBaseView.frame.size.height)];
    [_loginButton setBackgroundColor:NavigationBarTintColor];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_loginButton.layer setCornerRadius:0];
    [_loginButton.layer setMasksToBounds:YES];
    [_loginButton addTarget:self action:@selector(loginBobcareButtonMethod1) forControlEvents:UIControlEventTouchUpInside];
    [self.baseScrollView addSubview:_loginButton];
}
- (void)hidWeChatMethod
{
    _weiboLoginButton.center = CGPointMake(WIDTH / 2 - THIRD_BUTTON_DISTINCE + 10 - THIRD_BUTTON_WIDTH / 2, _wechatLoginButton.center.y);
    _qqLoginButton.center = CGPointMake(WIDTH / 2 + THIRD_BUTTON_DISTINCE - 10 + THIRD_BUTTON_WIDTH / 2,  _qqLoginButton.center.y);
    [self.wechatLoginButton setHidden:YES];
}
- (void)buttonMethod
{
    _isSecure = !_isSecure;
    if (_isSecure)
    {
        [_button setBackgroundImage:[UIImage imageNamed:@"cleartext_on"] forState:UIControlStateNormal];
    }
    else
    {
        [_button setBackgroundImage:[UIImage imageNamed:@"cleartext_con"] forState:UIControlStateNormal];
    }
    _passwordTF.secureTextEntry = !_passwordTF.secureTextEntry;
    _passwordTF.font = [UIFont fontWithName:@"System" size:16];
}

- (void)forgetPasswordButtonMethod
{
    [_userNameTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    
    ForgetPasswordVC *forgetVC = [[ForgetPasswordVC alloc] init];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:forgetVC] animated:YES completion:nil];
}

- (void)registerButtonMethod
{
    [_userNameTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    
    RegisterVC *registerVC = [[RegisterVC alloc] init];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:registerVC] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma methods

- (void)loginTest
{
//    JFCompleteInfoVC *firstVC = [[JFCompleteInfoVC alloc] init];
//    [firstVC setHidesBottomBarWhenPushed:YES];
//    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:firstVC animated:YES];
}

- (void)loginBobcareButtonMethod1
{
    [_userNameTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        
    } completion:nil];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     NSString * strURL = [NSString stringWithFormat:@"%@?phoneNumber=%@&password=%@&mediaType=%@",kLoginURL,_userNameTF.text,[UtilFun md5:_passwordTF.text],@"my"];
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
                
                //存储userID
                [[NSUserDefaults standardUserDefaults] setObject:response.body.userId forKey:@"userId"];
                //用单例存储数据
                [SingletonFun shareInstance].loginResponse = response;
                [JPUSHService setTags:nil alias:response.body.userId callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:nil];
                //登录成功，跳转界面
                if (response.body.name.length == 0) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToFirstLogin" object:nil];
                }else{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToMainTB" object:nil];
                    
                }
            }else if ([response.status floatValue] > 200 && [response.status floatValue] <400) {
               
                
                //存储userID
                [[NSUserDefaults standardUserDefaults] setObject:response.body.userId forKey:@"userId"];
                //用单例存储数据
                [SingletonFun shareInstance].loginResponse = response;
                [JPUSHService setTags:nil alias:response.body.userId callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:nil];
                //登录成功，跳转界面
                if (response.body.name.length == 0) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToFirstLogin" object:nil];
                }else{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToMainTB" object:nil];
                    //                    [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToFirstLogin" object:nil];
                }
                
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
-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}
#pragma mark touch手势收键盘

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_userNameTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        
    } completion:nil];
}
#pragma - mark tap点击收键盘
- (void)tapMethod:(UITapGestureRecognizer *)tap
{
    [_userNameTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        
    } completion:nil];
}
#pragma mark textFieldDelegate

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame =CGRectMake(0, 0, screenWidth, screenHeight);
    } completion:nil];
}

#pragma mark - LoginButton Methods

- (void)qqLoginButtonPressed
{
    NSLog(@"%s",__func__);
    
//    _tencentOAth = [[TencentOAuth alloc] initWithAppId:QQAppKey andDelegate:self];
//    
//    NSArray *permissions = [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo",@"add_t",nil];
//    
//    [_tencentOAth authorize:permissions inSafari:NO];
}

- (void)wechatLoginButtonPressed
{
    NSLog(@"%s",__func__);
    
//    //构造SendAuthReq结构体
//    SendAuthReq* req =[[SendAuthReq alloc] init];
//    req.scope = @"snsapi_userinfo" ;
//    req.state = @"123" ;
//    //第三方向微信终端发送一个SendAuthReq消息结构
//    [WXApi sendReq:req];
}

- (void)weiboLoginButtonPressed
{
    NSLog(@"%s",__func__);
    
//    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
//    request.redirectURI = kRedirectURI;
//    request.scope = @"all";
//    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//    [WeiboSDK sendRequest:request];
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
#pragma mark - Setters && Getters

- (UIButton *)qqLoginButton
{
    if (!_qqLoginButton)
    {
        UIImage *qqImage = [UIImage imageNamed:@"login_QQ"];
        
        _qqLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _qqLoginButton.frame = CGRectMake(0, 0, THIRD_BUTTON_WIDTH, THIRD_BUTTON_WIDTH);
        _qqLoginButton.center = CGPointMake(WIDTH / 2 + THIRD_BUTTON_WIDTH + THIRD_BUTTON_DISTINCE, _wechatLoginButton.center.y);
        [_qqLoginButton setImage:qqImage forState:UIControlStateNormal];
        [_qqLoginButton setImage:qqImage forState:UIControlStateHighlighted];
        [_qqLoginButton addTarget:self action:@selector(qqLoginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _qqLoginButton;
}

- (UIButton *)wechatLoginButton
{
    if (!_wechatLoginButton)
    {
        float precent;
        
        if ([UIScreen mainScreen].bounds.size.height == 480)
        {
            precent = 0.9;
        }
        else
        {
            precent = 0.8;
        }
        
        UIImage *wechatImage = [UIImage imageNamed:@"login_wechat"];
        
        _wechatLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _wechatLoginButton.frame = CGRectMake(0, 0, THIRD_BUTTON_WIDTH, THIRD_BUTTON_WIDTH);
        _wechatLoginButton.center = CGPointMake(WIDTH / 2, HEIGHT * precent);
        [_wechatLoginButton setImage:wechatImage forState:UIControlStateNormal];
        [_wechatLoginButton setImage:wechatImage forState:UIControlStateHighlighted];
        [_wechatLoginButton addTarget:self action:@selector(wechatLoginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _wechatLoginButton;
}

- (UIButton *)weiboLoginButton
{
    if (!_weiboLoginButton)
    {
        UIImage *weiboImage = [UIImage imageNamed:@"login_weibo"];
        
        _weiboLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _weiboLoginButton.frame = CGRectMake(0, 0, THIRD_BUTTON_WIDTH, THIRD_BUTTON_WIDTH);
        _weiboLoginButton.center = CGPointMake(WIDTH / 2 - THIRD_BUTTON_WIDTH - THIRD_BUTTON_DISTINCE, _wechatLoginButton.center.y);
        [_weiboLoginButton setImage:weiboImage forState:UIControlStateNormal];
        [_weiboLoginButton setImage:weiboImage forState:UIControlStateHighlighted];
        [_weiboLoginButton addTarget:self action:@selector(weiboLoginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _weiboLoginButton;
}

- (UIImageView *)attentionImageView
{
    if (!_attentionImageView)
    {
        int margin;
        
        if ([UIScreen mainScreen].bounds.size.height == 736)
        {
            margin = 40;
        }
        else
        {
            margin = 30;
        }
        
        UIImage *attentionImage = [UIImage imageNamed:@"login_attention"];
        
        _attentionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, attentionImage.size.width, attentionImage.size.height)];
        _attentionImageView.center = CGPointMake(WIDTH / 2, CGRectGetMinY(_qqLoginButton.frame) - margin);
        _attentionImageView.image = attentionImage;
    }
    
    return _attentionImageView;
}

#pragma mark - TencentSessionDelegate

//登陆完成调用

- (void)tencentDidLogin

{
//    if (_tencentOAth.accessToken &&0 != [_tencentOAth.accessToken length])
//    {
//        NSLog(@"accessToken %@",_tencentOAth.accessToken);
//        
//        NSLog(@"openId %@",_tencentOAth.openId);
//        
//        tencentOpenId = _tencentOAth.openId;
//        
//        [_tencentOAth getUserInfo];
//    }
//    else
//    {
//        NSLog(@"登录不成功没有获取accesstoken");
//    }
    
}


//非网络错误导致登录失败：
-(void)tencentDidNotLogin:(BOOL)cancelled

{
    
    NSLog(@"tencentDidNotLogin");
    
    if (cancelled)
    {
        NSLog(@"用户取消登录");
    }
    else
    {
        NSLog(@"登录失败");
    }
    
}

// 网络错误导致登录失败：
- (void)tencentDidNotNetWork

{
    NSLog(@"tencentDidNotNetWork");
}

//- (void)getUserInfoResponse:(APIResponse *)response
//
//{
//    NSLog(@"respons:%@",response.jsonResponse);
//    
//    NSString *memNickName = response.jsonResponse[@"nickname"];
//    NSString *memSex = [response.jsonResponse[@"gender"] isEqualToString:@"男"] ? @"1" : @"0";
//    
//    [self loginWithOpenId:tencentOpenId memNickName:memNickName memSex:memSex];
//}

#pragma mark - Wechat Delegate

- (void)wechatDidLoginNotification:(NSNotification *)notification
{
    NSLog(@"%s",__func__);
    
    NSDictionary *userInfo = [notification userInfo];
    NSString *code = [userInfo objectForKey:@"code"];
    
    NSLog(@"code %@",code);
    
    [self getWechatAccessTokenWithCode:code];
}
- (void)wechatPrePayNotification:(NSNotification *)notification
{
    NSLog(@"%s",__func__);
    
    NSDictionary *userInfo = [notification userInfo];
    NSString *prepayId = [userInfo objectForKey:@"prepayId"];
    
    NSLog(@"prepayId %@",prepayId);
    //调用服务器，发送订单号
}
- (void)getWechatAccessTokenWithCode:(NSString *)code
{
//    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WechatAppKey,WechatSecrectKey,code];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSURL *zoneUrl = [NSURL URLWithString:url];
//        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
//        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            if (data)
//            {
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                
//                NSLog(@"%@",dic);
//                NSString *accessToken = dic[@"access_token"];
//                NSString *openId = dic[@"openid"];
//                
//                [self getWechatUserInfoWithAccessToken:accessToken openId:openId];
//            }
//        });
//    });
}

- (void)getWechatUserInfoWithAccessToken:(NSString *)accessToken openId:(NSString *)openId
{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openId];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (data)
            {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                NSLog(@"%@",dic);
                
                NSString *openId = [dic objectForKey:@"openid"];
                NSString *memNickName = [dic objectForKey:@"nickname"];
                NSString *memSex = [dic objectForKey:@"sex"];
                
                [self loginWithOpenId:openId memNickName:memNickName memSex:memSex];
            }
        });
        
    });
}

#pragma mark - Weibo Methods

- (void)weiboDidLoginNotification:(NSNotification *)notification
{
    NSLog(@"%s",__func__);
    
    NSDictionary *userInfo = [notification userInfo];
    NSString *accessToken = [userInfo objectForKey:@"accessToken"];
    NSString *uid = [userInfo objectForKey:@"userId"];
    
    NSLog(@"userInfo %@",userInfo);
    
    [self getWeiboUserInfoWithAccessToken:accessToken uid:uid];
}

- (void)getWeiboUserInfoWithAccessToken:(NSString *)accessToken uid:(NSString *)uid
{
    NSString *url =[NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",accessToken,uid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data)
            {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                NSLog(@"%@",dic);
                
                NSString *openId = [dic objectForKey:@"id"];
                NSString *memNickName = [dic objectForKey:@"name"];
                NSString *memSex = [[dic objectForKey:@"gender"] isEqualToString:@"m"] ? @"1" : @"0";
                
                [self loginWithOpenId:openId memNickName:memNickName memSex:memSex];
            }
        });
        
    });
}

#pragma mark - ThirdLogin Methods

- (void)loginWithOpenId:(NSString *)openId memNickName:(NSString *)memNickName memSex:(NSString *)memSex
{
//    NSString * deviceString = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"DeviceToken"]];
//    deviceString = [deviceString substringWithRange:NSMakeRange(1, deviceString.length-2)];
//    
//    NSDictionary *dic = @{
//                          @"thirdId" : openId,
//                          @"deviceNum" : deviceString,
//                          @"memOs" : @"0",
//                          @"memSex" : memSex,
//                          @"memNickName" : memNickName
//                          };
//    
//    _HUD = [JFProgressHUD showWaitingHUDInView:self.view text:nil];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"html/text", nil];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [manager POST:loginURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//        
//        NSDictionary *dataDic = [JFUtils getJsonDictionaryWithXMLData:responseObject];
//        
//        LoginResponse *loginResponse = [[LoginResponse alloc] initWithDictionary:dataDic];
//        
//        if(loginResponse != nil && loginResponse.code == 200)
//        {
//            [SingletonFun shareInstance].loginResponse = loginResponse;
//            
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
//            [[NSUserDefaults standardUserDefaults] setObject:openId forKey:@"thirdOpenId"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            
//            CustomEntity* memberEntity = [[CustomEntity alloc]initWithDictionary:dataDic[@"memberEntity"]];
//            
//            // io ID
//            NSString *userId = memberEntity.id;
//            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//            
//            userInfo[@"name"] = memberEntity.memNickName;
//            
//            if ([memberEntity.memSex isEqualToString:@"1"])
//            {
//                userInfo[@"gender"] = @"男";
//            }
//            else
//            {
//                userInfo[@"gender"] = @"女";
//            }
//            
//            userInfo[@"birthday"] = memberEntity.memBday;
//            userInfo[@"avatar"] = memberEntity.memPic;
//            
//            [[Zhuge sharedInstance] identify:userId properties:userInfo];
//            NSDictionary * properties = @{@"结果":@"登录"};
//            [[Zhuge sharedInstance] track:@"患者端登录（iOS）" properties: properties];
//            
//            /////////////////////////有赞商城登录/////////////////////////////
//            //这里CacheUserInfo是iOS的Demo中的数据缓存类，YZUserModel是SDK中一个有赞User的数据模型，CacheUserInfo的isValid的字段可以存储用户信息是否同步成功,如果不成功，后面使用js注入方式
//            CacheUserInfo *cacheModel = [CacheUserInfo sharedManage];
//            cacheModel.userId = memberEntity.id;
//            cacheModel.name = memberEntity.memNickName;
//            cacheModel.gender = memberEntity.memSex;
//            cacheModel.telephone = memberEntity.memName;
//            cacheModel.avatar = memberEntity.memPic;
//            
//            NSLog(@"userId%@",cacheModel.userId);
//            
//            if(!cacheModel.isValid)
//            {
//                YZUserModel *userModel = [CacheUserInfo getYZUserModelFromCacheUserModel:cacheModel];
//                [YZSDK showTopShopBar:NO];
//                [YZSDK registerYZUser:userModel callBack:^(NSString *message, BOOL isError) {
//                    
//                    if(isError)
//                    {
//                        cacheModel.isValid = NO;
//                    }
//                    else
//                    {
//                        cacheModel.isValid = YES;
//                        //加载指定url...
//                    }
//                }];
//            } else {
//                //加载url...
//            }
//            
//            /////////////////////////IM登录////////////////////////////////
//            BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
//            if (!isAutoLogin)
//            {
//                //登录
//                [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[NSString stringWithFormat:@"mem%@",loginResponse.memberEntity.id] password:loginResponse.memberEntity.memPwd completion:^(NSDictionary *loginInfo, EMError *error) {
//                    
//                    if (!error && loginInfo)
//                    {
//                        NSLog(@"登陆成功");
//                        
//                        if (loginResponse.memberEntity.physiologyEntity == nil)
//                        {
//                            JFCompleteInfoVC *firstVC = [[JFCompleteInfoVC alloc] init];
//                            [firstVC setHidesBottomBarWhenPushed:YES];
//                            self.navigationController.navigationBarHidden = YES;
//                            [self.navigationController pushViewController:firstVC animated:YES];
//                            [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//                        }
//                        else
//                        {
//                            [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToTab" object:self];
//                            [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//                        }
//                        
//                        //登录回调方法
//                        [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//                    }
//                    else
//                    {
//                        NSLog(@"IMerror:%@",error);
//                        
//                        EMError *error = nil;
//                        
//                        NSDictionary *info = [[EaseMob sharedInstance].chatManager logoffWithUnbindDeviceToken:YES error:&error];
//                        NSLog(@"%@",info);
//                        if (!error && info)
//                        {
//                            NSLog(@"退出成功");
//                        }
//                        [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//                    }
//                } onQueue:nil];
//            }
//            else
//            {
//                //自动登录
//                [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[NSString stringWithFormat:@"mem%@",loginResponse.memberEntity.id] password:loginResponse.memberEntity.memPwd completion:^(NSDictionary *loginInfo, EMError *error) {
//                    if (!error)
//                    {
//                        // 设置自动登录
//                        [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
//                        [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//                    }
//                } onQueue:nil];
//            }
//            
//        }
//        else{
//            [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//            [JFProgressHUD showTextHUDInView:self.view text:loginResponse.info detailText:nil hideAfterDelay:1.5];
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//        NSLog(@"ERROR %@",error);
//    }];
}

@end

