//
//  GSLoginViewController.h
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/6.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSBaseViewController.h"

UIKIT_EXTERN NSString *const GSLoginViewControllerButtonCommitNotification;
UIKIT_EXTERN NSString *const GSLoginViewControllerButtonCommitNotificationGSSignTFVRemoveNotiCenter;

@interface GSLoginViewController : GSBaseViewController


+ (GSLoginViewController *)sharedGSLoginViewController;


@end
