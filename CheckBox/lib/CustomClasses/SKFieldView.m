//
//  SKFieldView.m
//  CheckBox
//
//  Created by lsm on 16/12/29.
//  Copyright © 2016年 lsm. All rights reserved.
//

#import "SKFieldView.h"
@interface SKFieldView ()<UITextFieldDelegate>{
    
}
@end
@implementation SKFieldView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.textField];
        [self addSubview:self.lineLabel];
    }
    
    return self;
}
#pragma - mark custom methods
- (void)setImage:(UIImage *)image
{
    [self.imageView setImage:image];
}
- (void)setTitle:(NSString *)title
{
    [self.titleLabel setText:[NSString stringWithFormat:@"%@：",title]];
}
- (void)setPlaceHolder:(NSString *)placeHolder
{
    [self.textField setPlaceholder:placeHolder];
}
- (void)setTitleLabelLength:(int)length
{
    [self.titleLabel setFrame:CGRectMake((34+16)/2, 0, length, self.frame.size.height)];
    [self.textField setFrame:CGRectMake((34+16)/2+length, 0, self.frame.size.width-(34+16)/2-length-18, self.frame.size.height-1)];
    [self.lineLabel setFrame:CGRectMake((34+16)/2+length, self.frame.size.height-1, self.frame.size.width-(34+16)/2-length-18, 1)];
}
#pragma mark textFieldDelegate

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.titleLabel.text isEqualToString:@"身份证号"]) {
        if ([JFUtils isBlankString:string]) {
            return NO;
        }
        if ([JFUtils verifyIdentityStringValid:textField.text]) {
            return YES;
        }
    }
    if ([self.titleLabel.text isEqualToString:@"QQ账号"]) {
        if ([JFUtils isBlankString:string]) {
            return NO;
        }
        if ([JFUtils isPureNumandCharacters:textField.text]) {
            return YES;
        }
    }
    if ([self.titleLabel.text isEqualToString:@"芝麻分"]) {
        if ([JFUtils isBlankString:string]) {
            return NO;
        }
        if ([JFUtils isValidateEmail:textField.text]) {
            return YES;
        }
    }
    return YES;
}
#pragma - mark Setters && Getters
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        [_imageView setFrame:CGRectMake(34/2, (self.frame.size.height-8)/2, 8/2, 8/2)];
    }
    return _imageView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFrame:CGRectMake((34+16)/2, 0, 160/2, self.frame.size.height)];
        [_titleLabel setTextColor:[UIColor hexStringToColor:@"333333"]];
        [_titleLabel setTextAlignment:NSTextAlignmentRight];
        [_titleLabel setFont:maxTextFont];
        _titleLabel.numberOfLines = 0;
        [_titleLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _titleLabel;
}
- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        [_textField setFrame:CGRectMake((34+16+160)/2, 0, self.frame.size.width-(34+16+160)/2-18, self.frame.size.height-1)];
        _textField.tag = 1001;
        _textField.delegate = self;
        
    }
    return _textField;
}
- (UILabel *)lineLabel
{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        [_lineLabel setFrame:CGRectMake((34+16+160)/2, self.frame.size.height-1, self.frame.size.width-(34+16+160)/2-18, 1)];
        [_lineLabel setBackgroundColor:[UIColor hexStringToColor:@"f4f4f4"]];
    }
    return _lineLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
