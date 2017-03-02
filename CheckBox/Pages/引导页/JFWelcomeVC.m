//
//  JFWelcomeVC.m
//  BobcareCustomApp
//
//  Created by 汪继峰 on 16/8/16.
//  Copyright © 2016年 com.gm.partynews. All rights reserved.
//

#import "JFWelcomeVC.h"
#import "UIImageView+WebCache.h"
#import "JFWelcomeWebVC.h"

#define BUTTON_WIDTH 44

static NSString *const localPicVersionStr = @"localPicVersionStr";
static NSString *const localADUrl = @"localADUrl";
static NSString *const imageName = @"welcomeImage";

// 广告显示的时间
static int const showtime = 3;

@interface JFWelcomeVC ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *adviseImageView;
@property (nonatomic, strong) UIButton *countButton;
@property (nonatomic, strong) NSString *adviseJumpUrlStr;
@property (nonatomic, strong) NSTimer *countTimer;
@property (nonatomic, assign) int count;

@end

@implementation JFWelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.adviseImageView];
    [self.view addSubview:self.countButton];
    [self reuqestPictureVersionData];
    [self startTimer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//查询欢迎页图片信息
- (void)reuqestPictureVersionData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"html/text", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager POST:kGetWelcomePic parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dataDic = [JFUtils getJsonDictionaryWithXMLData:responseObject];
        
        if ([[dataDic allKeys] containsObject:@"sysDataEntity"])
        {
            NSDictionary *tempDic = dataDic[@"sysDataEntity"];
            
            NSString *picUrlStr;
            NSString *picVersion;
            NSString *adviseUrl;
            
            if ([[tempDic allKeys] containsObject:@"dataCode"])
            {
                picUrlStr = tempDic[@"dataCode"];
            }
            if ([[tempDic allKeys] containsObject:@"dataName"])
            {
                picVersion = tempDic[@"dataName"];
            }
            if ([[tempDic allKeys] containsObject:@"dataValue"])
            {
                adviseUrl = tempDic[@"dataValue"];
            }
            
            NSString *currentPicVersion = [[NSUserDefaults standardUserDefaults] objectForKey:localPicVersionStr];
            
            if (![JFUtils isBlankString:picVersion])
            {
                if ([JFUtils isBlankString:currentPicVersion] || ([picVersion intValue] > [currentPicVersion intValue]))
                {
                    if (![JFUtils isBlankString:adviseUrl])
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:adviseUrl forKey:localADUrl];
                        [[NSUserDefaults standardUserDefaults] setObject:picVersion forKey:localPicVersionStr];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        self.adviseJumpUrlStr = adviseUrl;
                    }
                    
                    [self.adviseImageView setImageWithURL:[NSURL URLWithString:picUrlStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                        
                        NSLog(@"图片加载完成");
                    }];
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:picUrlStr]];
                        UIImage *image = [UIImage imageWithData:data];
                        
                        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
                        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
                        
                        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
                            NSLog(@"保存成功");
                            
                        }else{
                            NSLog(@"保存失败");
                        }
                        
                    });
                }
                else
                {
                    [self loadLocalAdviseView];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"ERROR %@",error);
        [self loadLocalAdviseView];
    }];
}

#pragma mark - --- Customed Mehtods ---

- (void)adviseImageViewDidSelected
{
    NSLog(@"%s",__func__);
    if (![JFUtils isBlankString:self.adviseJumpUrlStr])
    {
        [self.countTimer invalidate];
        self.countTimer = nil;
        
        JFWelcomeWebVC *webVC = [[JFWelcomeWebVC alloc] init];
        webVC.requestUrlStr = self.adviseJumpUrlStr;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

- (void)countButtonPressed
{
    [self.countTimer invalidate];
    self.countTimer = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startToLoadMainInterface" object:nil];
}

// 定时器倒计时
- (void)startTimer
{
    _count = showtime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

- (void)countDown
{
    _count --;
    [self.countButton setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
    if (_count == 0) {
        
        [self countButtonPressed];
    }
}

- (void)loadLocalAdviseView
{
    self.adviseJumpUrlStr = [[NSUserDefaults standardUserDefaults] objectForKey:localADUrl];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath])
    {
        NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
        UIImage *image = [UIImage imageWithData:data];
        
        self.adviseImageView.image = image;
    }
}

#pragma mark - --- getters ---

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView)
    {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _backgroundImageView.userInteractionEnabled = YES;
        
        if ([UIScreen mainScreen].bounds.size.width == 480)
        {
            _backgroundImageView.image = [UIImage imageNamed:@"welcome4"];
        }
        else
        {
            _backgroundImageView.image = [UIImage imageNamed:@"welcome6p"];
        }
    }
    
    return _backgroundImageView;
}

- (UIImageView *)adviseImageView
{
    if (!_adviseImageView)
    {
        _adviseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - WIDTH / 375.0 * 100)];
        _adviseImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adviseImageViewDidSelected)];
        [_adviseImageView addGestureRecognizer:tapGesture];
    }
    
    return _adviseImageView;
}

- (UIButton *)countButton
{
    if (!_countButton)
    {
        _countButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _countButton.frame = CGRectMake(WIDTH - BUTTON_WIDTH - 20, 20, BUTTON_WIDTH, BUTTON_WIDTH);
        _countButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        [_countButton setTitle:[NSString stringWithFormat:@"跳过%d",showtime] forState:UIControlStateNormal];
        [_countButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_countButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_countButton.layer setCornerRadius:BUTTON_WIDTH / 2.0];
        [_countButton addTarget:self action:@selector(countButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _countButton;
}

- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

@end
