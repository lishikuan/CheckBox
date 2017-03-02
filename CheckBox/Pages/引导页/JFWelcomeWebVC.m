//
//  JFWelcomeWebVC.m
//  BobcareCustomApp
//
//  Created by 汪继峰 on 16/8/16.
//  Copyright © 2016年 com.gm.partynews. All rights reserved.
//

#import "JFWelcomeWebVC.h"

@interface JFWelcomeWebVC () <UIWebViewDelegate>

@property(nonatomic, strong) UIWebView *webView;

@end

@implementation JFWelcomeWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"载入中...";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    [self.navigationController.navigationBar setTintColor:[UIColor hexStringToColor:@"666666"]];
    [self.navigationController.navigationBar setBarTintColor:kNavWhiteColor];
    
    [self.view addSubview:self.webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_requestUrlStr]];
    [_webView loadRequest:request];
}

- (void)back
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startToLoadMainInterface" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - --- UIWebView Delegate ---

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.title = @"载入中...";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - --- Setter ---


#pragma mark - --- Getter ---

- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64)];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
        //        _webView.opaque = NO;
        _webView.scalesPageToFit = YES;
    }
    
    return _webView;
}

@end
