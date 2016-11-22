//
//  GSSignTF.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/6/2.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSSignTF.h"

/**
 *  命名规则
 *  前缀 + 按钮名字 + 控件名 + 功能 + 通知
 */
NSString *const GSSignTFUserNameChangeNotification = @"GSSignTFUserNameChangeNotification";

NSString *const GSSignTFPwdChangeNotification = @"GSSignTFPwdChangeNotification";

@interface GSSignTF () <UITextFieldDelegate>

@property (atomic, strong) UITextField *mainTF;

@property (atomic, strong) UIImageView *signV;

@property (atomic, strong) UILabel *segmentLb;

@end

@implementation GSSignTF


- (void)initUI {
    
    _mainTF = [[UITextField alloc] init];
    
    _mainTF.delegate = self;
    
    _signV = [[UIImageView alloc] init];
    
    _segmentLb = [[UILabel alloc] init];
    
    _segmentLb.backgroundColor = gs_Color_Back;
    
    [self addSubview:_mainTF];
    
    [self addSubview:_signV];
    
    [self addSubview:_segmentLb];
    
    
   NSLog(@"%.0f", ([self timechange] - [self getCurrentTime])/ 3600/24);
//   NSLog(@"%ld", ([[self timechange] integerValue] - [[self getCurrentTime] integerValue]) / 3600 / 24) ;
    
}

- (void)setType:(ViewTypeStyle)type {
    
    if (_type != type) {
        
        _type = type;
        
    }
    switch (_type) {
        case pwd:
            
            _mainTF.secureTextEntry = YES;
            
            break;
            
        case userName:
            
             _mainTF.secureTextEntry = NO;
            
            break;
    }
}

- (void)setImageName:(NSString *)imageName {
    
    if (_imageName != imageName) {
        
        _imageName = imageName;
        
    }
    
    [_signV setImage:gs_LoadNormalImage(_imageName)];
    
}

- (void)setPlaceHolderStr:(NSString *)placeHolderStr {
    
    if (_placeHolderStr != placeHolderStr) {
        
        _placeHolderStr = placeHolderStr;
        
    }
    
    _mainTF.placeholder = _placeHolderStr;
    
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//}


- (void)addMasnory {
    
    [_signV mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10);
        
        make.size.mas_equalTo(CGSizeMake(25, 25));
        
        make.centerY.equalTo(self);
        
    }];
    
    [_segmentLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        
        make.size.mas_equalTo(CGSizeMake(1, 22));
        
        make.left.equalTo(_signV.mas_right).offset(10);
        
    }];
    
    [_mainTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self);
        
        make.centerY.equalTo(self);
        
        make.height.equalTo(@32);
        
        make.left.equalTo(_segmentLb.mas_right).offset(10);
        
    }];
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    switch (_type) {
            
        case userName:
            
            [gs_NotiCenter postNotificationName:GSSignTFUserNameChangeNotification object:nil userInfo:@{@"userName" : textField.text}];
            
            break;
            
        case pwd:
            
            [gs_NotiCenter postNotificationName:GSSignTFPwdChangeNotification object:nil userInfo:@{@"pwd" : textField.text}];
            
            break;
            
    }

}

- (void)handleFunction {
    
    
    [gs_NotiCenter addObserverForName:GSLoginViewControllerButtonCommitNotification object:nil queue:gs_MainQueue usingBlock:^(NSNotification * _Nonnull note) {
        
        [_mainTF resignFirstResponder];
        
    }];
    
    [gs_NotiCenter addObserverForName:GSLoginViewControllerButtonCommitNotificationGSSignTFVRemoveNotiCenter object:nil queue:gs_MainQueue usingBlock:^(NSNotification * _Nonnull note) {
        
        [gs_NotiCenter removeObserver:self];
        
    }];
    
}

- (CGFloat)getCurrentTime {
    
    NSDate *datenow = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    
    NSDate *localeDate = [datenow dateByAddingTimeInterval:interval];
    

    return [localeDate timeIntervalSince1970];
    
}


- (CGFloat)timechange {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"yyyy-MM-dd HH:mm:ss"];
    
    NSString *stringTime = @"2016-12-31 00:00:00";
    
    NSDate *dateTime = [formatter dateFromString:stringTime];
    
    
    CGFloat temp = dateTime.timeIntervalSince1970;//打印2011-12-04 19:04:00 +0000，这里+0000表示时区
    
    return temp;
}

- (void)setViewBezierPath {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
