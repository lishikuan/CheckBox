//
//  UtilFun.h
//  BobcareDoctorApp
//
//  Created by frank on 15/7/19.
//  Copyright (c) 2015年 com.01wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilFun : NSObject{
    
}
+(NSString *)md5:(NSString *)str;
+(NSDictionary *)changeResponseToDictionary:(id)responseObject;
@end
