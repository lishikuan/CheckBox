//
//  SingletonFun.m
//  BobcareCustomApp
//
//  Created by li on 15/8/6.
//  Copyright (c) 2015年 com.01wisdom. All rights reserved.
//

#import "SingletonFun.h"

@implementation SingletonFun

//@synthesize loginResponse;
static SingletonFun * sharedInstance;
//获取单例
+(SingletonFun *)sharedInstanceMethod
{
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

//唯一一次alloc单例，之后均返回nil
+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}

//copy返回单例本身
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
@end
