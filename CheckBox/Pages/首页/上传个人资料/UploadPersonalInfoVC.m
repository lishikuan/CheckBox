//
//  UploadPersonalInfoVC.m
//  CheckBox
//
//  Created by lsm on 16/12/17.
//  Copyright © 2016年 lsm. All rights reserved.
//

#import "UploadPersonalInfoVC.h"
#import "SKFieldView.h"
@interface UploadPersonalInfoVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    
    UITableView * listView;
    NSArray * titleArray;
    NSMutableArray * textArray;
    NSMutableArray * placeHolderArray;
    id itemTF;
    
    NSString * nameStr;
    NSString * telphoneStr;
    NSString * idStr;
    NSString * wechatStr;
    NSString * qqStr;
    NSString * emailStr;
    NSString * zhimaStr;
    NSString * jiedaibaoStr;
    NSString * jinji1Str;
    NSString * jinji1TelphoneStr;
    NSString * jinji1RelationStr;
    NSString * jinji2Str;
    NSString * jinji2TelephoneStr;
    NSString * jinji2RelationStr;
}
@property (nonatomic, strong)UIScrollView * baseScrollView;
@property (nonatomic, strong)UIImageView * sectionImageView;
@property (nonatomic, strong)UIButton * commitButton;
@end

@implementation UploadPersonalInfoVC

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
    [label setText:@"上传个人资料"];
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

    
    titleArray = @[@"姓名",@"联系电话",@"性别",@"身份证号",@"QQ账号",@"微信账号",@"邮箱",@"芝麻分",@"借贷宝负债金额\t\n  （没负债可填0）",@"紧急联系人1",@"联系电话",@"与本人关系",@"紧急联系人2",@"联系电话",@"与本人关系"];
    textArray = [[NSMutableArray alloc]init];
    [textArray addObjectsFromArray:@[@"请输入您的真实姓名",@"请输入您的联系方式",@"",@"例如：140☓☓☓☓☓☓☓☓☓☓☓☓☓43",@"请输入您的QQ号",@"请输入您的微信账号",@"请输入您的邮箱",@"例如：☓☓☓分",@"请输入您的负债金额",@"请输入TA的姓名",@"请输入TA的联系方式",@"例如：哥哥",@"请输入TA的联系方式",@"例如：哥哥"]];
    placeHolderArray = [[NSMutableArray alloc]init];
    [placeHolderArray addObjectsFromArray:@[@"请输入您的真实姓名",@"请输入您的联系方式",@"",@"例如：140☓☓☓☓☓☓☓☓☓☓☓☓☓43",@"请输入您的QQ号",@"请输入您的微信账号",@"请输入您的邮箱",@"例如：☓☓☓分",@"请输入您的负债金额",@"请输入TA的姓名",@"请输入TA的联系方式",@"例如：哥哥",@"请输入TA的联系方式",@"例如：哥哥"]];
    [self addContentView];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - mark custom method
- (void)addContentView{
//    listView = [[UITableView alloc]init];
//    [listView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
//    listView.dataSource = self;
//    listView.delegate = self;
//    [self.view addSubview:listView];
    
    [self.view setBackgroundColor:[UIColor hexStringToColor:@"f4f4f4"]];
    [self.view setFrame:CGRectMake(0, 64, WIDTH, HEIGHT)];
    [self.view addSubview:self.baseScrollView];
    [self.baseScrollView addSubview:self.sectionImageView];
    [self.baseScrollView addSubview:self.commitButton];

    
    
}
- (void)commitBtnMethod:(UIButton *)btn
{
    if (nameStr.length == 0) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"姓名不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (telphoneStr.length == 0){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"联系电话不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (idStr.length == 0){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"身份证号不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (wechatStr.length == 0){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"微信账号不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (qqStr.length == 0){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"QQ账号不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (emailStr.length == 0){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"电子邮箱不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (zhimaStr.length == 0){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"芝麻分不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (jiedaibaoStr.length == 0){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"借贷宝负债金额不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (jinji1Str.length == 0){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"紧急联系人1姓名不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (jinji1TelphoneStr.length == 0){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"紧急联系人1联系电话不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (jinji1RelationStr.length == 0){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"紧急联系人1与本人关系不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (jinji2Str.length == 0){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"紧急联系人2姓名不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (jinji2TelephoneStr.length == 0){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"紧急联系人2联系电话不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (jinji2RelationStr.length == 0){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"紧急联系人2与本人关系不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        NSArray * array = @[nameStr,telphoneStr,idStr,wechatStr,qqStr,emailStr,zhimaStr,jiedaibaoStr,jinji1Str,jinji1TelphoneStr,jinji1RelationStr,jinji2Str,jinji2TelephoneStr,jinji2RelationStr];
        NSLog(@"提交个人信息:%@",array);
    
        [self resignKeyboard];
        UploadPictureVC * uploadPictureVC = [[UploadPictureVC alloc]init];
        uploadPictureVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:uploadPictureVC animated:YES];
    }
    
    
}
- (void)backBtnMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)getStringFromTextField:(UITextField *)textField
{
    
    switch (textField.tag-1002) {
        case 0:
            nameStr = textField.text;
            break;
        case 1:
            telphoneStr = textField.text;
            break;
        case 2:
            idStr = textField.text;
            break;
        case 3:
            wechatStr = textField.text;
            break;
        case 4:
            qqStr = textField.text;
            break;
        case 5:
            emailStr = textField.text;
            break;
        case 6:
            zhimaStr = textField.text;
            break;
        case 7:
            jiedaibaoStr = textField.text;
            break;
        case 8:
            jinji1Str = textField.text;
            break;
        case 9:
            jinji1TelphoneStr = textField.text;
            break;
        case 10:
            jinji1RelationStr = textField.text;
            break;
        case 11:
            jinji2Str = textField.text;
            break;
        case 12:
            jinji2TelephoneStr= textField.text;
            break;
        case 13:
            jinji2RelationStr = textField.text;
            break;
        default:
            break;
    }
    
}
#pragma - mark 自定义键盘
- (void)customKeyboard:(UITextField *)textField
{
    //定义一个toolBar
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
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
    [textField setInputAccessoryView:topView];
    
}
- (void)resignKeyboard
{
    [itemTF resignFirstResponder];
    [self getStringFromTextField:itemTF];

}
#pragma - mark listView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return titleArray.count;
    }
    if (section == 1) {
        return 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.section];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        if (indexPath.section == 0) {
//            UILabel * titleLabel = [[UILabel alloc]init];
//            titleLabel.tag = 0001 + indexPath.row;
//            
//            UITextField * textField = [[UITextField alloc]init];
//            textField.tag = 1002 + indexPath.row;
//            
//            [cell addSubview:titleLabel];
//            [cell addSubview:textField];
            SKFieldView * fieldView = [[SKFieldView alloc]init];
            fieldView.tag = 1001 + indexPath.row;
            
            [cell.contentView addSubview:fieldView];
        }
        if (indexPath.section == 1) {
            UIButton * commitBtn = [[UIButton alloc]init];
            commitBtn.tag = 2001;
            [cell addSubview:commitBtn];
            cell.userInteractionEnabled = YES;
            commitBtn.userInteractionEnabled = YES;
            tableView.userInteractionEnabled = YES;
        }
        
    }
    if (indexPath.section == 0) {
        if (titleArray.count > indexPath.row) {
//            NSString * textString = [NSString stringWithFormat:@"%@",titleArray[indexPath.row]];
//            CGSize size = CGSizeMake(MAXFLOAT, 30);
//            CGRect labelSize = [textString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
//            int viewX = 12;
//            int viewY = 0;
//            int viewWidth = 150;
//            int viewHeight = 50;
//            UILabel * titleLabel = (UILabel *)[cell viewWithTag:0001+indexPath.row];
//            [titleLabel setFrame:CGRectMake(viewX, viewY, viewWidth, viewHeight)];
//            [titleLabel setText:[NSString stringWithFormat:@"%@",titleArray[indexPath.row]]];
//            [titleLabel setFont:maxTextFont];
//            [titleLabel setTextAlignment:NSTextAlignmentRight];
//            [titleLabel setNumberOfLines:0];
//            
//            UITextField * textField = (UITextField *)[cell viewWithTag:1002 + indexPath.row];
//            [textField setFrame:CGRectMake(viewX + viewWidth, viewY, WIDTH-viewX*2-viewWidth, viewHeight)];
//            [textField setTextAlignment:NSTextAlignmentLeft];
//            [textField setFont:maxTextFont];
//            textField.delegate = self;
//            //自定义键盘
//            [self customKeyboard:textField];
//            if (textArray.count > indexPath.row) {
//                [textField setPlaceholder:[NSString stringWithFormat:@"%@",textArray[indexPath.row]]];
//            }
            SKFieldView * fieldView = (SKFieldView *)[cell viewWithTag:1001 + indexPath.row];
            [fieldView setFrame:CGRectMake(0, 0, WIDTH, 60)];
            [fieldView setImage:[UIImage imageNamed:@"标识"]];
            if (titleArray.count > indexPath.row) {
                [fieldView setTitle:[NSString stringWithFormat:@"%@",titleArray[indexPath.row]]];
            }
            if (textArray.count > indexPath.row) {
                [fieldView setPlaceHolder:[NSString stringWithFormat:@"%@",textArray[indexPath.row]]];
            }
            
        }
    }
    
    if (indexPath.section == 1) {
        UIButton * commitBtn = (UIButton *)[cell viewWithTag:2001];
        [commitBtn setFrame:CGRectMake(WIDTH/2-100, 10, 200, 30)];
        [commitBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [commitBtn addTarget:self action:@selector(commitBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
        [commitBtn setBackgroundColor:NavigationBarTintColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    }
    if (indexPath.section == 1) {
        return 160;
    }
    return 0;
}
#pragma - mark listview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma - mark Setters && Getters
- (UIScrollView *)baseScrollView
{
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc]init];
        [_baseScrollView setFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        [_baseScrollView setContentSize:CGSizeMake(WIDTH, titleArray.count*92/2+88/2+100)];
    }
    return _baseScrollView;
}
- (UIImageView *)sectionImageView
{
    if (!_sectionImageView) {
        _sectionImageView = [[UIImageView alloc]init];
        [_sectionImageView setFrame:CGRectMake(18/2, 0, WIDTH - (18/2)*2, titleArray.count*92/2+88/2)];
        [_sectionImageView setImage:[UIImage imageNamed:@"圆角矩形-7"]];
        [_sectionImageView.layer setCornerRadius:4.0f];
        _sectionImageView.userInteractionEnabled = YES;
        for (int i = 0; i < titleArray.count; i ++) {
            SKFieldView * fieldView = [[SKFieldView alloc]initWithFrame:CGRectMake(0,10+92/2*i, WIDTH - (18/2)*2, 92/2)];
            fieldView.tag = i;
            [fieldView setTitle:[NSString stringWithFormat:@"%@",titleArray[i]]];
            if (i < placeHolderArray.count) {
                [fieldView setPlaceHolder:[NSString stringWithFormat:@"%@",placeHolderArray[i]]];
            }
            
            [fieldView setImage:[UIImage imageNamed:@"标识"]];
            [fieldView setTitleLabelLength:120];
            [_sectionImageView addSubview:fieldView];
        }
    }
    return _sectionImageView;
}
- (UIButton *)commitButton
{
    if (!_commitButton) {
        _commitButton = [[UIButton alloc]init];
        [_commitButton setFrame:CGRectMake((WIDTH-(660)/2)/2, titleArray.count*92/2+50, 660/2, 90/2)];
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_commitButton.titleLabel setFont:midTextFont];
        [_commitButton setBackgroundColor:NavigationBarTintColor];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton.layer setCornerRadius:4.0f];
        [_commitButton addTarget:self action:@selector(commitBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}
#pragma - mark textField
//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.superview.frame;
    int offset = frame.origin.y + 32 - (HEIGHT - 216.0 - 44 - 80 - 40);//键盘高度216，Xcode6后软键盘上有高度为44的提示栏
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0){
        if (offset > 216 + 44) {
            offset = 216 + 44;
        }
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
    }
    itemTF = textField;
}

//当用户按下return键或者按回车键，keyboard消失

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self getStringFromTextField:textField];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//隐藏多余tableviewcell
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
