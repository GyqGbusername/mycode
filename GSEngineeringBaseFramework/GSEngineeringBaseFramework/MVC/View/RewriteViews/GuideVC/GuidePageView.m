//
//  GuidePageView.m
//  MFSC
//
//  Created by mfwl on 16/2/15.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "GuidePageView.h"

@interface GuidePageView ()

@property (nonatomic, assign) NSInteger tempPage;

@end

@implementation GuidePageView



- (instancetype)initWith:(NSInteger)page {
    self = [super init];
    if (self) {
        _tempPage = page;
        for (NSInteger i = 0; i < page; i++) {
            UILabel *lb = [[UILabel alloc] init];
            [self addSubview:lb];
            if (0 != i) {
                lb.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.3];
            } else {
                lb.backgroundColor = [UIColor whiteColor];
            }
        }
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    for (NSInteger i = 0; i < _tempPage; i++) {
        UILabel *lb = self.subviews[i];
        [lb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(gs_View_Width / _tempPage - 5, gs_View_Height / 2));
            make.left.equalTo(self).offset(2.5 + gs_View_Width / _tempPage * i);
        }];
    }
}

@end
