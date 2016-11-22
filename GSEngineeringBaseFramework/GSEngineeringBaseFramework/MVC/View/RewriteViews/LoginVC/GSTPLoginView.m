//
//  GSTPLoginView.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/6/2.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSTPLoginView.h"


@interface GSTPLoginView () <TencentSessionDelegate> {
    TencentOAuth *tencentOAuth;
    NSArray *permissions;
}

@property (nonatomic, copy) NSString *accesstoken;

@property (nonatomic, strong) NSDate *expirationTime;




@end

@implementation GSTPLoginView





- (void)wbSinaLogin:(UIButton *)log {
    
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        
        NSLog(@"%ld，%@ ", state, user);
        
    }];
}

- (void)weChatLogin:(UIButton *)log {
    
    
}

- (void)tencentLogin:(UIButton *)log {
    
    tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1105386024" andDelegate:self];
    //设置需要的权限列表，此处尽量使用什么取什么。
    permissions = [NSArray arrayWithObjects:
                   kOPEN_PERMISSION_GET_USER_INFO,
                   kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                   kOPEN_PERMISSION_ADD_ALBUM,
                   kOPEN_PERMISSION_ADD_ONE_BLOG,
                   kOPEN_PERMISSION_ADD_SHARE,
                   kOPEN_PERMISSION_ADD_TOPIC,
                   kOPEN_PERMISSION_CHECK_PAGE_FANS,
                   kOPEN_PERMISSION_GET_INFO,
                   kOPEN_PERMISSION_GET_OTHER_INFO,
                   kOPEN_PERMISSION_LIST_ALBUM,
                   kOPEN_PERMISSION_UPLOAD_PIC,
                   kOPEN_PERMISSION_GET_VIP_INFO,
                   kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                   nil];
    
    [tencentOAuth authorize:permissions inSafari:NO];

}

- (void)tencentDidLogin
{
    
    [LCProgressHUD showSuccess:gs_Success_Login];
    
    if (tencentOAuth.accessToken && 0 != [tencentOAuth.accessToken length])
    {
        
        [LCProgressHUD showSuccess:tencentOAuth.accessToken];
        
        //  记录登录用户的OpenID、Token以及过期时间
        _accesstoken = tencentOAuth.accessToken;
        
        _expirationTime = tencentOAuth.expirationDate;
        
        [gs_NSUserDefaults setObject:_accesstoken forKey:gs_UD_QQToken];
        
        [gs_NSUserDefaults setObject:[NSString stringWithFormat:@"%@", _expirationTime] forKey:gs_UD_ExpirationDate];
        
        [gs_NSUserDefaults synchronize];
       
    } else {
        
        [LCProgressHUD showFailure:@"登录不成功没有获取accesstoken"];
        
    }
}

//非网络错误导致登录失败：
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
    NSLog(@"tencentDidNotLogin");
    
    if (cancelled)
        
    {
        
        [LCProgressHUD showInfoMsg:@"用户取消登录"];
        
    } else {
        
         [LCProgressHUD showFailure:@"登录失败"];
        
    }
    
}
// 网络错误导致登录失败：
-(void)tencentDidNotNetWork
{
    
    NSLog(@"tencentDidNotNetWork");
    
    [LCProgressHUD showInfoMsg:@"无网络连接，请设置网络"];
    
}



//以上方法基本上就实现了登陆，下来我们得考虑登陆成功之后如何获取用户信息
//其实方法很简单我们在登陆成功的方法里面调用



//然后系统会调用一个方法（我们需要提前实现）
-(void)getUserInfoResponse:(APIResponse *)response
{
    NSLog(@"respons:%@",response.jsonResponse);
}

//在getUserInfoResponse中就可以看到所需要的用用户信息





@end
