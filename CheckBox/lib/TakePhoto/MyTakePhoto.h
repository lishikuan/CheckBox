//
//  MyTakePhoto.h
//  CheckBox
//
//  Created by lsm on 17/1/11.
//  Copyright © 2017年 lsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TakePhotoResponse.h"
@protocol TakePhotoDelegate <NSObject>

- (void)getTakePhotoResponse:(id)response;

@end
@interface MyTakePhoto : NSObject
@property (nonatomic , strong)id<TakePhotoDelegate> delegate;
- (void)setInView:(UIView *)view viewController:(UIViewController *)VC;
- (void)takePhotoToURL:(NSString *)url;
@end
