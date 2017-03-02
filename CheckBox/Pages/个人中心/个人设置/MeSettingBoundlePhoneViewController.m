//
//  MeSettingBoundlePhoneViewController.m
//  BobcareCustomApp
//
//  Created by li on 15/8/14.
//  Copyright (c) 2015年 com.01wisdom. All rights reserved.
//

#import "MeSettingBoundlePhoneViewController.h"
#import "JFUtils.h"
#import "UtilFun.h"
#import "SingletonFun.h"

#define kCountTime 60
@interface MeSettingBoundlePhoneViewController ()<UITextFieldDelegate>
{
    NSTimer *_countTimer;//倒计时计时器
    int _countTime;
    BOOL _isSecure;
}
@end

@implementation MeSettingBoundlePhoneViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"绑定手机号";
    
    self.view.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    
    [self.navigationController.navigationBar setBarTintColor:NavigationBarTintColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonMethod)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"绑定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnMethod)];
    
    _countTime = kCountTime;
    
    [self addContentView];
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
- (void)rightBtnMethod
{
    [self boundleMethod];//绑定手机号
}
- (void)addContentView
{
    UIView *accountLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _accountBaseView.frame.size.height - 1, _accountBaseView.frame.size.width, 1)];
    accountLineView.backgroundColor = [UIColor hexStringToColor:@"dddddd"];
    [_accountBaseView addSubview:accountLineView];
    
    UIView *pwdLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _pwdBaseView.frame.size.height - 1, _pwdBaseView.frame.size.width, 1)];
    pwdLineView.backgroundColor = [UIColor hexStringToColor:@"dddddd"];
    [_pwdBaseView addSubview:pwdLineView];
    
    UIView *veriCodeLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _veriCodeBaseView.frame.size.height - 1, _veriCodeBaseView.frame.size.width, 1)];
    veriCodeLineView.backgroundColor = [UIColor hexStringToColor:@"dddddd"];
    [_veriCodeBaseView addSubview:veriCodeLineView];

    [_veriCodeButton setBackgroundColor:[UIColor clearColor]];
    [_veriCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_veriCodeButton setTitleColor:lightGreenColor forState:UIControlStateNormal];
    [_veriCodeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [_cleartextButton setTitle:@"" forState:UIControlStateNormal];
    [_cleartextButton setBackgroundImage:[UIImage imageNamed:@"cleartext_con"] forState:UIControlStateNormal];
    [_cleartextButton setTintColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]];
    
    [_accountTF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_veriCodeTF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_pwdTF setClearButtonMode:UITextFieldViewModeWhileEditing];
    
    _accountTF.tag = 100;
    _veriCodeTF.tag = 101;
    _pwdTF.tag = 102;
    
    
    _accountTF.delegate = self;
    _veriCodeTF.delegate = self;
    _pwdTF.delegate = self;
    
    
    _pwdTF.secureTextEntry = YES;
    
    _accountTF.keyboardType = UIKeyboardTypeNumberPad;
    _veriCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark view methods
- (IBAction)veriCodeButtonPressed:(id)sender
{
    NSLog(@"%s",__func__);
    NSLog(@"点击验证码");
    
//    if (![JFUtils validateMobileNumber:_accountTF.text])
//    {
//        [JFProgressHUD showTextHUDInView:self.view text:@"请输入合法的手机号" detailText:nil hideAfterDelay:1.5];
//    }
//    else
//    {
//        _HUD = [JFProgressHUD showWaitingHUDInView:self.view text:nil];
//        
//        if (_accountTF.text.length==0)
//        {
//            [JFProgressHUD showTextHUDInView:self.view text:@"绑定手机号必须输入" detailText:nil hideAfterDelay:1.5];
//            return ;
//        }
//        //获取验证码
//        NSString *strURL =sendMsgURL;
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//        [dict setObject:_accountTF.text  forKey:@"memPhone"];
//        if ([SingletonFun shareInstance].loginResponse.memberEntity.id.length == 0) {
//            [dict setObject:@"" forKey:@"memId"];
//        }else{
//            [dict setObject:[SingletonFun shareInstance].loginResponse.memberEntity.id forKey:@"memId"];
//        }
//        [dict setObject:@"1" forKey:@"flag"];//1绑定；2忘记密码；5 邀请
//        [dict setObject:@"0" forKey:@"memFlag"];
//        
//        
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        
//        AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
//        [manager setResponseSerializer:responseSer];
//        [manager POST:strURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSDictionary *dataDic = [JFUtils getJsonDictionaryWithXMLParse:responseObject];
//             if ([[dataDic allKeys] containsObject:@"code"]) {
//                 if ([dataDic[@"code"] isEqualToString:@"200"])
//                 {
//                     [_veriCodeButton setTitle:[NSString stringWithFormat:@"%d秒后重发",_countTime] forState:UIControlStateNormal];
//                     [_veriCodeButton setUserInteractionEnabled:NO];
//                     
//                     if (!_countTimer)
//                     {
//                         _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
//                     }
//                     
//                     [_countTimer setFireDate:[NSDate distantPast]];
//                 }
//                 
//             }
//             if ([[dataDic allKeys] containsObject:@"info"]) {
//                 [JFProgressHUD showTextHUDInView:self.view text:@"提示" detailText:dataDic[@"info"] hideAfterDelay:1.5];
//             }
//             
//             [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//             
//         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             
//             NSLog(@"ERROR %@",error);
//             [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//         }];
//    }
}

- (void)countDown
{
    [_veriCodeButton setTitle:[NSString stringWithFormat:@"%d秒后重发",_countTime] forState:UIControlStateNormal];
    if (_countTime == 0)
    {
        _countTime = kCountTime;
        [_countTimer setFireDate:[NSDate distantFuture]];
        [_veriCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_veriCodeButton setUserInteractionEnabled:YES];
    }
    _countTime--;
}

- (IBAction)cleartextButtonPressed:(id)sender
{
    NSLog(@"%s",__func__);
    _isSecure = !_isSecure;
    if (_isSecure)
    {
        [_cleartextButton setBackgroundImage:[UIImage imageNamed:@"cleartext_on"] forState:UIControlStateNormal];
    }
    else
    {
        [_cleartextButton setBackgroundImage:[UIImage imageNamed:@"cleartext_con"] forState:UIControlStateNormal];
    }
    _pwdTF.secureTextEntry = !_pwdTF.secureTextEntry;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_accountTF resignFirstResponder];
    [_veriCodeTF resignFirstResponder];
    [_pwdTF resignFirstResponder];
}

#pragma - mark 绑定手机号
- (void)boundleMethod
{
//    if (_accountTF.text.length==0) {
//        
//        [JFProgressHUD showTextHUDInView:self.view text:@"绑定手机号必须输入" detailText:nil hideAfterDelay:1.5];
//        return ;
//    }
//    if (_veriCodeTF.text.length==0) {
//       
//        [JFProgressHUD showTextHUDInView:self.view text:@"验证码必须输入" detailText:nil hideAfterDelay:1.5];
//        return ;
//    }
//    if (_pwdTF.text.length==0) {
//        
//        [JFProgressHUD showTextHUDInView:self.view text:@"密码必须输入" detailText:nil hideAfterDelay:1.5];
//        return ;
//    }
//    _HUD = [JFProgressHUD showWaitingHUDInView:self.view text:nil];
//    //绑定
//    NSString *strURL =bindPhoneURL;
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:_accountTF.text  forKey:@"memPhone"];
//    if ([SingletonFun shareInstance].loginResponse.memberEntity.id.length == 0) {
//        [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//        return;
//    }else{
//        [dict setObject:[SingletonFun shareInstance].loginResponse.memberEntity.id forKey:@"memId"];
//    }
//    if ([SingletonFun shareInstance].loginResponse.memberEntity.token.length == 0) {
//        [dict setObject:@"" forKey:@"token"];
//    }else{
//        [dict setObject:[SingletonFun shareInstance].loginResponse.memberEntity.token forKey:@"token"];
//    }
//    [dict setObject:@"0" forKey:@"memFlag"];
//    [dict setObject:_veriCodeTF.text forKey:@"valiNum"];
//    [dict setObject:[UtilFun md5:_pwdTF.text] forKey:@"memPwd"];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
//    [manager setResponseSerializer:responseSer];
//    [manager POST:strURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSMutableDictionary *responseCustomEntity = [JFUtils getJsonDictionaryWithXMLParse:responseObject];
//        BindPhoneResponse *bindPhoneResponse = nil;
//        bindPhoneResponse = [[BindPhoneResponse alloc] initWithDictionary:responseCustomEntity];
//        if (bindPhoneResponse != nil && bindPhoneResponse.code == 200) {
//            
//            [JFProgressHUD showTextHUDInView:self.view text:bindPhoneResponse.info detailText:nil hideAfterDelay:1.5];
//            [self performSelector:@selector(backButtonMethod) withObject:self afterDelay:1.5];
//        }else{
//            
//            [JFProgressHUD showTextHUDInView:self.view text:bindPhoneResponse.info detailText:nil hideAfterDelay:1.5];
//        }
//        
//        [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//        [JFProgressHUD showTextHUDInView:self.view text:@"网络错误，请检查网络设置" detailText:nil hideAfterDelay:1.5];
//    }];
    
}

#pragma － mark UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([UIScreen mainScreen].bounds.size.height < 667)
    {
        switch (textField.tag)
        {
            case 101:
            {
                [UIView animateWithDuration:0.3f animations:^{
                    self.view.frame = CGRectMake(0, -30, self.view.frame.size.width, self.view.frame.size.height);
                } completion:nil];
                break;
            }
            case 102:
            {
                [UIView animateWithDuration:0.3f animations:^{
                    self.view.frame = CGRectMake(0, -60, self.view.frame.size.width, self.view.frame.size.height);
                } completion:nil];
                break;
            }
            default:
                break;
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    } completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
////获取验证码
//- (void)veifyCodeMethod{
//    
//    if (_accountTF.text.length==0) {
//        UIAlertView * alert=[ [UIAlertView alloc] initWithTitle:@"提示" message:@"绑定手机号必须输入" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil ];
//        [alert show];
//        return ;
//    }
//    _HUD = [JFProgressHUD showWaitingHUDInView:self.view text:nil];
//    //获取验证码
//    NSString *strURL =sendMsgURL;
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:_accountTF.text  forKey:@"memPhone"];
//    if ([SingletonFun shareInstance].loginResponse.memberEntity.id.length == 0) {
//        [dict setObject:@"" forKey:@"memId"];
//    }else{
//        [dict setObject:[SingletonFun shareInstance].loginResponse.memberEntity.id forKey:@"memId"];
//    }
//    [dict setObject:@"1" forKey:@"flag"];//1绑定；2忘记密码；5 邀请
//    [dict setObject:@"0" forKey:@"memFlag"];
//    
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
//    [manager setResponseSerializer:responseSer];
//    [manager POST:strURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSMutableDictionary *responseCustomEntity = [JFUtils getJsonDictionaryWithXMLParse:responseObject];
//        Response *loginResponse = nil;
//        loginResponse = [[Response alloc] initWithDictionary:responseCustomEntity];
//        {
//            UIAlertView * alert=[ [UIAlertView alloc] initWithTitle:@"提示" message:loginResponse.info delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil ];
//            [alert show];
//        }
//        [_accountTF resignFirstResponder];
//        [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        UIAlertView * alert=[ [UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误，请检查网络设置" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil ];
//        [alert show];
//        [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//    }];
//    
//}
//#pragma textField
////开始编辑输入框的时候，软键盘出现，执行此事件
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    CGRect frame = textField.frame;
//    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0 - 44);//键盘高度216，Xcode6后软键盘上有高度为44的提示栏
//    //    int offset = 260;
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    if(offset > 0)
//        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
//    
//    [UIView commitAnimations];
//}
//
////当用户按下return键或者按回车键，keyboard消失
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}
//
////输入框编辑完成以后，将视图恢复到原始状态
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
