//
//  MeSettingFeedBackViewController.m
//  BobcareCustomApp
//
//  Created by li on 15/8/14.
//  Copyright (c) 2015年 com.01wisdom. All rights reserved.
//

#import "MeSettingFeedBackViewController.h"
#import "JFUtils.h"
#import "JFProgressHUD.h"


//动画时间
#define kAnimationDuration 0.2
//view高度
#define kViewHeight 56
@interface MeSettingFeedBackViewController ()<UITextViewDelegate>
{
    int width;
    int height;
    UITextView * adviceTextView;
    UILabel * _messageLabel;
    UIButton * commitButton;
    MBProgressHUD *_HUD;
}
@end

@implementation MeSettingFeedBackViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //自定义tablebar
    UILabel * label = [[UILabel alloc]init];
    [label setText:@"意见反馈"];
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
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)backBtnMethod
{
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
    // Do any additional setup after loading the view.
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    adviceTextView = [[UITextView alloc]init];
    [adviceTextView setFrame:CGRectMake(10, 10, width-20, 200)];
    [adviceTextView.layer setBorderColor:[UIColor hexStringToColor:@"999999"].CGColor];
    [adviceTextView.layer setBorderWidth:1.0];
    [adviceTextView.layer setCornerRadius:4.0];
    [adviceTextView setFont:[UIFont systemFontOfSize:16]];
    adviceTextView.delegate = self;
    
    UILabel * placeLabel = [[UILabel alloc]init];
    [placeLabel setTag:1];
    [placeLabel setFrame:CGRectMake(8, 8, width-20, 20)];
    [placeLabel setNumberOfLines:0];
    [placeLabel setFont:[UIFont systemFontOfSize:16]];
    [placeLabel setAdjustsFontSizeToFitWidth:YES];
    [placeLabel setTextColor:[UIColor grayColor]];
    [placeLabel setText:@"请在此处填写您的意见(至少填写10个字) "];
    [adviceTextView addSubview:placeLabel];
    
    
    //定义一个toolBar
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //设置style
    [topView setBarStyle:UIBarStyleBlack];
    //定义两个flexibleSpace的button，放在toolBar上，这样完成按钮就会在最右边
    UIBarButtonItem * button1 =[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * button2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //定义完成按钮
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    //在toolBar上加上这些按钮
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [topView setItems:buttonsArray];
    [adviceTextView setInputAccessoryView:topView];
    //取消iOS7的边缘延伸效果（例如导航栏，状态栏等等）
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    commitButton = [[UIButton alloc]init];
    [commitButton setFrame:CGRectMake(20, height - 60 - 64,width-40, 40)];
    [commitButton.layer setCornerRadius:5];
    [commitButton setTitle:@"写好了，提交" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitButton setBackgroundColor:NavigationBarTintColor];
    commitButton.layer.masksToBounds = YES;
    [commitButton addTarget:self action:@selector(commitButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:adviceTextView];
    
    
    _messageLabel = [[UILabel alloc] init];
    [_messageLabel setFrame:CGRectMake(adviceTextView.frame.size.width-300, adviceTextView.frame.size.height-10, 300, 20)];
    _messageLabel.text = @"您还可以输入200个字";
    _messageLabel.textColor = [UIColor lightGrayColor];
    _messageLabel.textAlignment = NSTextAlignmentRight;
    _messageLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_messageLabel];
    [self.view addSubview:commitButton];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)commitButtonMethod
{
    if ([JFUtils isBlankString:adviceTextView.text])
    {
        [JFProgressHUD showTextHUDInView:self.view text:@"请输入您的意见" detailText:nil hideAfterDelay:1.5];
        return;
    }
    if (adviceTextView.text.length < 10)
    {
        [JFProgressHUD showTextHUDInView:self.view text:@"请至少输入10个字符" detailText:nil hideAfterDelay:1.5];
        return;
    }
    if (![JFUtils valifateSpecialCharacter:adviceTextView.text])
    {
        [JFProgressHUD showTextHUDInView:self.view text:@"请输入合法字符" detailText:nil hideAfterDelay:1.5];
        return ;
    }
    
    _HUD = [JFProgressHUD showWaitingHUDInView:self.view text:nil];
    
    //反馈
//    NSString *strURL =feedbackURL;
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:adviceTextView.text  forKey:@"fbContext"];
//    [dict setObject:[SingletonFun shareInstance].loginResponse.memberEntity.id forKey:@"id"];
//    if ([SingletonFun shareInstance].loginResponse.memberEntity.token.length == 0) {
//        [dict setObject:@"" forKey:@"token"];
//    }else{
//        [dict setObject:[SingletonFun shareInstance].loginResponse.memberEntity.token forKey:@"token"];
//    }
//    [dict setObject:@"0" forKey:@"memFlag"];
//    [dict setObject:@"0" forKey:@"memOs"];
//    [dict setObject:@"0" forKey:@"os"];
//    
//    NSLog(@"dic:%@",dict);
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
//    [manager setResponseSerializer:responseSer];
//    [manager POST:strURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSMutableDictionary *responseCustomEntity = [JFUtils getJsonDictionaryWithXMLParse:responseObject];
//        FeedBackResponse *feedBackResponse = nil;
//        feedBackResponse = [[FeedBackResponse alloc] initWithDictionary:responseCustomEntity];
//        if (feedBackResponse != nil || feedBackResponse.code == 200) {
//            
//            NSDictionary * properties = @{@"结果":@"意见反馈-提交"};
//            [[Zhuge sharedInstance] track:@"意见反馈-提交（iOS）" properties: properties];
//            
//            [JFProgressHUD showTextHUDInView:self.view text:@"提交成功，感谢您的反馈" detailText:nil hideAfterDelay:1.5];
//            [self performSelector:@selector(backBtnMethod) withObject:self afterDelay:1.5];
//            
//        }else{
//            [JFProgressHUD showTextHUDInView:self.view text:feedBackResponse.info detailText:nil hideAfterDelay:1.5];
//        }
//        
//        [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        UIAlertView * alert=[ [UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误，请检查网络设置" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil ];
//        [alert show];
//        [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//    }];
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma textView delegate

//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    NSLog(@"end editing");
//}
//- (void)textViewDidChange:(UITextView *)textView
//{
//    if (textView.text.length == 0) {
//        UILabel * placeLabel = (UILabel *)[textView viewWithTag:1];
//        [placeLabel setHidden:NO];
//    }else{
//        UILabel * placeLabel = (UILabel *)[textView viewWithTag:1];
//        [placeLabel setHidden:YES];
//    }
//
//}
#pragma mark textView delegate

//点击enter键隐藏键盘
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//
//    if ([text isEqualToString:@"\n"])
//    { [textView resignFirstResponder];
//        return NO;
//    }
//
//    return YES;
//}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    CGRect frame = textView.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0 - 44);//键盘高度216，Xcode6后软键盘上有高度为44的提示栏
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    self.view.frame =CGRectMake(0, 64, WIDTH, HEIGHT);
}

- (void)textViewDidChange:(UITextView *)textView
{
    //隐藏placeLabel
    if (textView.text.length == 0) {
        UILabel * placeLabel = (UILabel *)[textView viewWithTag:1];
        [placeLabel setHidden:NO];
    }else{
        UILabel * placeLabel = (UILabel *)[textView viewWithTag:1];
        [placeLabel setHidden:YES];
    }
    //计数
    int count = (int)(200 - textView.text.length);
    if (count < 0)
    {
        count = 0;
    }
    
    if (textView.text.length >= 200)
    {
        textView.text = [textView.text substringToIndex:200];
    }
    
    _messageLabel.text = [NSString stringWithFormat:@"您还可以输入%d个字",count];
    
}

// 键盘弹出时
-(void)keyboardDidShow:(NSNotification *)notification {
    //获取键盘高度
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]; CGRect keyboardRect; [keyboardObject getValue:&keyboardRect];
    //调整放置有textView的view的位置
    //设置动画
    [UIView beginAnimations:nil context:nil];
    //定义动画时间
    [UIView setAnimationDuration:kAnimationDuration];
    //设置view的frame，往上平移
    [(UIView *)[self.view viewWithTag:1000] setFrame:CGRectMake(0, self.view.frame.size.height-keyboardRect.size.height-kViewHeight, 320, kViewHeight)];
    [UIView commitAnimations];
}
//键盘消失时
-(void)keyboardDidHidden {
    //定义动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimationDuration];
    //设置view的frame，往下平移
    [(UIView *)[self.view viewWithTag:1000] setFrame:CGRectMake(0, self.view.frame.size.height, 320, kViewHeight)];
    [UIView commitAnimations];
}
- (void)resignKeyboard
{
    
    [adviceTextView resignFirstResponder];
}


#pragma mark - 点击屏幕收键盘

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [adviceTextView resignFirstResponder];
}

@end
