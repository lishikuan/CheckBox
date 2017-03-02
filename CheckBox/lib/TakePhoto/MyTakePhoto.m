//
//  MyTakePhoto.m
//  CheckBox
//
//  Created by lsm on 17/1/11.
//  Copyright © 2017年 lsm. All rights reserved.
//

#import "MyTakePhoto.h"
#import "JFProgressHUD.h"
#import "MBProgressHUD.h"
#import "TakePhotoResponse.h"
#import "SingletonFun.h"
@interface MyTakePhoto ()<UIActionSheetDelegate,UIPickerViewDelegate,TakePhotoDelegate>{
    //拍照
    UIActionSheet *myActionSheet;//下拉菜单
    int sectionViewHeight;
    NSString * urlString;
    MBProgressHUD * _HUD;
}
@property (nonatomic, strong) UIView * view;
@property (nonatomic, strong) UIViewController * viewController;

@end
@implementation MyTakePhoto
- (void)setInView:(UIView *)view viewController:(UIViewController *)VC
{
    self.view = view;
    self.viewController = VC;

}
- (void)takePhotoToURL:(NSString *)url
{
    urlString = url;
    [self openMenu];
}
#pragma - mark take photo delegate
- (void)getTakePhotoResponse:(id)response
{
    if ([_delegate respondsToSelector:@selector(getTakePhotoResponse:)]) {
        [_delegate getTakePhotoResponse:response];
    }
}
#pragma  - mark take photo
-(void)openMenu
{
    //在这里呼出下方菜单按钮项
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == myActionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
            
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
}

//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        [self.viewController presentViewController:picker animated:YES completion:^{
            //
        }];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self.viewController presentViewController:picker animated:YES completion:^{
        //
    }];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //        //先把图片转成NSData
        //        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //        NSData *data;
        //        if (UIImagePNGRepresentation(image) == nil)
        //        {
        //            data = UIImageJPEGRepresentation(image, 1.0);
        //        }
        //        else
        //        {
        //            data = UIImagePNGRepresentation(image);
        //        }
        //初始化imageNew为从相机中获得的--
        UIImage *imageNew = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //设置image的尺寸
        CGSize imagesize = imageNew.size;
        CGFloat imageWidth = imagesize.width;
        CGFloat imageHeight = imagesize.height;
        imagesize = CGSizeMake(500, 500/(imageWidth/imageHeight));
        //对图片大小进行压缩--
        imageNew = [self imageWithImage:imageNew scaledToSize:imagesize];
        NSData *data = UIImageJPEGRepresentation(imageNew,1);
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        NSString * filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            //            //发送照片
            //            [self sendInfo];
            NSString * picType = @"7" ;
            //开始上传图片
            [self picUploadMethod:picType Path:filePath];//(1B超2试纸3刮宫4输卵管检测5宫腔腹镜6其他7会员8医生9验血10资格证)
            
        }];
        //创建一个选择后图片的小图标放在下方
        //        //类似微薄选择图后的效果
        //        UIImageView *smallimage = [[UIImageView alloc] initWithFrame:
        //                                    CGRectMake(50, 120, 40, 40)];
        //
        //        smallimage.image = image;
        //        //加在视图中
        //        [self.view addSubview:smallimage];
        
    }
    
}
//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

-(void)sendInfo
{
    //
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma 上传图片
- (NSData *)readFile:(NSString *)fileName Path:(NSString *)filePath order:(NSInteger)block{
    
    NSFileHandle *inFile;
    inFile=[NSFileHandle fileHandleForReadingAtPath:filePath];
    
    
    NSData *buffer=[inFile readDataToEndOfFile];
    
    [inFile closeFile];
    return buffer;
}
//上传头像图片
- (void)picUploadMethod:(NSString *)picType Path:(NSString *)filePath
{
    NSLog(@"%@",filePath);
        _HUD = [JFProgressHUD showWaitingHUDInView:self.view text:nil];
    
        //上传头像
        NSString *picUrl=filePath;
        NSString *fileName=nil;
        if (picUrl) {
            NSArray *picStrs=[picUrl componentsSeparatedByString:@"/"];
            fileName=[NSString stringWithFormat:@"%@",picStrs.lastObject];
    
        }else
        {
            NSString *uuidString=[[NSUserDefaults standardUserDefaults]valueForKey:@"uuidString"];
            fileName=[NSString stringWithFormat:@"%@.png",uuidString];
        }
//        NSString * memId=[NSString stringWithFormat:@"%@",[SingletonFun shareInstance].loginResponse.memberEntity.physiologyEntity.memId];
//        NSString *strUrl =[NSString stringWithFormat:@"%@?token=%@&memId=%@&picType=%@&fileName=%@&fileIndex=%@&fileFlag=%@&memFlag=%@",uploadDdPicURL,[SingletonFun shareInstance].loginResponse.memberEntity.token,memId,picType,fileName,@"1",@"1",@"0"];//picType(1B超2试纸3刮宫4输卵管检测5宫腔腹镜6其他7会员8医生9验血10资格证)
        NSData *imageData = [self readFile:@"" Path:filePath order:1];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"binary/octet-stream"];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/plain", nil];
        [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:imageData
                                        name:@"file"
                                    fileName:@"image.png" mimeType:@"binary/octet-stream"];
    
            // etc.
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
            NSDictionary *dict = (NSDictionary *)responseObject;
            if (dict != nil)
            {
                NSLog(@"dict %@",dict);
                [SingletonFun shareInstance].takePhotoResponse = responseObject;
                [self getTakePhotoResponse:responseObject];
                
            }
            [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView * alert=[ [UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误，请检查网络设置" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil ];
            NSLog(@"error%@",error);
            [alert show];
            [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
        }];
}
//- (BOOL)deletePic:(NSString*)picId
//{
//    _HUD = [JFProgressHUD showWaitingHUDInView:self.view text:nil];
//
//    //删除图片
//    static BOOL flag = NO;//作为返回值
//    NSString *strURL =deletePicByPathURL;
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    NSString * memId = [SingletonFun shareInstance].loginResponse.memberEntity.id;
//    NSString * token = [SingletonFun shareInstance].loginResponse.memberEntity.token;
//    NSString * memOs = [SingletonFun shareInstance].loginResponse.memberEntity.memOs;
//    [dict setObject:memId forKey:@"memId"];
//    [dict setObject:token forKey:@"token"];
//    [dict setObject:memOs forKey:@"memOs"];
//    [dict setObject:picId forKey:@"id"];//图片id
//    [dict setObject:@"0" forKey:@"memFlag"];
//    NSLog(@"%@",dict);
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
//    [manager setResponseSerializer:responseSer];
//    [manager POST:strURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSMutableDictionary *responseCustomEntity = [JFUtils getJsonDictionaryWithXMLParse:responseObject];
//        QueryResponse *queryResponse = nil;
//        queryResponse = [[QueryResponse alloc] initWithDictionary:responseCustomEntity];
//        if(queryResponse!=nil && queryResponse.code==200){
//            UIAlertView * alert=[ [UIAlertView alloc] initWithTitle:@"提示" message:queryResponse.info delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil ];
//            [alert show];
//            flag = YES;
//        }
//        else{
//            UIAlertView * alert=[ [UIAlertView alloc] initWithTitle:@"提示" message:queryResponse.info delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil ];
//            [alert show];
//            flag = NO;
//        }
//        [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//        UIAlertView * alert=[ [UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误，请检查网络设置" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil ];
//        [alert show];
//        NSLog(@"%@",error);
//        flag = NO;
//        [JFProgressHUD hideWithHUD:_HUD afterDelay:0];
//    }];
//    return flag;
//}

@end
