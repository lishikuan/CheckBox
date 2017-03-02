//
//  JFShareTools.h
//  BobcareCustomApp
//
//  Created by Japho on 15/11/30.
//  Copyright © 2015年 com.gm.partynews. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    QQShare_Friends,
    QQShare_Qzone,
} QQShare_Type;

@interface JFShareTools : NSObject

/**
 *  分享链接给微信
 *
 *  @param scene       场景
 *  @param url         url
 *  @param description 描述
 */
+ (void)wechatShareLinkWithScene:(int)scene url:(NSString *)url title:(NSString *)title description:(NSString *)description andPicUrl:(NSString *)picUrl;

/**
 *  分享链接给QQ
 *
 *  @param scene 场景
 *  @param url   url
 *  @param description 描述
 */
+ (void)qqShareLinkWithScene:(QQShare_Type)scene url:(NSString *)url title:(NSString *)title description:(NSString *)description andPicUrl:(NSString *)picUrl;

/**
 *  分享链接给微博
 *
 *  @param url         链接
 *  @param description 描述
 */
+ (void)weiboShareLinkWithUrl:(NSString *)url title:(NSString *)title description:(NSString *)description andPicUrl:(NSString *)picUrl;

@end
