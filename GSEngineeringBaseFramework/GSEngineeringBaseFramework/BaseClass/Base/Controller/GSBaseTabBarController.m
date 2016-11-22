//
//  GSBaseTabBarController.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/6.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSBaseTabBarController.h"
#import "GSBaseNavigationController.h"
#import "GSGuideViewController.h"
#import "GSHomeViewController.h"
#import "GSUserViewController.h"
#import "GSCircleViewController.h"



@interface GSBaseTabBarController () <UITabBarControllerDelegate>

@property (strong, nonatomic) UIPanGestureRecognizer *pan;
@property (strong, nonatomic) UITapGestureRecognizer *tap;
@property (nonatomic, assign) BOOL isAppear;

@end

@implementation GSBaseTabBarController


- (void)dealloc {
    [gs_NotiCenter removeObserver:self];
}



static GSBaseTabBarController *sharedGSBaseTabBarController = nil;

+ (GSBaseTabBarController *)sharedGSBaseTabBarController
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedGSBaseTabBarController = [[self alloc] init];
    });
    return sharedGSBaseTabBarController;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    
    [self initUI];
    
    [self handleFunction];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
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


#pragma mark - Data & UI & Function  

/**
 *  数据
 */

- (void)initData
{
    self.delegate = self;
    self.isAppear = NO;
}

/**
 *  UI
 */

- (void)initUI {
    
    self.tabBar.tintColor = [UIColor orangeColor];
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    [self setRootVCs];
    
    [self setTabBarItemStyle];
}

/**
 *  功能
 */
- (void)handleFunction {
    
    [self addRecognizer];
    
    [self addNoti];
    
}

#pragma mark 添加手势

- (void)addRecognizer {
    
    _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPanEvent:)];
    
    [self.view addGestureRecognizer:_pan];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapEvent:)];
    
    _tap.enabled = NO;
    
    [self.view addGestureRecognizer:_tap];
    
}

#pragma mark 添加通知

- (void)addNoti {
    
    [gs_NotiCenter addObserverForName:GSLeftMenuButtonClickSimulationDragNotification object:nil queue:gs_MainQueue usingBlock:^(NSNotification * _Nonnull note) {
        
        [self simulationDrag];
        
    }];
    
    [gs_NotiCenter addObserverForName:GSEachViewDidAppearSendCurrentVCNotification object:nil queue:gs_MainQueue usingBlock:^(NSNotification * _Nonnull note) {
        
        if ([self isFirstVCWith:note.userInfo[@"currentVC"]]) {
            _pan.enabled = YES;
        } else {
            _pan.enabled = NO;
        }
        
    }];
    
    [gs_NotiCenter addObserverForName:GSSideMenuViewSendPanNotification object:nil queue:gs_MainQueue usingBlock:^(NSNotification * _Nonnull note) {
        [self didPanEvent:note.userInfo[@"pan"]];
    }];
}

- (BOOL)isFirstVCWith:(NSString *)currentVCStr {
    if ([currentVCStr isEqualToString:@"GSHomeViewController"] || [currentVCStr isEqualToString:@"GSUserViewController"] || [currentVCStr isEqualToString:@"GSCircleViewController"])
        return YES;
    else  return NO;
}


#pragma mark 模拟拖拽
- (void)simulationDrag {
    
    //获取最右边范围
    CGAffineTransform  rightScopeTransform = CGAffineTransformTranslate([gs_ApplicationDelegate window].transform,gs_Screen_Width * 0.75, 0);
    
    if (0 == _isAppear) {
        
        [UIView animateWithDuration:gs_Time_Animation animations:^{
            
            _pan.view.transform = rightScopeTransform;
            
            [[gs_ApplicationDelegate window].subviews objectAtIndex:0].ttx = _pan.view.ttx / 3;
            
            _tap.enabled = YES;
            
        }];
    } else {
        
        [UIView animateWithDuration:gs_Time_Animation animations:^{
            
            _pan.view.transform = CGAffineTransformIdentity;
            
            [[gs_ApplicationDelegate window].subviews objectAtIndex:0].ttx = _pan.view.ttx / 3;
            
            _tap.enabled = NO;
            
        }];
    }
    
    _isAppear = !_isAppear;
    
}






/**
 *  设置基本rootVC
 */
- (void)setRootVCs
{
    
    GSHomeViewController *homeViewController = [[GSHomeViewController alloc] init];
    GSBaseNavigationController *homeNavi = [[GSBaseNavigationController alloc] initWithRootViewController:homeViewController];
    
    GSCircleViewController *circleController = [[GSCircleViewController alloc] init];
    GSBaseNavigationController *circleNavi = [[GSBaseNavigationController alloc] initWithRootViewController:circleController];
    
    GSUserViewController *userVimeController = [[GSUserViewController alloc] init];
    GSBaseNavigationController *userNavi = [[GSBaseNavigationController alloc] initWithRootViewController:userVimeController];
    
    self.viewControllers = @[
                             homeNavi,
                             circleNavi,
                             userNavi
                             ];
}



#pragma mark  拖拽实现
- (void)didPanEvent:(UIPanGestureRecognizer *)recognizer{
    
    // 1. 获取手指拖拽的时候, 平移的值
    CGPoint translation = [recognizer translationInView:recognizer.view];
    NSLog(@"%f",translation.x);
    
    // 2. 让当前控件做响应的平移
    _pan.view.transform = CGAffineTransformTranslate(_pan.view.transform, translation.x, 0);
    // ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
    
    [[gs_ApplicationDelegate window].subviews objectAtIndex:0].ttx = _pan.view.ttx / 3;
    
    //    NSLog(@"%f",translation.x/5);
    // ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
    // 3. 每次平移手势识别完毕后, 让平移的值不要累加
    [recognizer setTranslation:CGPointZero inView:_pan.view];
    
    //    NSLog(@"%f",recognizer.view.transform.tx);
    //    NSLog(@"%f",translation.x);
    //    NSLog(@"====================");
    //
    
    //获取最右边范围
    CGAffineTransform  rightScopeTransform = CGAffineTransformTranslate([gs_ApplicationDelegate window].transform, gs_Screen_Width * 0.75, 0);
    
    //    当移动到右边极限时
    if (_pan.view.transform.tx > rightScopeTransform.tx) {
        
        //        限制最右边的范围
        _pan.view.transform = rightScopeTransform;
        //        限制透明view最右边的范围
        [[gs_ApplicationDelegate window].subviews objectAtIndex:0].ttx = _pan.view.ttx / 3;
        
        //        当移动到左边极限时
    } else if (_pan.view.transform.tx < 0.0){
        
        //        限制最左边的范围
        _pan.view.transform=CGAffineTransformTranslate([gs_ApplicationDelegate window].transform, 0, 0);
        //    限制透明view最左边的范围
        [[gs_ApplicationDelegate window].subviews objectAtIndex:0].ttx = _pan.view.ttx / 3;
        
    }
    //    当托拽手势结束时执行
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        
        [UIView animateWithDuration:gs_Time_Animation animations:^{
            
            if (_pan.view.x > gs_Screen_Width * 0.5) {
                
                _pan.view.transform = rightScopeTransform;
                
                [[gs_ApplicationDelegate window].subviews objectAtIndex:0].ttx = _pan.view.ttx / 3;
                
                if (!_isAppear) {
                    _isAppear = YES;
                }
                
                if (!_tap.enabled) {
                     _tap.enabled = YES;
                }
               
                
            } else {
                
                _pan.view.transform = CGAffineTransformIdentity;
                
                [[gs_ApplicationDelegate window].subviews objectAtIndex:0].ttx = _pan.view.ttx / 3;
                
                if (_isAppear) {
                    _isAppear = NO;
                }
                
                if (_tap.enabled) {
                    _tap.enabled = NO;
                }
                
            }
        }];
        
    }
}

- (void)didTapEvent:(UITapGestureRecognizer *)tap {
    
    [self simulationDrag];
    
}





/**
 *  设置item的样式
 */
- (void)setTabBarItemStyle
{
    UITabBarItem *item1 = self.tabBar.items[0];
    item1.tag = 0;
    item1.title = gs_TabName_1;
    item1.image = gs_LoadNormalImage(gs_TabImage_1);
    
    
    UITabBarItem *item2 = self.tabBar.items[1];
    item2.tag = 1;
    item2.title = gs_TabName_2;
    item2.image = gs_LoadNormalImage(gs_TabImage_2);
    
    UITabBarItem *item3 = self.tabBar.items[2];
    item3.tag = 2;
    item3.title = gs_TabName_3;
    item3.image = gs_LoadNormalImage(gs_TabImage_3);
    
//    UITabBarItem *item3 = self.tabBar.items[2];
//    item3.tag = 2;
//    item3.title = gs_TabName_3;
//    item3.image = [UIImage imageNamed:@"tab_shop_car"];
//    
//    UITabBarItem *item4 = self.tabBar.items[3];
//    item4.tag = 3;
//    item4.title = gs_TabName_4;
//    item4.image = [UIImage imageNamed:@"tab_my"];
    
}


#pragma mark - Delegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if(tabBarController.selectedIndex == 0) {
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)viewController;
            [nav popViewControllerAnimated:NO];
        }
        
    }
}




@end
