//
//  GSLoginViewController.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/6.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSLoginViewController.h"



NSString *const GSLoginViewControllerButtonCommitNotification = @"GSLoginViewControllerButtonCommitNotification";
NSString *const GSLoginViewControllerButtonCommitNotificationGSSignTFVRemoveNotiCenter = @"GSLoginViewControllerButtonCommitNotificationGSSignTFVRemoveNotiCenter";


@interface GSLoginViewController ()

@property (nonatomic, strong) GSSignTF *userNameSTF;

@property (nonatomic, strong) GSSignTF *pwdSTF;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *pwd;

@property (strong, nonatomic) IBOutlet UIButton *sure;

@end

@implementation GSLoginViewController


static GSLoginViewController *sharedGSLoginViewController = nil;

+ (GSLoginViewController *)sharedGSLoginViewController {
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        sharedGSLoginViewController = [[self alloc] init];
        
    });
    
    return sharedGSLoginViewController;
    
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super  viewWillDisappear:animated];
    
    [gs_NotiCenter removeObserver:self];
    
    [gs_NotiCenter postNotificationName:GSLoginViewControllerButtonCommitNotificationGSSignTFVRemoveNotiCenter object:nil];
    
}

- (void)initUI {
    
    self.titleStr = @"登录";
    
    [self userNameSTF];
    
    [self pwdSTF];
    
    _sure.layer.cornerRadius = _sure.frame.size.height / 4;
    
    _sure.layer.masksToBounds = YES;
    
}


- (IBAction)login:(id)sender {
    
    [gs_NotiCenter postNotificationName:GSLoginViewControllerButtonCommitNotification object:nil];
    
    [self dataHandles];
    
}

/**
 * 登录
 */

- (void)dataHandles {
    
    [LCProgressHUD showLoading:gs_Status_Login];
    
    if (![MJYUtils mjy_checkTel:_userName] || ![MJYUtils mjy_checkPassWord:_pwd]) {
        
        [LCProgressHUD showInfoMsg:[NSString stringWithFormat:@"%@或%@",gs_FormatError_Tel, gs_FormatError_Password]];
        
        return;
    }
    
    NSDictionary *paramDict = @{
                                
                                @"mobile":_userName,
                                
                                @"pwd":_pwd
                                
                                };

    [GSHttpManager httpManagerPostParameter:paramDict toHttpUrlStr:gs_completeURL(gs_BaseURL, gs_url_Auth_StoreLoginByPwd) isEGOorNot:YES targetViewController:self andUrlFunctionName:@"login" success:^(id result) {
        
        UserInfo *userInfo = [UserInfo yy_modelWithDictionary:result];
        
        gs_ApplicationDelegate.userInfo = userInfo.Data;
        
        gs_ApplicationDelegate.isLogin = YES;
        
        // 登录成功，记录用户名密码，以备下次自动登录
        gs_ApplicationDelegate.window.rootViewController = [GSBaseTabBarController sharedGSBaseTabBarController];
        
        [gs_NSUserDefaults setObject:_userName forKey:gs_UD_username];
        
        [gs_NSUserDefaults setObject:_pwd forKey:gs_UD_password];
        
        [gs_NSUserDefaults setObject:@"1" forKey:gs_UD_token];
        
        [gs_NSUserDefaults synchronize];
        
        [LCProgressHUD showSuccess:gs_Success_Login];

    } orFail:^(NSError *error) {
        
    }];
    
}

- (GSSignTF *)userNameSTF {
    
    if (!_userNameSTF) {
        
        _userNameSTF = [[GSSignTF alloc] init];
        
        _userNameSTF.imageName = @"qq";
        
        _userNameSTF.placeHolderStr = @"账号";
        
        _userNameSTF.type = userName;
        
        [self.view addSubview:_userNameSTF];
        
        [_userNameSTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.view).offset(84);
            
            make.centerX.equalTo(self.view);
            
            make.size.mas_equalTo(CGSizeMake(gs_Screen_Width * 0.85, 40));
            
        }];
        
        _userNameSTF.layer.cornerRadius = 5;
        
        _userNameSTF.layer.masksToBounds = YES;
        
        _userNameSTF.layer.borderColor = gs_Color_Back.CGColor;
        
        _userNameSTF.layer.borderWidth = 0.7;
        
    }
    
    return _userNameSTF;
    
}


- (GSSignTF *)pwdSTF {
    
    if (!_pwdSTF) {
        
        _pwdSTF = [[GSSignTF alloc] init];
        
        _pwdSTF.imageName = @"sina";
        
        _pwdSTF.placeHolderStr = @"密码";
        
        _pwdSTF.type = pwd;
        
        [self.view addSubview:_pwdSTF];
        
        [_pwdSTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_userNameSTF.mas_bottom).offset(20);
            
            make.centerX.equalTo(self.view);
            
            make.size.mas_equalTo(CGSizeMake(gs_Screen_Width * 0.85, 40));
            
        }];
        
        _pwdSTF.layer.cornerRadius = 5;
        
        _pwdSTF.layer.masksToBounds = YES;
        
        _pwdSTF.layer.borderColor = gs_Color_Back.CGColor;
        
        _pwdSTF.layer.borderWidth = 0.7;
        
    }
    
    return _pwdSTF;
    
}

- (void)handleFunction {
    
    [gs_NotiCenter addObserverForName:GSSignTFPwdChangeNotification object:nil queue:gs_MainQueue usingBlock:^(NSNotification * _Nonnull note) {
        
        _pwd = note.userInfo[@"pwd"];
        
         NSLog(@"%@", _pwd);
        
    }];
    
    [gs_NotiCenter addObserverForName:GSSignTFUserNameChangeNotification object:nil queue:gs_MainQueue usingBlock:^(NSNotification * _Nonnull note) {
        
        _userName = note.userInfo[@"userName"];
        
        NSLog(@"%@", _userName);
        
    }];
    
}

- (void)addMasnory {
    
    [_sure mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_pwdSTF.mas_bottom).offset(20);
        
        make.size.mas_equalTo(CGSizeMake(0.3 * gs_Screen_Width, 40));
        
        make.centerX.equalTo(self.view);
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
