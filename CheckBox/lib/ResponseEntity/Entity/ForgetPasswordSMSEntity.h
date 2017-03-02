//
//  ForgetPasswordSMSEntity.h
//  CheckBox
//
//  Created by lsm on 17/1/8.
//  Copyright © 2017年 lsm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForgetPasswordSMSEntity : Jastor{
    
}
@property (nonatomic, copy  ) NSString         * captcha;
@property (nonatomic, copy  ) NSString         * phoneNumber;
@property (nonatomic, copy  ) NSString         * smsId;
@property (nonatomic, copy  ) NSString         * type;
@property (nonatomic, copy  ) NSString         * userId;
@end
