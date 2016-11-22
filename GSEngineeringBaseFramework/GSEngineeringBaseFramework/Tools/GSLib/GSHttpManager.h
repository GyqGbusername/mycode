//
//  GSHttpManager.h
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/24.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^GGURLManagerSendRequestCallBack) (NSURLResponse* response, NSURL *filePaht, NSError* connectionError);



@interface GSHttpManager : NSObject


/**
 *  判断网络
 */
+ (void)httpManagerGSNetworkReachabilityManage;


/**
 *  POST
 */
+ (void)httpManagerPostParameter:(NSDictionary *)param toHttpUrlStr:(NSString *)urlStr isEGOorNot:(BOOL)isEGO  targetViewController:(GSBaseViewController *)viewController andUrlFunctionName:(NSString *)urlName success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail;

/**
 *  GET
 */
+ (void)httpManagerGetParameter:(NSDictionary *)param toHttpUrlStr:(NSString *)urlStr isEGOorNot:(BOOL)isEGO  targetViewController:(GSBaseViewController *)viewController andUrlFunctionName:(NSString *)urlName success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail;

@end

@interface GSHttpUpManager : NSObject

/**
 *  照片上传
 *
 *  @param urlStr         地址
 *  @param param          入参
 *  @param images         照片数组
 *  @param imageName      照片明
 *  @param viewController 所在VC
 *  @param success    成功block
 *  @param fail     失败block
 */

+ (void)httpManagerUploadImageWithURLString:(NSString *)urlStr paramert:(NSDictionary *)param images:(NSArray<UIImage *> *)images withImageName:(NSString*)imageName targetViewController:(GSBaseViewController *)viewController success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail;


@end



@interface GSHttpDownManager : NSObject

/**
 *  下载文件
 *
 *  @param urlStr         链接地址
 *  @param param          入参
 *  @param fileName       文件名
 *  @param viewController 所在VC
 *  @param complection    返回下载状态的block
 */

+ (void)httpManagerDownloadFileWithURLString:(NSString *)urlStr paramert:(NSDictionary *)param withFileName:(NSString*)fileName targetViewController:(GSBaseViewController *)viewController  downloadComplection:(GGURLManagerSendRequestCallBack)complection;

@end

