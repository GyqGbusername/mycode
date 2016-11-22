//
//  GSTHPLoginCollectionView.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/6/2.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSTHPLoginCollectionView.h"

@interface GSTHPLoginCollectionView ()  <GSCollectionViewDelegateWaterfallLayout, UICollectionViewDataSource>

@end

@implementation GSTHPLoginCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setDelegate:self];
        
        [self setDataSource:self];
        
    }
    
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
