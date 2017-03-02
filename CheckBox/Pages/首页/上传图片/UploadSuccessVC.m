//
//  UploadSuccessVC.m
//  CheckBox
//
//  Created by lsm on 17/1/14.
//  Copyright © 2017年 lsm. All rights reserved.
//

#import "UploadSuccessVC.h"

@interface UploadSuccessVC ()
@property (nonatomic, strong)UIButton * confirmButton;
@end

@implementation UploadSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //自定义tablebar
    UILabel * label = [[UILabel alloc]init];
    [label setText:@"上传成功"];
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
    
    //添加视图
    [self addContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - mark custom methods
- (void)addContentView
{
    [self.view addSubview:self.confirmButton];
}
- (void)confirmButtonMethod:(UIButton *)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma - mark Setters & Getters
- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(50, HEIGHT/2, WIDTH-100, 40)];
        [_confirmButton setBackgroundColor:NavigationBarTintColor];
        [_confirmButton.layer setCornerRadius:4.0f];
        [_confirmButton setTitle:@"成功" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
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
