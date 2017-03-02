/**
 *  ******************** Api接口文件 ********************
 */

#ifndef CheckBox_constant_h
#define CheckBox_constant_h

/**
 *  ******************** ENVIRONMENT 1 为测试环境 ENVIRONMENT 2 正式数据测试环境 ENVIRONMENT 3 为正式环境 ********************
 */

#define ENVIRONMENT   1   //测试环境



/**
 *  ******************** 测试环境 ********************
 */
#if ENVIRONMENT == 1

#define SERVER_IP @"074c.cn"        //测试环境3

#define SERVER_PORT @"8080"   //测试
#define PROJECT @"darkHorse"
#define MAIN_URL [NSString stringWithFormat:@"http://%@:%@/%@",SERVER_IP,SERVER_PORT,PROJECT]                    //正式数据测试


/**
 *  ******************** 正式数据测试环境 ********************
 */
#elif ENVIRONMENT == 2

#define SERVER_IP @"115.28.27.12"         //正式数据测试环境

#define SERVER_PORT @"9080"   //正式数据测试

#define PROJECT @"darkHorse"
#define MAIN_URL [NSString stringWithFormat:@"https://%@:%@/%@",SERVER_IP,SERVER_PORT,PROJECT]                    //正式数据测试


/**
 *  ******************** 正式环境 ********************
 */
#elif ENVIRONMENT == 3

#define MAIN_URL @"https://074c.cn:8080/darkHorse"


#endif

//#define GET_URL_WITH_API(api) [NSString stringWithFormat:@"%@%@",MAIN_URL,api]

//1、登录URL
#define kLoginURL                [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/userLogin"]

//2、查询启动图片
#define kGetWelcomePic          [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/member/querySysData.do?dataType=PIC_TYPE"]

//3、注册URL
#define kRegisterURL          [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/user"]

//4、忘记密码URL
#define kForgetPasswordURL          [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/user/passwordReset"]

//5、注册获取验证码URL
#define kRegisterSMSURL          [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/sms"]

//6、忘记密码获取验证码URL
#define kForgetPasswordSMSURL          [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/sms"]

//7、上传基本资料URL
#define kUploadUserInfoURL          [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/user"]

//8、上传头像URL
#define kUploadHeadImageURL          [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/imageRes"]

//9、上传身份证正面URL
#define kUploadFaceIDImageURL          [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/imageRes"]

//10、上传身份证反面URL
#define kUploadBackIDImageURL          [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/imageRes"]

//11、上传半身像URL
#define kUploadSecondFaceIDImageURL          [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/imageRes"]

//12、获取个人信息URL
#define kGetUserInfoURL          [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/user"]

//13、修改个人信息URL
#define kUpdateUserInfoURL          [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/user"]

//14、修改密码URL
#define kResepPasswordURL          [NSString stringWithFormat:@"%@%@",MAIN_URL,@"/user/passwordReset"]
#endif
