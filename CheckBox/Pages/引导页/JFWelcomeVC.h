//
//  JFWelcomeVC.h
//  BobcareCustomApp
//
//  Created by 汪继峰 on 16/8/16.
//  Copyright © 2016年 com.gm.partynews. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JFWelcomeVCDelegate <NSObject>

/**
 *  启动页图片被点击
 */
- (void)welcomeVCAdviseViewPressed;

@end

@interface JFWelcomeVC : UIViewController

@property (nonatomic, weak) id<JFWelcomeVCDelegate> delegate;

@end
