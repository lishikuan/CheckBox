//
//  MeSettingBoundlePhoneViewController.h
//  BobcareCustomApp
//
//  Created by li on 15/8/14.
//  Copyright (c) 2015年 com.01wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeSettingBoundlePhoneViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *accountBaseView;
@property (weak, nonatomic) IBOutlet UIView *veriCodeBaseView;
@property (weak, nonatomic) IBOutlet UIView *pwdBaseView;

@property (weak, nonatomic) IBOutlet UIButton *veriCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *cleartextButton;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *veriCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

- (IBAction)veriCodeButtonPressed:(id)sender;
- (IBAction)cleartextButtonPressed:(id)sender;


@end
