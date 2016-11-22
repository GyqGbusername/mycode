//
//  GSBaseViewController.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/6.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSBaseViewController.h"

/**
 *  命名规则
 *  前缀 + 按钮名字 + 控件名 + 功能 + 通知
 */
NSString *const GSLeftMenuButtonClickSimulationDragNotification = @"GSLeftMenuButtonClickSimulationDragNotification";
NSString *const GSEachViewDidAppearSendCurrentVCNotification = @"GSEachViewDidAppearSendCurrentVCNotification";

@interface GSBaseViewController ()


@end


@implementation GSBaseViewController


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [gs_NotiCenter postNotificationName:GSEachViewDidAppearSendCurrentVCNotification object:nil userInfo:@{@"currentVC":gs_GetClass_Name(self)}];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self dataHandle];
    
    [self initUI];
    
    [self addMasnory];
    
    [self handleFunction];

    [self setCustomItems];
    
}




#pragma mark - 公共方法
/**
 *  返回上一页
 */
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  返回跟视图
 */
- (void)backRootVCAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 *  添加缓存
 *
 *  @param content 内容
 *  @param key     名字
 */

- (void)addCacheWith:(id)content usekey:(NSString *)key {
   
    [EGOCache_GlobalCache setObject:content forKey:key];
}

/**
 *  读取缓存
 *
 *  @param key 名字
 *
 *  @return 内容
 */

- (id<NSCoding>)readCacheWithKey:(NSString *)key {
    return [EGOCache_GlobalCache objectForKey:key];
}

/**
 *  页面布局
 */

- (void)initUI {
    
    self.view.backgroundColor = gs_Color_Back;
    
    
    
}

/**
 *  标题
 */

- (void)setTitleStr:(NSString *)titleStr {
    if (_titleStr != titleStr) {
        _titleStr = titleStr;
    }
    self.navigationItem.title = _titleStr;
}

/**
 *  数据加载
 */

- (void)dataHandle {
    
}


/**
 *  功能
 */
- (void)handleFunction {
    
}

/**
 *  设置Publicitems
 */

- (void)setPublicItemsWithTintColor:(UIColor *)color andImageName:(NSString *)imageName {
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:gs_LoadNormalImage(imageName) style:UIBarButtonItemStylePlain target:self action:@selector(revealToggle:)];
    
    revealButtonItem.tintColor = color;
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
}


- (void)revealToggle:(UIBarButtonItem *)ite {
    
    [gs_NotiCenter postNotificationName:GSLeftMenuButtonClickSimulationDragNotification object:nil];
    
}

/**
 *  自定义items
 */
- (void)setCustomItems {
    
}

- (void)addMasnory {
    
}

@end
