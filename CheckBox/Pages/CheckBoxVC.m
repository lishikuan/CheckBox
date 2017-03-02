//
//  CheckBoxVC.m
//  CheckBox
//
//  Created by lsm on 16/12/11.
//  Copyright © 2016年 lsm. All rights reserved.
//

#import "CheckBoxVC.h"
#import "UploadPictureVC.h"
@interface CheckBoxVC ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView * listView;
    NSArray * titleArray;
    NSMutableArray * textArray;
    
}

@end

@implementation CheckBoxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"调查问卷";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    [self.navigationController.navigationBar setTintColor:[UIColor hexStringToColor:@"666666"]];
    [self.navigationController.navigationBar setBarTintColor:kNavWhiteColor];
    titleArray = @[@"姓名",@"性别",@"年龄",@"头像",@"职业",@"爱好",@"家庭住址",@"邮政编码",@"联系方式"];
    textArray = [[NSMutableArray alloc]init];
    [textArray addObjectsFromArray:@[@"李世宽",@"男",@"25",@"",@"保险师",@"睡觉",@"河南省新乡市封丘县章鹿市村",@"453300",@"18612104296"]];
    [self addContentView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addContentView{
    listView = [[UITableView alloc]init];
    [listView setFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    listView.dataSource = self;
    listView.delegate = self;
    [self.view addSubview:listView];
}
#pragma - mark listView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.section];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
    }
    if (titleArray.count > indexPath.row) {
        [cell.textLabel setText:[NSString stringWithFormat:@"%@",titleArray[indexPath.row]]];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",textArray[indexPath.row]]];
    }
    if ([titleArray[indexPath.row] isEqualToString:@"头像"]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma - mark listview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([titleArray[indexPath.row] isEqualToString:@"头像"]) {
        [self performSegueWithIdentifier:@"uploadPictureVCID" sender:self];
    }
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
