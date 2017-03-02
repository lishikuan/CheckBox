//
//  JFUtils.h
//  BobcareCustomApp
//
//  Created by Japho on 15/12/1.
//  Copyright © 2015年 com.gm.partynews. All rights reserved.
//

/*
 
  　　　┏┓　　　┏┓
  　　┏┛┻━━━┛┻┓
  　　┃　　　　　　　┃
  　　┃　　　━　　　┃
  　　┃　┳┛　┗┳　┃
  　　┃　　　　　　　┃
  　　┃　　　┻　　　┃
  　　┃　　　　　　　┃
  　　┗━┓　　　┏━┛
  　　　　┃　　　┃    神兽保佑,代码无bug
  　　　　┃　　　┃
  　　　　┃　　　┗━━━┓
  　　　　┃　　　　　　　┣┓
  　　　　┃　　　　　　　┏┛
  　　　　┗┓┓┏━┳┓┏┛
  　　　　　┃┫┫　┃┫┫
  　　　　　┗┻┛　┗┻┛
 
*/

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DateType_Today,
    DateType_Yesterday,
    DateType_MoreEarly,
} DateType;

@interface JFUtils : NSObject

/**
 *  验证是否为手机号
 *
 *  @param mobileNum 手机号
 *
 *  @return 是否为手机号
 */
+ (BOOL)validateMobileNumber:(NSString *)mobileNum;
/**
 *
 * @return 密码是否合法
 */
+ (BOOL)validatePasswordNumber:(NSString *)password;

/**
 *  判断字符串是否为空
 *
 *  @param string 所需判断字符串
 *
 *  @return 返回是否为空
 */
+ (BOOL)isBlankString:(NSString *)string;

/**
 *  验证字符串是否含有特殊字符
 *
 *  @param string 字符串
 *
 *  @return 返回结果
 */
+ (BOOL)valifateSpecialCharacter:(NSString *)string;

/**
 *  数组转换成字符串
 *
 *  @param array 数组
 *
 *  @return 返回字符串
 */
+ (NSString *)arrayConvertToString:(NSArray *)array;

/**
 *  字符串转换成数组
 *
 *  @param string 字符串
 *
 *  @return 数组
 */
+ (NSArray *)stringConvertToArray:(NSString *)string;

/**
 *  开启网络监控
 */
+ (void)webReachAbility;

/**
 *  转换XML Data 为 Json 字典
 *
 *  @param responseObject XML Data
 *
 *  @return Json 字典
 */
+ (NSDictionary *)getJsonDictionaryWithXMLData:(id)responseObject;

/**
 *  转换XML Parse 为 XML 对象
 *
 *  @param responseObject XML Parse
 *
 *  @return Json 字典
 */
+ (NSMutableDictionary *)getJsonDictionaryWithXMLParse:(id)responseObject;

/**
 *  根据颜色生成图片
 *
 *  @param color 颜色
 *  @param size  尺寸
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  根据target中action的值，跳转到指定的页面(inex控制tabVC下不同的navigationController)
 *
 *  @param target target 字典
 *
 *  @return 跳转成功
 */
+ (BOOL)doActionForTarget:(NSDictionary *)target;

/**
 *  返回日期字符串的时间类型
 *
 *  @param dateString 日期字符串
 *
 *  @return 时间类型（今天，昨天，更早）
 */
+ (DateType)dateTypeOfDateString:(NSString *)dateString;

/**
 *  返回布尔类型
 *
 *  @param string 字符串
 *
 *  @return 布尔类型
 */
+ (BOOL)isPureFloat:(NSString*)string;

/**
 *  返回布尔类型
 *
 *  @param string 字符串
 *
 *  @return 布尔类型
 */
+ (BOOL)isPureNumandCharacters:(NSString *)string;

/**
 *  返回布尔类型
 *
 *  @param string 字符串
 *
 *  @return 布尔类型
 */
+ (BOOL)verifyIdentityStringValid:(NSString *)identityString;

/**
 *  返回布尔类型
 *
 *  @param string 字符串
 *
 *  @return 布尔类型
 */
+ (BOOL)isValidateEmail:(NSString *)email;
@end
