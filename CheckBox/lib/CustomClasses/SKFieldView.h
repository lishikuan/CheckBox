//
//  SKFieldView.h
//  CheckBox
//
//  Created by lsm on 16/12/29.
//  Copyright © 2016年 lsm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKFieldView : UIView
@property (nonatomic, strong)UIImageView * imageView;
@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)UITextField * textField;
@property (nonatomic, strong)UILabel * lineLabel;

- (void)setImage:(UIImage *)image;
- (void)setTitle:(NSString *)title;
- (void)setPlaceHolder:(NSString *)placeHolder;
- (void)setTitleLabelLength:(int)length;
@end
