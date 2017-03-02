//
//  UploadUserInfoResponse.h
//  CheckBox
//
//  Created by lsm on 17/1/10.
//  Copyright © 2017年 lsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UploadUserInfoEntity.h"
@interface UploadUserInfoResponse : Jastor{
    
}
@property (nonatomic, copy) NSString * message;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, retain) UploadUserInfoEntity * body;


@end
