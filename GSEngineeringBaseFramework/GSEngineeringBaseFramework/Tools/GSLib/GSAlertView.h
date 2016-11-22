//
//  HITAlertView.h
//  HITAPP
//
//  Created by tangfangyu on 16/3/15.
//  Copyright © 2016年 tangfangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GSBlock)(NSInteger selectedIndex);

@interface GSAlertView : UIAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message block:(GSBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;

@end
