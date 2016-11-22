//
//  GSHomeViewController.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/18.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSHomeViewController.h"
#import "GSCeshiViewController.h"

@interface GSHomeViewController ()

@property (strong, nonatomic) IBOutlet UILabel *nameLb;
@property (strong, nonatomic) IBOutlet UILabel *otherLb;

@end

@implementation GSHomeViewController


- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.titleStr = @"首页";
        
    }
    
    return self;
}


- (void)dataHandle {
    [super dataHandle];
    
}

- (void)setLb {
    _nameLb.layer.borderColor = [UIColor colorWithRed:0.9933 green:0.6918 blue:0.7514 alpha:1.0].CGColor;
    _nameLb.layer.borderWidth = 1.0f;
    _nameLb.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(tap:)];
    [_nameLb addGestureRecognizer:tap];
    _otherLb.layer.borderColor =  [UIColor colorWithRed:0.9933 green:0.6918 blue:0.7514 alpha:1.0].CGColor;
    _otherLb.layer.borderWidth = 1.0f;
    _otherLb.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_otherLb addGestureRecognizer:tap1];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    if ([tap.view isEqual:_nameLb]) {
        GSCeshiViewController *ceshi = [[GSCeshiViewController alloc] init];
        [self.navigationController pushViewController:ceshi animated:YES];
    } else {
        
    }
}

- (void)initUI {
    [super initUI];
    [self setLb];
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
