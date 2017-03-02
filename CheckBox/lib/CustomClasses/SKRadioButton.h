//
//  SKRadioButton.h
//  BobcareDoctorApp
//
//  Created by mac on 16/1/7.
//  Copyright © 2016年 com.01wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SKRadioButtonDelegate <NSObject>

-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString*)groupId;
@end
@interface SKRadioButton : UIView{
    NSString *_groupId;
    NSUInteger _index;
    UIButton *_button;
}
//GroupId
@property(nonatomic,retain)NSString *groupId;
//Group的索引
@property(nonatomic,assign)NSUInteger index;

//初始化RadioButton控件
-(id)initWithGroupId:(NSString*)groupId index:(NSUInteger)index;
//为
+(void)addObserverForGroupId:(NSString*)groupId observer:(id)observer;
// 可以设置默认选中项
- (void) setChecked:(BOOL)isChecked;
@end
