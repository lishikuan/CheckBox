//
//  SingletonFun.h
//  CheckBox
//
//  Created by lsm on 17/1/11.
//  Copyright © 2017年 lsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginResponse.h"
#import "TakePhotoResponse.h"
@interface SingletonFun : NSObject
@property (nonatomic, retain)LoginResponse * loginResponse;
@property (nonatomic, retain)TakePhotoResponse * takePhotoResponse;
//储存当前网络状态
@property (nonatomic, assign) int webStatus;
@property (nonatomic, assign) BOOL hasSetWebStatus;

@property (nonatomic, assign) BOOL isFromFirstPage;
+(instancetype) shareInstance;
@end
