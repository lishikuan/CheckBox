//
//  NotificationCenterVC.m
//  CheckBox
//
//  Created by lsm on 16/12/25.
//  Copyright © 2016年 lsm. All rights reserved.
//

#import "NotificationCenterVC.h"
#import "NotificationCenterDetailVC.h"
@interface NotificationCenterVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * titleArray;
    NSMutableArray * textArray;
}
@property (strong, nonatomic) UITableView * tableView;
@end

@implementation NotificationCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //自定义tablebar
    UILabel * label = [[UILabel alloc]init];
    [label setText:@"消息中心"];
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
    
    
    titleArray = [[NSMutableArray alloc]init];
    textArray = [[NSMutableArray alloc]init];
    [titleArray addObjectsFromArray:@[@"title1",@"title2",@"title3",@"title4",@"title5",@"title6",@"title7"]];
    [textArray addObjectsFromArray:@[@"2016年",@"2016年",@"2016年",@"2016年",@"2016年",@"2016年",@"2016年",@"2016年",@"2016年"]];
    [self addContextView];
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
- (void)addContextView
{
    [self.view addSubview:self.tableView];
    [self setExtraCellLineHidden:self.tableView];
}

#pragma - mark listview datasource
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (titleArray.count > indexPath.row) {
        [cell.textLabel setText:[NSString stringWithFormat:@"%@",titleArray[indexPath.row]]];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",textArray[indexPath.row]]];
    }
    
    return cell;
}
#pragma - mark listview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotificationCenterDetailVC * detailVC = [[NotificationCenterDetailVC alloc]init];
    detailVC.userInfo = @{@"title":@"标题",@"createdTime":@"2016年12月25日",@"content":@"我是内容"};
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma - mark Setters and Getters
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        [_tableView setFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
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
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}
@end
