//
//  GSBaseViewController.h
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/6.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import <UIKit/UIKit.h>


UIKIT_EXTERN NSString *const GSLeftMenuButtonClickSimulationDragNotification;
UIKIT_EXTERN NSString *const GSEachViewDidAppearSendCurrentVCNotification;


@interface GSBaseViewController : UIViewController

@property (nonatomic, strong) NSDictionary *userInfo;

@property (nonatomic, copy) NSString *titleStr;

/**
 *  返回上一页
 */
- (void)backAction;

/**
 *  返回跟视图
 */
- (void)backRootVCAction;

/**
 *  页面布局
 */
- (void)initUI;

/**
 *  数据加载
 */
- (void)dataHandle;
/**
 *  功能
 */
- (void)handleFunction;

/**
 *  缓存
 */
- (void)addCacheWith:(id)content usekey:(NSString *)key;
/**
 *  读取缓存
 *
 *  @param key 名字
 *
 *  @return 内容
 */
- (id<NSCoding>)readCacheWithKey:(NSString *)key;

/**
 *  设置publicItems
 */
- (void)setPublicItemsWithTintColor:(UIColor *)color andImageName:(NSString *)imageName;

/**
 *  设置Customitems
 */
- (void)setCustomItems;


/**
 *  添加约束
 */
- (void)addMasnory;

@end
