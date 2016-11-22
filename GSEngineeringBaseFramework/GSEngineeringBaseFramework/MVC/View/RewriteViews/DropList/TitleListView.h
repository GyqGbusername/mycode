//
//  TitleListView.h
//  MFSC
//
//  Created by mfwl on 16/4/6.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TitleListViewDelegate <NSObject>

- (void)postNum:(NSInteger)row;

@end

@interface TitleListView : UIView

@property (nonatomic, assign) id<TitleListViewDelegate> delegate;

@end
