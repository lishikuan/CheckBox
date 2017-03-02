//
//  MeSettingChangePasswordViewController.m
//  BobcareCustomApp
//
//  Created by li on 15/8/17.
//  Copyright (c) 2015年 com.01wisdom. All rights reserved.
//

#import "MeSettingChangePasswordViewController.h"
#import "JFProgressHUD.h"

@interface MeSettingChangePasswordViewController ()
{
    int width;
    int height;
    UITableView * listView;
    //
    UITextField * oldPasswordTextField;
    UITextField * newPasswordTextField;
    UITextField * ensurePasswordTextField;
    MBProgressHUD *_HUD;
}
@end

@implementation MeSettingChangePasswordViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //自定义tablebar
    UILabel * label = [[UILabel alloc]init];
    [label setText:@"修改密码"];
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
//    listView = [[UITableView alloc]init];
//    [listView setFrame:CGRectMake(0, 0, width, height-108)];
//    listView.dataSource = self;
//    listView.delegate = self;
//    listView.delaysContentTouches = NO;
//    listView.scrollEnabled = NO;//禁止滑动
//    //隐藏多余cell
//    [self setExtraCellLineHidden:listView];
//    
//    [self.view addSubview:listView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    int headerHeight = 0;
    UILabel * addLabel1 = [[UILabel alloc]init];
    [addLabel1 setFrame:CGRectMake(10, headerHeight, 140, 40)];
    [addLabel1 setText:@"账号："];
//    [addLabel1 setTextColor:[UIColor hexStringToColor:@"666666"]];
    UITextField * addTextField1 = [[UITextField alloc]init];
    [addTextField1 setFrame:CGRectMake(150, headerHeight, width-150, 40)];
    [addTextField1 setEnabled:NO];
    [self.view addSubview:addLabel1];
    [self.view addSubview:addTextField1];
    
    UILabel * addLabel2 = [[UILabel alloc]init];
    [addLabel2 setFrame:CGRectMake(10, headerHeight+50, 140, 40)];
    [addLabel2 setText:@"请输入原密码："];
    oldPasswordTextField = [[UITextField alloc]init];
    [oldPasswordTextField setFrame:CGRectMake(150, headerHeight+50, width-150, 40)];
    [oldPasswordTextField setPlaceholder:@"请输入原密码"];
    [oldPasswordTextField setEnabled:YES];
    oldPasswordTextField.secureTextEntry = YES;
    oldPasswordTextField.delegate = self;
    [self.view addSubview:addLabel2];
    [self.view addSubview:oldPasswordTextField];
    
    UILabel * addLabel3 = [[UILabel alloc]init];
    [addLabel3 setFrame:CGRectMake(10, headerHeight+50*2, 140, 40)];
    [addLabel3 setText:@"请输入新密码："];
    newPasswordTextField = [[UITextField alloc]init];
    [newPasswordTextField setFrame:CGRectMake(150, headerHeight+50*2, width-150, 40)];
    [newPasswordTextField setPlaceholder:@"请输入新密码"];
    [newPasswordTextField setEnabled:YES];
    newPasswordTextField.secureTextEntry = YES;
    newPasswordTextField.delegate = self;
    [self.view addSubview:addLabel3];
    [self.view addSubview:newPasswordTextField];
    
    UILabel * addLabel4 = [[UILabel alloc]init];
    [addLabel4 setFrame:CGRectMake(10, headerHeight+50*3, 140, 40)];
    [addLabel4 setText:@"请输入确认密码："];
    ensurePasswordTextField = [[UITextField alloc]init];
    [ensurePasswordTextField setFrame:CGRectMake(150, headerHeight+50*3, width-150, 40)];
    [ensurePasswordTextField setPlaceholder:@"请输入确认密码"];
    [ensurePasswordTextField setEnabled:YES];
    ensurePasswordTextField.secureTextEntry = YES;
    ensurePasswordTextField.delegate = self;
    [self.view addSubview:addLabel4];
    [self.view addSubview:ensurePasswordTextField];
    
    UIButton * addButton = [[UIButton alloc]init];
    [addButton setFrame:CGRectMake(10, headerHeight+50*4, width-20, 40)];
    [addButton setTitle:@"保存" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton setBackgroundColor:NavigationBarTintColor];
    [addButton.layer setCornerRadius:5];
    [addButton addTarget:self action:@selector(changePasswordMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma - mark listView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.section];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]init];
        if (indexPath.section == 0) {
            if (indexPath.row == 4) {
                
                
                UIButton * addButton = [[UIButton alloc]init];
                [addButton setTag:1];
                [addButton setFrame:CGRectMake(10, 10, width-20, 40)];
                
                UIView * view = [[UIView alloc]initWithFrame:cell.contentView.frame];
                [view setBackgroundColor:[UIColor whiteColor]];
                
                [cell.contentView addSubview:addButton];
                [cell setSelectedBackgroundView:view];
            }else{
                UILabel * addLabel = [[UILabel alloc]init];
                [addLabel setTag:1];
                [addLabel setFrame:CGRectMake(10, 5, 140, 40)];
                UITextField * addTextField = [[UITextField alloc]init];
                [addTextField setTag:2];
                [addTextField setFrame:CGRectMake(150, 5, width-150, 40)];
                
                [cell.contentView addSubview:addLabel];
                [cell.contentView addSubview:addTextField];
            }
        }
        
        
    }
    //cell重用
    if(indexPath.section == 0){
        if (indexPath.row == 0) {
            UILabel * addLabel = (UILabel *)[cell viewWithTag:1];
            [addLabel setText:@"账号："];
            UITextField * addTextField = (UITextField *)[cell viewWithTag:2];
            [addTextField setEnabled:NO];
        }
        if (indexPath.row == 1) {
            UILabel * addLabel = (UILabel *)[cell viewWithTag:1];
            [addLabel setText:@"请输入原密码："];
            oldPasswordTextField = (UITextField *)[cell viewWithTag:2];
            [oldPasswordTextField setPlaceholder:@"请输入原密码"];
            [oldPasswordTextField setEnabled:YES];
            oldPasswordTextField.secureTextEntry = YES;
            oldPasswordTextField.returnKeyType = 
            oldPasswordTextField.delegate = self;
        }
        if (indexPath.row == 2) {
            UILabel * addLabel = (UILabel *)[cell viewWithTag:1];
            [addLabel setText:@"请输入新密码："];
            newPasswordTextField = (UITextField *)[cell viewWithTag:2];
            [newPasswordTextField setPlaceholder:@"请输入新密码"];
            [newPasswordTextField setEnabled:YES];
            newPasswordTextField.secureTextEntry = YES;
            newPasswordTextField.delegate = self;
        }
        if (indexPath.row == 3) {
            UILabel * addLabel = (UILabel *)[cell viewWithTag:1];
            [addLabel setText:@"请输入确认密码："];
            ensurePasswordTextField = (UITextField *)[cell viewWithTag:2];
            [ensurePasswordTextField setPlaceholder:@"请输入确认密码"];
            [ensurePasswordTextField setEnabled:YES];
            ensurePasswordTextField.secureTextEntry = YES;
            ensurePasswordTextField.delegate = self;
        }
        if (indexPath.row == 4) {
            
            UIButton * addButton = (UIButton *)[cell viewWithTag:1];
            [addButton setTitle:@"保存" forState:UIControlStateNormal];
            [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [addButton setBackgroundColor:lightGreenColor];
            [addButton.layer setCornerRadius:5];
            [addButton addTarget:self action:@selector(changePasswordMethod) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 50;
        }
        if (indexPath.row == 1) {
            return 50;
        }
        if (indexPath.row == 2) {
            return 50;
        }
        if (indexPath.row == 3) {
            return 50;
        }
        if (indexPath.row == 4) {
            return 500;
        }
        
    }
    return 0;
}

//隐藏多余tableviewcell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

#pragma - mark listview button-methods
- (void)changePasswordMethod
{
    if (oldPasswordTextField.text.length == 0)
    {
        [JFProgressHUD showTextHUDInView:self.view text:@"请输入原密码" detailText:nil hideAfterDelay:1.5];
        return;
    }
    else if (newPasswordTextField.text.length==0)
    {
        [JFProgressHUD showTextHUDInView:self.view text:@"请输入新密码" detailText:nil hideAfterDelay:1.5];
        return ;
    }
    else if (![newPasswordTextField.text isEqualToString:ensurePasswordTextField.text])
    {
        [JFProgressHUD showTextHUDInView:self.view text:@"确认密码与新密码不匹配" detailText:nil hideAfterDelay:1.5];
        return ;
    }
    
    
    
    
    _HUD = [JFProgressHUD showWaitingHUDInView:self.view text:nil];
    //密码
//    NSString *strURL =modifyPassWordURL;
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:[UtilFun md5:oldPasswordTextField.text]  forKey:@"memPwd"];
//    [dict setObject:[UtilFun md5:newPasswordTextField.text]  forKey:@"newMemPwd"];
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
    
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
//    [manager setResponseSerializer:responseSer];
//    [manager POST:strURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSMutableDictionary *responseCustomEntity = [JFUtils getJsonDictionaryWithXMLParse:responseObject];
//        ChangePasswordResponse *changePasswordResponse = nil;
//        changePasswordResponse = [[ChangePasswordResponse alloc] initWithDictionary:responseCustomEntity];
//        if (changePasswordResponse != nil || changePasswordResponse.code == 200) {
//            [self.navigationController popViewControllerAnimated:YES];
//            [JFProgressHUD showTextHUDInView:self.view text:changePasswordResponse.info detailText:nil hideAfterDelay:1.5];
//        }else{
//            [JFProgressHUD showTextHUDInView:self.view text:changePasswordResponse.info detailText:nil hideAfterDelay:1.5];
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




#pragma textField
//开始编辑输入框的时候，软键盘出现，执行此事件
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
////    CGRect frame = textField.frame;
////    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0 - 44);//键盘高度216，Xcode6后软键盘上有高度为44的提示栏
//    
//    int offset = 100.0f;
//    
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

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    if (textField.tag == 1) {
        NSLog(@"username:%@",textField.text);
        
    }else if (textField.tag == 2){
        NSLog(@"password:%@",textField.text);
        
    }
    
}
#pragma mark touch手势收键盘

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [oldPasswordTextField resignFirstResponder];
    [newPasswordTextField resignFirstResponder];
    [ensurePasswordTextField resignFirstResponder];
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        
    } completion:nil];
}

@end
