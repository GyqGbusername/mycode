//
//  GSSignTF.h
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/6/2.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSBaseView.h"


UIKIT_EXTERN NSString *const GSSignTFUserNameChangeNotification;
UIKIT_EXTERN NSString *const GSSignTFPwdChangeNotification;

typedef NS_ENUM(NSUInteger, ViewTypeStyle) {
    userName,
    pwd,
};


@interface GSSignTF : GSBaseView


@property (nonatomic, assign) ViewTypeStyle type;

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *placeHolderStr;

@end
