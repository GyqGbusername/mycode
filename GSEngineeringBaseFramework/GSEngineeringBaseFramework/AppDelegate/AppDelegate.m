//
//  AppDelegate.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/5.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "AppDelegate.h"
#import "GSBaseTabBarController.h"
#import "GSBaseNavigationController.h"
#import "GSLoginViewController.h"
#import "JPUSHService.h"
#import<CoreLocation/CoreLocation.h>
#import "GSGuideViewController.h"
#import "GSSideMenuView.h"




@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    [self addSideMenuView];
    
    /**
     *  判断是否第一次登录
     */
    if ([[MJYUtils mjy_fuckNULL:[gs_NSUserDefaults stringForKey:gs_UD_first]] isEqualToString:@"YES"]) {
        
        self.window.rootViewController = [GSBaseNavigationController sharedLoginController];
        
        [self userInfomation];
        
    } else {
        
        self.window.rootViewController = gs_GuideViewController;
        
    }
    
    /**
     * 初始化 网络请求工具
     */
    [self initProperty];
    
    
    /**
     *  开启定位
     */
    CLLocationManager* location = [CLLocationManager new];
    [location requestAlwaysAuthorization];
    
    /**
     *  JPUSH
     */
    [JPUSHService setupWithOption:nil appKey:gs_JPHSHKey channel:gs_Channel apsForProduction:NO];
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    
   
//    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    return YES;
}

#pragma  mark 添加sideViewMenu实现抽屉
- (void)addSideMenuView {
    
    GSSideMenuView *sideView = [[GSSideMenuView alloc] init];
    
    [self.window addSubview:sideView];

    [sideView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.window).offset(-0.25 * gs_Screen_Width);
        
        make.size.mas_equalTo(CGSizeMake(gs_Screen_Width, gs_Screen_Height));
        
        make.top.equalTo(self.window);
        
    }];
    
}


/**
 *  初始化应用程序的属性
 */
- (void) initProperty
{
    self.httpManager = [AFHTTPSessionManager manager];
    self.httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    /**
     * 由于检测网络有一定的延迟, 所以在启动APP的时候如果不设置网络的延迟, 直接调用[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus有可能得到的是status 返回的值是 AFNetworkReachabilityStatusUnknown;
     这个时候虽然有网, 但是也会因为网络的延迟, 直接做出错误的判断.
     一般建议设置延时调用 */
    
    /** 给大家简单举个例子(surveyNetworkConcatenate:是自己写的方法) */
    
    /** 0.35秒后再执行surveyNetworkConcatenate:方法. */
    [gs_ReachabilityManager startMonitoring];

    [GSHttpManager httpManagerGSNetworkReachabilityManage];

}


/**
 *  判断是否登录
 */

- (void)userInfomation {
    if ([[MJYUtils mjy_fuckNULL:[gs_NSUserDefaults stringForKey:gs_UD_token]] isEqualToString:@"0"]) {
        [self dataHandles];
    } else {
        
    }
}

/**
 * 登录
 */

- (void)dataHandles {
    [LCProgressHUD showLoading:gs_Status_Login];
    NSDictionary *paramDict = @{
                                @"mobile":[MJYUtils mjy_fuckNULL:[gs_NSUserDefaults stringForKey:gs_UD_username]],
                                @"pwd":[MJYUtils mjy_fuckNULL:[gs_NSUserDefaults stringForKey:gs_UD_password]]
                                };
    [GSHttpManager httpManagerPostParameter:paramDict toHttpUrlStr:gs_completeURL(gs_BaseURL, gs_url_Auth_StoreLoginByPwd) isEGOorNot:YES targetViewController:gs_LonginViewController andUrlFunctionName:@"login" success:^(id result) {
        
        UserInfo *userInfo = [UserInfo yy_modelWithDictionary:result];
        
        gs_ApplicationDelegate.userInfo = userInfo.Data;
        
        gs_ApplicationDelegate.isLogin = YES;
        // 登录成功，记录用户名密码，以备下次自动登录
        gs_ApplicationDelegate.window.rootViewController = [GSBaseTabBarController sharedGSBaseTabBarController];
        
        [LCProgressHUD showSuccess:gs_Success_Login];
        
    } orFail:^(NSError *error) {
        
    }];

//    [GSHttpDownManager httpManagerDownloadFileWithURLString:gs_completeURL(gs_BaseURL, gs_url_Auth_StoreLoginByPwd) paramert:paramDict withFileName:@"123" targetViewController:gs_LonginViewController downloadComplection:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        
//    }];
//
//    [GSHttpUpManager httpManagerUploadImageWithURLString:gs_completeURL(gs_BaseURL, gs_url_Auth_StoreLoginByPwd) paramert:paramDict images:@[@"sina"] withImageName:@"sina" targetViewController:gs_LonginViewController success:^(id result) {
//        
//    } orFail:^(NSError *error) {
//        
//    }];
}






- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

/**
 *  请求唯一标识符
 *
 *  @param application app
 *  @param deviceToken deviceToken only
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required -    DeviceToken
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);

    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}




#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler {
}


- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif


- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
