//
//  GSBaseView.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/6.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSBaseView.h"

@implementation GSBaseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
        [self handleFunction];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addMasnory];
    [self setViewBezierPath];
}


- (void)initUI {
    
}

/**
 *  功能
 */
- (void)handleFunction {
    
}

- (void)addMasnory {
    
}

- (void)setViewBezierPath {
    
}


- (void)reload {
    
    if (self) {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
         [self removeFromSuperview];
    }
}


@end
