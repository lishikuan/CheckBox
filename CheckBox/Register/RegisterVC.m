//
//  RegisterVC.m
//  CheckBox
//
//  Created by lsm on 16/12/11.
//  Copyright © 2016年 lsm. All rights reserved.
//
#define kButtonWidth 100
#define kCountTime 30

#import "RegisterVC.h"
#import "UtilFun.h"
#import "JFProgressHUD.h"
#import "RegisterSMSResponse.h"
#import "RegisterResponse.h"
@interface RegisterVC ()<UITextFieldDelegate>{

    UITextField *_userNameTF;
    UITextField *_passwordTF;
    UITextField *_ensurePasswordTF;
    UITextField *_verifyCodeTF;
    UIButton *_verityButton;
    NSTimer *_countTimer;//倒计时计时器
    int _countTime;
    NSString * smsId;
    
    MBProgressHUD *_HUD;
}

@end

@implementation RegisterVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"注册";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBarTintColor:NavigationBarTintColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonMethod)];
    
    _countTime = kCountTime;
    
    [self addContentView];
}

- (void)addContentView
{
    UIImage *image = [UIImage imageNamed:@"login_image"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imageView.image = image;
    imageView.center = CGPointMake(screenWidth/2, 140);
    [self.view addSubview:imageView];
    
    UIView *userNameView = [[UIView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(imageView.frame)+30, screenWidth-40*2, 40)];
    userNameView.layer.borderWidth = 1;
    userNameView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    userNameView.layer.cornerRadius = 1;
    [self.view addSubview:userNameView];
    
    UIView *verifyCodeView = [[UIView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(userNameView.frame)+10, screenWidth-kButtonWidth-5-40*2, 40)];
    verifyCodeView.layer.borderWidth = 1;
    verifyCodeView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    verifyCodeView.layer.cornerRadius = 1;
    [self.view addSubview:verifyCodeView];
    
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(verifyCodeView.frame)+10, screenWidth-40*2, 40)];
    passwordView.layer.borderWidth = 1;
    passwordView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    passwordView.layer.cornerRadius = 1;
    [self.view addSubview:passwordView];
    
    UIView *ensurePasswordView = [[UIView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(passwordView.frame)+10, screenWidth-40*2, 40)];
    ensurePasswordView.layer.borderWidth = 1;
    ensurePasswordView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    ensurePasswordView.layer.cornerRadius = 1;
    [self.view addSubview:ensurePasswordView];
    
    
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, userNameView.frame.size.height)];
    userLabel.text = @"+86";
    userLabel.font = [UIFont systemFontOfSize:17];
    userLabel.textAlignment = NSTextAlignmentCenter;
    userLabel.textColor = [UIColor hexStringToColor:@"666666"];
    [userLabel.layer setBorderWidth:1.0];
    [userLabel.layer setBorderColor:[UIColor hexStringToColor:@"999999"].CGColor];
    [userNameView addSubview:userLabel];
    
    _userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, userNameView.frame.size.width-15-60, userNameView.frame.size.height)];
    _userNameTF.placeholder = @"请输入手机号";
    _userNameTF.keyboardType = UIKeyboardTypeNumberPad;
    _userNameTF.delegate = self;
    [_userNameTF setTintColor:[UIColor blueColor]];
    _userNameTF.tag = 1000;
    [userNameView addSubview:_userNameTF];
    
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, userNameView.frame.size.width-15, userNameView.frame.size.height)];
    _passwordTF.placeholder = @"请输入密码";
    _passwordTF.secureTextEntry = YES;
    _passwordTF.delegate = self;
    [_passwordTF setTintColor:[UIColor blueColor]];
    _passwordTF.tag = 1001;
    [passwordView addSubview:_passwordTF];
    
    _ensurePasswordTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, userNameView.frame.size.width-15, userNameView.frame.size.height)];
    _ensurePasswordTF.placeholder = @"再一次输入密码";
    _ensurePasswordTF.secureTextEntry = YES;
    _ensurePasswordTF.delegate = self;
    [_ensurePasswordTF setTintColor:[UIColor blueColor]];
    _ensurePasswordTF.tag = 1002;
    [ensurePasswordView addSubview:_ensurePasswordTF];
    
    _verifyCodeTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, userNameView.frame.size.width-15-kButtonWidth, userNameView.frame.size.height)];
    _verifyCodeTF.placeholder = @"输入验证码";
    _verifyCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    _verifyCodeTF.delegate = self;
    [_verifyCodeTF setTintColor:[UIColor blueColor]];
    _verifyCodeTF.tag = 1003;
    [verifyCodeView addSubview:_verifyCodeTF];
    
    _verityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_verityButton setFrame:CGRectMake(screenWidth-kButtonWidth-40, CGRectGetMinY(verifyCodeView.frame), kButtonWidth, verifyCodeView.frame.size.height)];
    [_verityButton setBackgroundColor:NavigationBarTintColor];
    [_verityButton.layer setCornerRadius:4.0f];
    [_verityButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verityButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_verityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_verityButton addTarget:self action:@selector(verityButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_verityButton];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([UIScreen mainScreen].bounds.size.height ==480)
    {
        registerButton.frame = CGRectMake(40, CGRectGetMaxY(ensurePasswordView.frame)+10, screenWidth-40*2, 40);
    }
    else
    {
        registerButton.frame = CGRectMake(40, CGRectGetMaxY(ensurePasswordView.frame)+100, screenWidth-40*2, 40);
    }
    [registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerButton setBackgroundColor:NavigationBarTintColor];
    [registerButton.titleLabel setTextColor:[UIColor whiteColor]];
    [registerButton addTarget:self action:@selector(registerButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
}

- (void)backButtonMethod
{
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    
    if (viewcontrollers.count > 1)
    {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self)
        {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        //present方式
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }

}

- (void)verityButtonPressed
{
    NSLog(@"点击验证码");
    
    if (![JFUtils validateMobileNumber:_userNameTF.text])
    {
        [JFProgressHUD showTextHUDInView:self.view text:@"请输入正确的手机号" detailText:nil hideAfterDelay:1.5];
    }
    else
    {
        NSString * strURL = [NSString stringWithFormat:@"%@?phoneNumber=%@&type=register",kRegisterSMSURL,_userNameTF.text];
        strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _HUD = [JFProgressHUD showWaitingHUDInView:self.view text:nil];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/plain", nil];
        [manager POST:strURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             NSDictionary *dict = (NSDictionary *)responseObject;
             if (dict != nil)
             {
                 
                 
                 NSLog(@"dict %@",dict);
                 
                 RegisterSMSResponse * response = nil;
                 NSMutableDictionary *responseEntity = (NSMutableDictionary *)dict;
                 
                 response = [[RegisterSMSResponse alloc] initWithDictionary:responseEntity];
                 NSLog(@"%@",response.body.captcha);
                 //传值
                 [_verifyCodeTF setText:response.body.captcha];
                 smsId = response.body.smsId;
             }
             
             [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"ERROR %@",error);
             [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
         }];
        
    }
    
}

- (void)countDown
{
    [_verityButton setTitle:[NSString stringWithFormat:@"%ds",_countTime] forState:UIControlStateNormal];
    if (_countTime == 0)
    {
        _countTime = kCountTime;
        [_countTimer setFireDate:[NSDate distantFuture]];
        [_verityButton setTitle:@"获取" forState:UIControlStateNormal];
        [_verityButton setUserInteractionEnabled:YES];
    }
    _countTime--;
}

- (void)registerButtonMethod
{

    if (_userNameTF.text.length == 0 || _passwordTF.text.length == 0 || _ensurePasswordTF.text.length == 0 ||_verifyCodeTF.text.length == 0)
    {
        [JFProgressHUD showTextHUDInView:self.view text:@"用户名、密码、验证码不可为空" detailText:nil hideAfterDelay:1.5];
    }
    else if (![_passwordTF.text isEqualToString:_ensurePasswordTF.text])
    {
        [JFProgressHUD showTextHUDInView:self.view text:@"两次密码输入不一致" detailText:nil hideAfterDelay:1.5];
    }
    else if (![JFUtils validateMobileNumber:_userNameTF.text])
    {
        [JFProgressHUD showTextHUDInView:self.view text:@"请输入合法的手机号" detailText:nil hideAfterDelay:1.5];
    }
    else
    {
        //注册

        _HUD = [JFProgressHUD showWaitingHUDInView:self.view text:nil];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/plain", nil];
        NSString * name = [[NSString stringWithFormat:@"%@",_userNameTF.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString * strURL = [NSString stringWithFormat:@"%@?name=%@&phoneNumber=%@&password=%@&mediaType=%@&captcha=%@&smsId=%@",kRegisterURL,name,_userNameTF.text,[UtilFun md5:_passwordTF.text],@"my",_verifyCodeTF.text,smsId];
        strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager POST:strURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = (NSDictionary *)responseObject;
            if (dict != nil)
            {
                
                RegisterResponse * response = nil;
                NSMutableDictionary *responseEntity = (NSMutableDictionary *)dict;
                
                response = [[RegisterResponse alloc] initWithDictionary:responseEntity];
                if ([response.status floatValue] == 200) {
                    [JFProgressHUD showTextHUDInView:self.view text:@"成功" detailText:nil hideAfterDelay:1.5];
                    //注册成功，返回登录界面
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

                }else{
                    [JFProgressHUD showTextHUDInView:self.view text:response.message detailText:nil hideAfterDelay:1.5];
                    //注册失败，返回登录界面
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

                }
                
            }
            
            [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
        }];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark textField Delegate

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGFloat distance;
    
    if ([UIScreen mainScreen].bounds.size.height == 568)
    {
        switch (textField.tag)
        {
            case 1002:
            {
                distance = 60;
                break;
            }
            case 1003:
            {
                distance = 80;
                break;
            }
            default:
                break;
        }
    }
    else if ([UIScreen mainScreen].bounds.size.height == 480)
    {
        switch (textField.tag)
        {
            case 1002:
            {
                distance = 100;
                break;
            }
            case 1003:
            {
                distance = 150;
                break;
            }
            case 1001:
            {
                distance = 60;
                break;
            }
            default:
                break;
        }
    }
    else
    {
        distance = 40;
    }
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectMake(0, -distance, self.view.frame.size.width, self.view.frame.size.height);
    } completion:nil];
}

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_userNameTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    [_ensurePasswordTF resignFirstResponder];
    [_verifyCodeTF resignFirstResponder];
}


@end
