//
//  GSSideMenuView.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/25.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSSideMenuView.h"


NSString *const GSSideMenuViewSendPanNotification = @"GSSideMenuViewSendPanNotification";



@interface GSSideMenuView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *menuListTableView;

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

#pragma mark bar

@property (nonatomic, strong) UIImageView *barImageView;

@property (nonatomic, strong) UILabel *nameLb;

@property (nonatomic, strong) UIImageView *signImageView;

@property (nonatomic, strong) UILabel *introLb;

@property (nonatomic, strong) UIButton *userPortrait;

@end

@implementation GSSideMenuView

- (void)initUI {
    
    self.backgroundColor = [UIColor colorWithRed:17 / 255.0 green:184 / 255.0 blue:246 / 255.0 alpha:1.0];
    
    self.userInteractionEnabled = YES;
    
    [self barImageView];
    
    [self userPortrait];
    
    [self nameLb];
    
    [self signImageView];
    
    [self introLb];
    
    [self menuListTableView];
}

- (void)handleFunction {
    
    [self pan];
    
}

- (void)addMasnory {
    [_barImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.equalTo(@(gs_Screen_Width * 0.75));
        make.height.equalTo(@(gs_Screen_Height * 0.3));
    }];
    
    [_userPortrait mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_barImageView).offset(10);
        make.left.equalTo(_barImageView).offset(gs_Screen_Width * 0.1);
        make.size.mas_equalTo(CGSizeMake(gs_Screen_Height * 0.1, gs_Screen_Height * 0.1));
    }];
    
    [_nameLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_userPortrait);
        make.left.equalTo(_userPortrait.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(gs_Screen_Width * 0.4, 20));
    }];
    
    [_signImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLb.mas_bottom).offset(10);
        make.left.equalTo(_userPortrait.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    [_introLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userPortrait.mas_bottom).offset(10);
        make.left.equalTo(_barImageView).offset(gs_Screen_Width * 0.1);
        make.size.mas_equalTo(CGSizeMake(gs_Screen_Width * 0.55, 40));
    }];
    
    [_menuListTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_barImageView.mas_bottom);
        make.left.right.equalTo(_barImageView);
        make.bottom.equalTo(self).offset(-49);
    }];
}

- (void)setViewBezierPath {
    [GSBezierPath bezierPathWith:_barImageView with:(UIRectCornerTopLeft) bycornerRadii:_barImageView.bounds.size];
    [GSBezierPath bezierPathWith:_userPortrait];
}

#pragma  mark 添加手势
- (UIPanGestureRecognizer *)pan {
    if (!_pan) {
        
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanEvent:)];
        
        [self addGestureRecognizer:_pan];
    }
    return _pan;
}


#pragma mark  手势事件
- (void)didPanEvent:(UIPanGestureRecognizer *)recognizer {
   
    [gs_NotiCenter postNotificationName:GSSideMenuViewSendPanNotification object:nil userInfo:@{@"pan": recognizer}];
    
}

#pragma  mark handle UIKit

- (UIImageView *)barImageView {
    if (!_barImageView) {
        
        _barImageView = [[UIImageView alloc] initWithImage:gs_LoadNormalImage(@"sidebar")];
        
        [self addSubview:_barImageView];
    }
    return _barImageView;
}


- (UIButton *)userPortrait {
    if (!_userPortrait) {
        
        _userPortrait = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [_userPortrait setBackgroundImage:gs_LoadNormalImage(@"sina") forState:(UIControlStateNormal)];
        
        [self addSubview:_userPortrait];
    }
    return _userPortrait;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        
        [self addSubview:_nameLb];
        
        _nameLb.textColor = gs_Color_Black;
        
        _nameLb.text = @"耗子是真垃圾";
        
        _nameLb.textAlignment = 1;
        
        _nameLb.font = [UIFont systemFontOfSize:15.0];
        
    }
    return _nameLb;
}

- (UIImageView *)signImageView {
    if (!_signImageView) {
        
        _signImageView = [[UIImageView alloc] initWithImage:gs_LoadNormalImage(@"wechat")];
        
        [self addSubview:_signImageView];
    }
    return _signImageView;
}


- (UILabel *)introLb {
    if (!_introLb) {
        _introLb = [[UILabel alloc] init];
        
        [self addSubview:_introLb];
        
        _introLb.text = @"耗子是真几把辣鸡,耗子是真几把辣鸡,耗子是真几把辣鸡,耗子是真几把辣鸡";
        
        _introLb.textColor = gs_Color_Lightgrey;
        
        _introLb.font = [UIFont systemFontOfSize:12.0];
        
        _introLb.numberOfLines = 2;
    }
    return _introLb;
}

- (UITableView *)menuListTableView {
    if (!_menuListTableView) {
        _menuListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        _menuListTableView.delegate = self;
        
        _menuListTableView.backgroundColor = [UIColor clearColor];
        
        _menuListTableView.dataSource = self;
        
        _menuListTableView.bounces = NO;
        
        _menuListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _menuListTableView.scrollEnabled = NO;
        
        [self addSubview:_menuListTableView];
    }
    return _menuListTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GSBaseTableViewCell *cell = nil;
    
    static NSString *cellName = @"cellName";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell) {
        cell  = [[GSBaseTableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellName];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [@[@"2",@"2",@"2",@"2",@"2"] objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [gs_NotiCenter postNotificationName:@"" object:nil];
    
}


@end
