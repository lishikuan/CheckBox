//
//  SingletonFun.m
//  CheckBox
//
//  Created by lsm on 17/1/11.
//  Copyright © 2017年 lsm. All rights reserved.
//

#import "SingletonFun.h"

@implementation SingletonFun
static SingletonFun * _instance = nil;
+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [SingletonFun shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [SingletonFun shareInstance] ;
}@end
