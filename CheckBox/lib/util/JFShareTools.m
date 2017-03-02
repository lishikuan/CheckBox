//
//  JFShareTools.m
//  BobcareCustomApp
//
//  Created by Japho on 15/11/30.
//  Copyright © 2015年 com.gm.partynews. All rights reserved.
//

#import "JFShareTools.h"
#import "WXApi.h"
#import <UIKit/UIKit.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import "JFUtils.h"

@implementation JFShareTools

+ (void)wechatShareLinkWithScene:(int)scene url:(NSString *)url title:(NSString *)title description:(NSString *)description andPicUrl:(NSString *)picUrl
{
    NSLog(@"分享url %@",url);
    
    //封装mediaMessage对象
    WXMediaMessage *message = [WXMediaMessage message];
    
    if ([JFUtils isBlankString:title])
    {
        message.title = @"贝贝壳分享";
    }
    else
    {
        message.title = title;
    }
    
    message.description = description;
    
    if (picUrl.length == 0 || picUrl == nil)
    {
        [message setThumbImage:[UIImage imageNamed:@"icon180"]];
    }
    else
    {
        NSLog(@"start");
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:picUrl]];
        UIImage *image = [UIImage imageWithData:imageData];
        
        //设置image的尺寸
        CGSize imagesize = image.size;
        CGFloat imageWidth = imagesize.width;
        CGFloat imageHeight = imagesize.height;
        imagesize = CGSizeMake(200, 200/(imageWidth/imageHeight));
        
        UIGraphicsBeginImageContext(imagesize);
        [image drawInRect:CGRectMake(0,0,imagesize.width,imagesize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData *newImageData = UIImageJPEGRepresentation(newImage, 1.0);
        
        NSLog(@"end");
        
        [message setThumbImage:[UIImage imageWithData:newImageData]];
    }
    
    
    NSLog(@"调用了微信");
    
    if (url.length > 200)
    {
        url = [self getShorUrlWithLongUrl:url];
    }
    
    //封装WXWebpageObject对象
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    
    message.mediaObject = ext;
    
    //发送请求
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    [WXApi sendReq:req];
}

+ (void)qqShareLinkWithScene:(QQShare_Type)scene url:(NSString *)url title:(NSString *)title description:(NSString *)description andPicUrl:(NSString *)picUrl
{
    NSLog(@"分享url %@",url);
    
    if (url.length > 200)
    {
        url = [self getShorUrlWithLongUrl:url];
    }
    
    NSURL *shareUrl = [NSURL URLWithString:url];
    NSString *mytitle;
    
    if ([JFUtils isBlankString:title])
    {
        mytitle = @"贝贝壳分享";
    }
    else
    {
        mytitle = title;
    }
    
    NSLog(@"调用了QQ");
    
    if (picUrl.length == 0 || picUrl == nil)
    {
        picUrl = @"http://m.bobcare.com/bobcarePic/180.png";
    }
    
    NSURL *imageUrl = [NSURL URLWithString:picUrl];
    
    QQApiObject *newsObj = [QQApiNewsObject objectWithURL:shareUrl title:mytitle description:description previewImageURL:imageUrl targetContentType:QQApiURLTargetTypeNews];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    
    switch (scene)
    {
            //分享给QQ好友
        case QQShare_Friends:
        {
            [QQApiInterface sendReq:req];
            break;
        }
            //分享给QQ空间
        case QQShare_Qzone:
        {
            [QQApiInterface SendReqToQZone:req];
            break;
        }
        default:
            break;
    }
}

+ (void)weiboShareLinkWithUrl:(NSString *)url title:(NSString *)title description:(NSString *)description andPicUrl:(NSString *)picUrl
{
    NSLog(@"分享url %@",url);
    
    NSLog(@"调用了微博");
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"http://www.bobcare.com";
    authRequest.scope = @"all";
    
    WBMessageObject *message = [WBMessageObject message];
    
    message.text = description;
    
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifier1";
    
    if ([JFUtils isBlankString:title])
    {
        webpage.title = @"贝贝壳分享";
    }
    else
    {
        webpage.title = title;
    }
    
    webpage.description = description;
    if (picUrl.length == 0 || picUrl == nil)
    {
        UIImage *image = [UIImage imageNamed:@"icon180"];
        webpage.thumbnailData = UIImageJPEGRepresentation(image, 1);
    }
    else
    {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:picUrl]];
        UIImage *image = [UIImage imageWithData:imageData];
        
        //设置image的尺寸
        CGSize imagesize = image.size;
        CGFloat imageWidth = imagesize.width;
        CGFloat imageHeight = imagesize.height;
        imagesize = CGSizeMake(100, 100/(imageWidth/imageHeight));
        
        UIGraphicsBeginImageContext(imagesize);
        [image drawInRect:CGRectMake(0,0,imagesize.width,imagesize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData *newImageData = UIImageJPEGRepresentation(newImage, 1.0);
        
        webpage.thumbnailData = newImageData;
    }
    
    if (url.length > 200)
    {
        url = [self getShorUrlWithLongUrl:url];
    }
    
    webpage.webpageUrl = url;
    message.mediaObject = webpage;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:myDelegate.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}

//对图片尺寸进行压缩--
- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

+ (NSString *)getShorUrlWithLongUrl:(NSString *)longUrl
{
    longUrl = [longUrl stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    
    NSString *url =[NSString stringWithFormat:@"http://api.t.sina.com.cn/short_url/shorten.json?source=1681459862&url_long=%@",longUrl];
    
    NSURL *zoneUrl = [NSURL URLWithString:url];
    NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
    
    if (data)
    {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"%@",arr);
        
        NSDictionary *tempDic = [arr firstObject];
        
        if ([[tempDic allKeys] containsObject:@"url_short"])
        {
            return tempDic[@"url_short"];
        }
    }
    
    return @"";
}

@end
