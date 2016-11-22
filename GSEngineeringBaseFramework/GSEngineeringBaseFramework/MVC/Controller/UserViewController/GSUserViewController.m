//
//  GSUserViewController.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/24.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSUserViewController.h"

@interface GSUserViewController ()

@end

@implementation GSUserViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleStr = @"用户";
    }
    return self;
}

- (void)initUI {
    [super initUI];
    [self setPublicItemsWithTintColor:[UIColor orangeColor] andImageName:@"reveal-icon"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
