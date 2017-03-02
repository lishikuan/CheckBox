//
//  LoginResponse.h
//  CheckBox
//
//  Created by lsm on 17/1/8.
//  Copyright © 2017年 lsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginEntity.h"
@interface LoginResponse : Jastor{
    
}
@property (nonatomic, copy) NSString * message;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, retain) LoginEntity * body;

@end
