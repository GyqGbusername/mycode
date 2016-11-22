//
//  HITAlertView.m
//  HITAPP
//
//  Created by tangfangyu on 16/3/15.
//  Copyright © 2016年 tangfangyu. All rights reserved.
//

#import "GSAlertView.h"

@interface GSAlertView ()<UIAlertViewDelegate>

@property (nonatomic,copy) GSBlock block;

@end

@implementation GSAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message block:(GSBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:cancelButtonTitle,nil];
    if (self) {
        _block = block;
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    _block(buttonIndex);
}

@end
