//
//  GSHttpManager.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/24.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSHttpManager.h"


@interface GSHttpManager ()



@end


@implementation GSHttpManager

/**
 *  判断网络状况
 */
+ (void)httpManagerGSNetworkReachabilityManage {
   
    [gs_ReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        gs_ApplicationDelegate.reachabilityStatus = status;
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: {
                NSLog(@"无网络");
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WiFi网络");
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                NSLog(@"无线网络");
                break;
            }
                
            default:
                NSLog(@"不明网络");
                break;
        }
        
    }];

}

/**
 *  POST
 *
 *  @param param          入参
 *  @param urlStr         请求地址
 *  @param isEGO          是否缓存
 *  @param viewController 当前的vc
 *  @param success        成功返回值
 *  @param fail           失败返回值
 */

+ (void)httpManagerPostParameter:(NSDictionary *)param toHttpUrlStr:(NSString *)urlStr isEGOorNot:(BOOL)isEGO  targetViewController:(GSBaseViewController *)viewController andUrlFunctionName:(NSString *)urlName success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail {
    
    switch (gs_ApplicationDelegate.reachabilityStatus) {
        case 0: {
            NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:(NSData *)[viewController readCacheWithKey:gs_completeURL(gs_GetClass_Name(viewController), urlName)]];
            
            success(jsonDic);
        }
            break;
            
        default: {
            [gs_ApplicationDelegate.httpManager POST:urlStr parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (task.state == NSURLSessionTaskStateCompleted) {
                    
                    NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
                    
                    NSString *status = [NSString stringWithFormat:@"%@",jsonDic[@"Success"]];
                    
                    if ([status isEqualToString:@"1"]) {
                        
                        if (isEGO) {
                            [viewController addCacheWith:responseObject usekey:gs_completeURL(gs_GetClass_Name(viewController), urlName)];
                        }
                        success(jsonDic);
                        
                    } else {
                        
                        [LCProgressHUD showFailure:jsonDic[@"Message"]];
                        
                        NSError *error = [[NSError alloc] initWithDomain:jsonDic[@"Message"] code:0 userInfo:nil];
                        
                        fail(error);
                        
                    }
                    
                } else {
                    
                    [LCProgressHUD showFailure:gs_Error_Network];
                    
                    NSError *error = [[NSError alloc] initWithDomain:gs_Error_Network code:0 userInfo:nil];
                    
                    fail(error);
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //请求异常
                [LCProgressHUD showFailure:gs_Error_Network];
                
                fail(error);
                
            }];

        }
            break;
    }
}

/**
 *  GET
 *
 *  @param param          入参
 *  @param urlStr         请求地址
 *  @param isEGO          是否缓存
 *  @param viewController 当前的vc
 *  @param success        成功返回值
 *  @param fail           失败返回值
 */

+ (void)httpManagerGetParameter:(NSDictionary *)param toHttpUrlStr:(NSString *)urlStr isEGOorNot:(BOOL)isEGO  targetViewController:(GSBaseViewController *)viewController andUrlFunctionName:(NSString *)urlName success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail {
    
    switch (gs_ApplicationDelegate.reachabilityStatus) {
        case 0: {
            NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:(NSData *)[viewController readCacheWithKey:gs_completeURL(gs_GetClass_Name(viewController), urlName)]];
            
            success(jsonDic);
        }
            break;
            
        default: {
            [gs_ApplicationDelegate.httpManager GET:urlStr parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (task.state == NSURLSessionTaskStateCompleted) {
                    
                    NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
                    
                    NSString *status = [NSString stringWithFormat:@"%@",jsonDic[@"Success"]];
                    
                    if ([status isEqualToString:@"1"]) {
                        
                        if (isEGO) {
                            [viewController addCacheWith:responseObject usekey:gs_completeURL(gs_GetClass_Name(viewController), urlName)];
                        }
                        success(jsonDic);
                        
                    } else {
                        
                        [LCProgressHUD showFailure:jsonDic[@"Message"]];
                        
                        NSError *error = [[NSError alloc] initWithDomain:jsonDic[@"Message"] code:0 userInfo:nil];
                        
                        fail(error);
                        
                    }
                    
                } else {
                    
                    [LCProgressHUD showFailure:gs_Error_Network];
                    
                    NSError *error = [[NSError alloc] initWithDomain:gs_Error_Network code:0 userInfo:nil];
                    
                    fail(error);
                    
                }

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //请求异常
                [LCProgressHUD showFailure:gs_Error_Network];
                
                fail(error);

            }];
            
        }
            break;
    }
}


@end


@implementation GSHttpUpManager

/**
 *  照片上传
 *
 *  @param urlStr         地址
 *  @param param          入参
 *  @param images         照片数组
 *  @param imageName      照片明
 *  @param viewController 所在VC
 */

+ (void)httpManagerUploadImageWithURLString:(NSString *)urlStr paramert:(NSDictionary *)param images:(NSArray<UIImage *> *)images withImageName:(NSString*)imageName targetViewController:(GSBaseViewController *)viewController success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail {
    
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:viewController.view];
    
    [viewController.view addSubview:HUD];
    
    HUD.labelText = @"正在上传...";
    
    [HUD show:YES];
    
    switch (images.count) {
            
        case 0:
            
            [LCProgressHUD showInfoMsg:@"请添加照片"];
            
            break;
            
        default: {
            
            for(int i = 0; i < [images count]; i++)
            {
                //上传图片的限制 之前是2*1024*1024，改成了1*1024*1024 就可以上传。就是大于1M就对图片进行了压缩。
                NSData *dataImage;
                
                UIImage *currentImage = [images objectAtIndex:i];
                
                dataImage = UIImageJPEGRepresentation(currentImage, 1.0);
                
                NSString *fileName = [NSString stringWithFormat:@"currentImage%d.jpg",i];
                
                [gs_ApplicationDelegate.httpManager POST:urlStr parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    
                    [formData appendPartWithFileData:dataImage name:imageName fileName:fileName mimeType:@"image/jpeg"];
                    
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                    
#pragma mark 上传进度
                    HUD.progress = (double)((double)uploadProgress.completedUnitCount / (double)uploadProgress.totalUnitCount) * 100.0;
                    
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
#pragma mark 上传结果
                    [HUD hide:YES];
                    
                    NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
                    
                    NSString *status = [NSString stringWithFormat:@"%@",jsonDic[@"Success"]];
                    
                    if ([status isEqualToString:@"1"]) {
                        
                        [LCProgressHUD showSuccess:@"上传成功"];
                        
                    } else {
                        
                        [LCProgressHUD showSuccess:@"不明错误"];
                        
                    }
                    
                    success(responseObject);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    [HUD hide:YES];
                    
                    [LCProgressHUD showFailure:gs_Error_Network];
                    
                    fail(error);
                }];
                
            }
            
        }
            break;
    }
}


@end



@implementation GSHttpDownManager

/**
 *  下载文件
 *
 *  @param urlStr         链接地址
 *  @param param          入参
 *  @param fileName       文件名
 *  @param viewController 所在VC
 */


+ (void)httpManagerDownloadFileWithURLString:(NSString *)urlStr paramert:(NSDictionary *)param withFileName:(NSString *)fileName targetViewController:(GSBaseViewController *)viewController downloadComplection:(GGURLManagerSendRequestCallBack)complection {
    
    NSURLRequest *request = gs_LoadRequest(urlStr);
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:viewController.view];
    
    [viewController.view addSubview:HUD];
    
    HUD.labelText = @"正在下载...";
    
    [HUD show:YES];
    
    switch (gs_ApplicationDelegate.reachabilityStatus) {
        case 1: {
            
            GSAlertView *alert = [[GSAlertView alloc] initWithTitle:@"警告" message:@"您正在使用手机流量下载是否继续" block:^(NSInteger selectedIndex) {
                
                switch (selectedIndex) {
                    case 0:
                        
                        [HUD hide:YES];
                        
                        [LCProgressHUD showInfoMsg:@"任务已取消"];
                        
                        break;
                        
                    case 1: {
                        
                        NSURLSessionDownloadTask *downTask = [gs_ApplicationDelegate.httpManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
                            
#pragma mark 上传进度
                            HUD.progress = (double)((double)downloadProgress.completedUnitCount / (double)downloadProgress.totalUnitCount) * 100.0;
                            
                        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                            
                            return targetPath;
                            
                        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                            
                            [HUD hide:YES];
                            
                            [LCProgressHUD showSuccess:@"下载完成"];
                            
                            complection(response, filePath, error);
                            
                        }];
                        
                        /** 开启下载任务. */
                        [downTask resume];
                        
                    }
                        
                        break;
                        
                }
                
            } cancelButtonTitle:@"取消" otherButtonTitles:@"OK"];
            
            [alert show];
        }
            
            break;
            
        default: {
            
            NSURLSessionDownloadTask *downTask = [gs_ApplicationDelegate.httpManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
                
#pragma mark 上传进度
                HUD.progress = (double)((double)downloadProgress.completedUnitCount / (double)downloadProgress.totalUnitCount) * 100.0;
                
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                
                return targetPath;
                
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                
                [HUD hide:YES];
                
                [LCProgressHUD showSuccess:@"上传成功"];
                
            }];
            
            /** 开启下载任务. */
            [downTask resume];
            
        }
            break;
    }
    
}






@end

