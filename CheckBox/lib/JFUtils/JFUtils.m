//
//  JFUtils.m
//  BobcareCustomApp
//
//  Created by Japho on 15/12/1.
//  Copyright © 2015年 com.gm.partynews. All rights reserved.
//

#import "JFUtils.h"
#import "SingletonFun.h"
#import "AppDelegate.h"
//#import "SKHomeViewController.h"
//#import "SKHomeSingleton.h"
#import <objc/runtime.h>
@implementation JFUtils

+ (BOOL)validateMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0-9]|7[03678]|4[57])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

+ (BOOL)validatePasswordNumber:(NSString *)password
{
    /**
     *
     *密码是否合法
     */
    NSString * PW = @"^[0-9|A-Z|a-z]{6,12}$";
    NSPredicate *regextestPW = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PW];
    if ([regextestPW evaluateWithObject:password]) {
        return YES;
    }else{
        return NO;
    }
}
//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil)
    {
        return YES;
    }
    if (string == NULL)
    {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] && [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0)
    {
        return YES;
    }
    
    return NO;
}

+ (NSString *)arrayConvertToString:(NSArray *)array
{
    //把数组转换为字符串
    NSError *error;
    NSData *textData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *textString = [[NSString alloc] initWithData:textData encoding:NSUTF8StringEncoding];
    
    return textString;
}

+ (NSArray *)stringConvertToArray:(NSString *)string
{
    //字符串转化成数组
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return array;
}

//开启网络监控
+ (void)webReachAbility
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        
        [SingletonFun shareInstance].webStatus = status;
        [SingletonFun shareInstance].hasSetWebStatus = YES;
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络(断网)");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI");
                break;
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];
}

//验证字符串是否含有特殊字符
+ (BOOL)valifateSpecialCharacter:(NSString *)string
{
    if (string.length == 0)
    {
        return YES;
    }
    
    NSString *regex = @"^[A-Za-z0-9 ,.\"，。《》！“”（）、\u4E00-\u9FA5_-]+$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isTrue = [regextestmobile evaluateWithObject:string];
    
    return isTrue;
}

+ (NSDictionary *)getJsonDictionaryWithXMLData:(id)responseObject
{
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSError *parseError = nil;
    NSDictionary *xmlDict = [NSDictionary dictionaryWithXMLString:string];
    
    NSData *jsonData;
    if (xmlDict)
    {
        jsonData = [NSJSONSerialization dataWithJSONObject:xmlDict options:NSJSONWritingPrettyPrinted error:&parseError];
    }
    
    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *dataDic = [strJson objectFromJSONString];
    
    NSLog(@"REQUEST STRING %@",strJson);
    
    if ([[dataDic allKeys] containsObject:@"code"])
    {
        if ([dataDic[@"code"] hasPrefix:@"4"])
        {
//            if ([SKHomeSingleton sharedInstanceMethod].isExpired != 1) {
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录已过期，请重新登录。" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//                [alertView show];
//                [SKHomeSingleton sharedInstanceMethod].isExpired = 1;
//            }
            //跳转登录界面
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToLogin" object:self];
        }
    }
    
    return dataDic;
}

+ (NSMutableDictionary *)getJsonDictionaryWithXMLParse:(id)responseObject
{
    NSXMLParser * parser = (NSXMLParser*)responseObject;
    NSError *parseError = nil;
    
    NSDictionary *xmlDict = [NSDictionary dictionaryWithXMLParser:parser];
    
    NSData* jsonData;
    
    if (xmlDict)
    {
        jsonData = [NSJSONSerialization dataWithJSONObject:xmlDict options:NSJSONWritingPrettyPrinted error:&parseError];
    }
    
    NSString* strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *dataDic = [strJson objectFromJSONString];
    NSLog(@"REQUEST STRING %@",strJson);
    
    if ([[dataDic allKeys] containsObject:@"code"])
    {
        if ([dataDic[@"code"] hasPrefix:@"4"])
        {
//            if ([SKHomeSingleton sharedInstanceMethod].isExpired != 1) {
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录已过期，请重新登录。" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//                [alertView show];
//                [SKHomeSingleton sharedInstanceMethod].isExpired = 1;
//            }

            
            //跳转登录界面
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToLogin" object:self];
        }
    }
    
    return dataDic;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
+ (BOOL)doActionForTarget:(NSDictionary *)target
{
    //根据你的app结构，来取得你当前的controller，由它来进行跳转
    UIApplication *application = [UIApplication sharedApplication];
    AppDelegate *myAppDelegate = (AppDelegate *)[application delegate];
    UITabBarController *viewController;
    if (myAppDelegate.window.rootViewController) {
        viewController = (UITabBarController *)myAppDelegate.window.rootViewController;
    }else {
        return NO;
    }
//    if([target[@"action"] isEqualToString:@"home"]){
////        UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
////        SKHomeViewController *homeVC = [board instantiateViewControllerWithIdentifier:@"SKHomeViewController"];
////        homeVC.hidesBottomBarWhenPushed = YES;
////        SKHomeViewController *homeVC = [[SKHomeViewController alloc]init];
////        UINavigationController *navigationController = (UINavigationController *)viewController.viewControllers[4];
////        [navigationController pushViewController:homeVC animated:YES];
//        const char * className = [@"SKHomeViewController" UTF8String];
//        Class kclass = NSClassFromString([NSString stringWithFormat:@"%s",className]);
//        UIViewController * cIndex = [kclass new];
//        UINavigationController *navigationController = (UINavigationController *)viewController.viewControllers[4];
//        [navigationController pushViewController:cIndex animated:YES];
//
//        return YES;
//    }
    const char * className;
    if ([[target allKeys] containsObject:@"class"]) {
        className = [[target objectForKey:@"class"] UTF8String];
    }else{
        return NO;
    }
    
    NSDictionary *valueDic;
    if ([[target allKeys] containsObject:@"values"]) {
        valueDic = [target objectForKey:@"values"];
    }else{
        return NO;
    }
    Class kclass = NSClassFromString([NSString stringWithFormat:@"%s",className]);
    
    NSObject *person = [kclass new];
    
    unsigned int numIvars; //成员变量个数
    
    Ivar *vars = class_copyIvarList(kclass, &numIvars);
    
    NSString *ivarName = nil;
    NSString *ivarType = nil;
    
    for (int i = 0; i < numIvars; i++)
    {
        Ivar thisIvar = vars[i];
        
        ivarName = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
        ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)]; //获取成员变量的数据类型
        
        for (NSString *tempStr in [valueDic allKeys])
        {
            if ([[ivarName substringFromIndex:1] isEqualToString:tempStr])
            {
                if ([ivarType isEqualToString:@"c"] && [[valueDic objectForKey:tempStr] isKindOfClass:[NSString class]])
                {
                    NSString *valueStr = [valueDic objectForKey:tempStr];
                    int boolValue = [valueStr intValue];
                    [person setValue:[NSNumber numberWithInt:boolValue] forKeyPath:tempStr];
                }
                else
                {
                    id propertyValue = [valueDic objectForKey:tempStr];
                    [person setValue:propertyValue forKeyPath:tempStr];
                }
            }
        }
        
    }
    
    free(vars);
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController * tabVC = (UITabBarController *)appDelegate.window.rootViewController;
    NSInteger indexNew = tabVC.selectedIndex;
    UINavigationController *navigationController = (UINavigationController *)viewController.viewControllers[indexNew];
    [navigationController pushViewController:(UIViewController *)person animated:YES];

    return YES;
}

+ (DateType)dateTypeOfDateString:(NSString *)dateString
{
    //输入时间字符串，仅日期
    NSString *dateStr = [dateString substringToIndex:10];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //输入时间date类型
    NSDate *inputDate = [dateFormatter dateFromString:dateStr];
    //当前时间date类型
    NSDate *currentDate = [NSDate date];
    //转换当前时间，舍去时分秒
    NSString *currentDateStr = [dateFormatter stringFromDate:currentDate];
    currentDate = [dateFormatter dateFromString:currentDateStr];
    //计算出两个date对象的时间间隔
    NSTimeInterval time = [currentDate timeIntervalSinceDate:inputDate];

    //每天的秒数
    float daySeconds = 60 * 60 * 24;
    //总时间间隔除以每天的秒数得出距离多少天
    float daysBeforeToday = time / daySeconds;
    
    if (daysBeforeToday == 0)
    {
        return DateType_Today;
    }
    else if (daysBeforeToday == 1)
    {
        return DateType_Yesterday;
    }
    else
    {
        return DateType_MoreEarly;
    }
}

//判断是否为浮点形：

+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
//判断是否是纯数字
+ (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}
//判断身份证是否合法
+ (BOOL)verifyIdentityStringValid:(NSString *)identityString {
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

//利用正则表达式验证
+ (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
@end
