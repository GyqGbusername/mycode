//
//  GSBaseNavigationController.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/6.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSBaseNavigationController.h"
#import "GSLoginViewController.h"

@interface GSBaseNavigationController () <UINavigationControllerDelegate, UINavigationBarDelegate>

@end

@implementation GSBaseNavigationController


static GSBaseNavigationController *sharedLoginController = nil;

+ (GSBaseNavigationController *)sharedLoginController
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedLoginController = [[self alloc] initWithRootViewController:[GSLoginViewController sharedGSLoginViewController]];
    });
    return sharedLoginController;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self initUI];
    
    [self handleFunction];
    
}

/**
 *  页面
 */

- (void)initData
{
    self.delegate = self;
}

/**
 *  页面
 */
- (void)initUI {
    
}

/**
 *  功能
 */
- (void)handleFunction {
    
}

- (void)viewWillAppear:(BOOL)animated {
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
