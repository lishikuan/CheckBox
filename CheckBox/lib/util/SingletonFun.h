//
//  SingletonFun.h
//  BobcareCustomApp
//
//  Created by li on 15/8/6.
//  Copyright (c) 2015年 com.01wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "LoginResponse.h"
////#import "AddResponse.h"
//#import "QueryResponse.h"
//#import "QueryDoctorResponse.h"
//#import "ProvinceResponse.h"
//#import "Response.h"
//#import "LogoutResponse.h"
////#import "BindPhoneResponse.h"
//#import "FeedBackResponse.h"
//#import "ChangePasswordResponse.h"
//#import "UpdateTreatmentResponse.h"
//#import "QuerySelfInfoResponse.h"
//#import "OrderEventsResponse.h"

@class YZCacheUserInfo;

@interface SingletonFun : NSObject

//@property (strong, nonatomic)LoginResponse * loginResponse;
////@property (strong, nonatomic)AddResponse * addResponse;
//@property (strong, nonatomic)QueryResponse * queryResponse;
//@property (strong, nonatomic)QueryDoctorResponse * queryDoctorResponse;
//@property (strong, nonatomic)ProvinceResponse * provinceResponse;
//@property (strong, nonatomic)Response * response;
//@property (strong, nonatomic)LogoutResponse * logoutResponse;
////@property (strong, nonatomic)BindPhoneResponse * bindPhoneResponse;
//@property (strong, nonatomic)FeedBackResponse * feedBackResponse;
//@property (strong, nonatomic)ChangePasswordResponse * changePasswordResponse;
//@property (strong, nonatomic)UpdateTreatmentResponse * updateTreatmentResponse;
//@property (strong, nonatomic)QuerySelfInfoResponse * querySelfInfoResponse;
//@property (strong, nonatomic)OrderEventsResponse * orderEventsResponse;

//储存当前网络状态
@property (nonatomic, assign) int webStatus;
@property (nonatomic, assign) BOOL hasSetWebStatus;

@property (nonatomic, assign) BOOL isFromFirstPage;

//版本号
@property (nonatomic, strong) NSString *versionStr;

@property (nonatomic, strong) YZCacheUserInfo *cacheUserInfo;

@property (nonatomic, assign) BOOL isBabyOuthor; /*  是否从我的保贝中进行微信授权 */

@property (nonatomic, strong) NSDictionary *userInfo;/** 推送信息字典*/

@property (nonatomic, assign) BOOL hasLogin;/** 是否已登录*/

+(SingletonFun *)sharedInstanceMethod;

@end
