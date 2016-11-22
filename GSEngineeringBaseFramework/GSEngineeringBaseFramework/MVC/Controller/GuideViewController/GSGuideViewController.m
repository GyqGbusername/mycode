//
//  GSGuideViewController.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/6.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSGuideViewController.h"

@interface GSGuideViewController () {
    NSInteger fnt;
    CGFloat fnt_hight;
    CGFloat fnt_bottom;
}


@property (nonatomic, assign) BOOL animating;
@property (nonatomic, strong) UIScrollView *pageScroll;
@property (nonatomic, strong) NSArray *imageNameArr;
@property (nonatomic, strong) GuidePageView *pageViewControl;
@property (nonatomic, strong) UILabel *tempLabel;


@end

@implementation GSGuideViewController


@synthesize animating = _animating;
@synthesize pageScroll = _pageScroll;


- (void)dealloc {
    [_pageScroll removeObserver:self forKeyPath:@"contentOffset"];
}


#pragma mark - Functions
// 获得屏幕的CGRect
- (CGRect)onscreenFrame
{
    return [UIScreen mainScreen].bounds;
}
// 屏幕旋转
- (CGRect)offscreenFrame
{
    CGRect frame = [self onscreenFrame];
    switch ((int)[UIApplication sharedApplication].statusBarOrientation)
    {
        case UIInterfaceOrientationPortrait:
            frame.origin.y = frame.size.height;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            frame.origin.y = -frame.size.height;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            frame.origin.x = frame.size.width;
            break;
        case UIInterfaceOrientationLandscapeRight:
            frame.origin.x = -frame.size.width;
            break;
    }
    return frame;
}

// 显示引导界面
- (void)showGuide
{
    if (!_animating && self.view.superview == nil)
    {
        [GSGuideViewController sharedGuide].view.frame = [self offscreenFrame];
        [[self mainWindow] addSubview:[GSGuideViewController sharedGuide].view];
        
        _animating = YES;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(guideShown)];
        [GSGuideViewController sharedGuide].view.frame = [self onscreenFrame];
        [UIView commitAnimations];
    }
}

// 开始引导界面动作
- (void)guideShown
{
    _animating = NO;
}

// 隐藏引导界面
- (void)hideGuide
{
    if (!_animating && self.view.superview != nil)
    {
        _animating = YES;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:gs_Time_Animation];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(guideHidden)];
        [GSGuideViewController sharedGuide].view.frame = [self offscreenFrame];
        [UIView commitAnimations];
    }
}
// 隐藏引导界面动作
- (void)guideHidden
{
    _animating = NO;
    [UIView animateWithDuration:gs_Time_Animation animations:^{
        _pageScroll.alpha = 0;
    } completion:^(BOOL finished) {
        [[[GSGuideViewController sharedGuide] view] removeFromSuperview];
        // 登录成功，记录用户名密码，以备下次自动登录
        gs_ApplicationDelegate.window.rootViewController = [GSBaseNavigationController sharedLoginController];
    }];
}
// 返回主窗口
- (UIWindow *)mainWindow
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}
// 外接调用，显示引导界面
+ (void)show
{
    [[GSGuideViewController sharedGuide].pageScroll setContentOffset:CGPointMake(0.f, 0.f)];
    [[GSGuideViewController sharedGuide] showGuide];
}
// 外接调用，隐藏引导界面
+ (void)hide
{
    [[GSGuideViewController sharedGuide] guideHidden];
}

#pragma mark - 单利页面创建

+ (GSGuideViewController *)sharedGuide
{
    @synchronized(self)
    {
        static GSGuideViewController *sharedGuide = nil;
        if (sharedGuide == nil)
        {
            sharedGuide = [[self alloc] init];
        }
        return sharedGuide;
    }
}



- (void)pressCheckButton:(UIButton *)checkButton
{
    [checkButton setSelected:!checkButton.selected];
}

- (void)pressEnterButton:(UIButton *)enterButton
{
    [self guideHidden];
    [self saveNSUserDefaultsWith:@"YES"];
    
}

/* 保存数据到NSUserDefaults */
- (void)saveNSUserDefaultsWith:(NSString *)str {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:str forKey:gs_UD_first];
    
    /* 这里建议同步存储到磁盘中，不写也可以建议写 */
    [userDefaults synchronize];
    
}


- (NSArray *)imageNameArr {
    if (!_imageNameArr) {
        
        if (!IS_IPAD) {
            
            _imageNameArr= @[
                             gs_Iphone_WelcomePage1,
                             gs_Iphone_WelcomePage2,
                             gs_Iphone_WelcomePage3
                             ];
            
            if (IS_IPHONE_5 || IPHONE4) {
                
                fnt = 18;
                fnt_hight = 40.0;
                fnt_bottom = -55.0;
                
            } else {
                
                fnt = 22;
                fnt_bottom = -70.0;
                fnt_hight = 45.0;
                
            }
            
        } else {
            
            _imageNameArr= @[
                             gs_Ipad_WelcomePage1,
                             gs_Ipad_WelcomePage2,
                             gs_Ipad_WelcomePage3
                             ];
            
            fnt_hight = 60.0;
            fnt_bottom = -60.0;
            fnt = 30;
        }
    }
    return _imageNameArr;
}

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (UIScrollView *)pageScroll {
    if (!_pageScroll) {
        _pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     gs_Screen_Width,
                                                                     gs_Screen_Height
                                                                     )];
        self.pageScroll.pagingEnabled = YES;
        _pageScroll.showsVerticalScrollIndicator = NO;
        _pageScroll.showsHorizontalScrollIndicator  = NO;
        self.pageScroll.contentSize = CGSizeMake(gs_Screen_Width * _imageNameArr.count,
                                                 gs_Screen_Height);
        [self.view addSubview:self.pageScroll];
        [self.pageScroll addObserver:self forKeyPath:@"contentOffset" options:1 | 2 context:nil];
    }
    return _pageScroll;
}

- (GuidePageView *)pageViewControl {
    if (!_pageViewControl) {
        self.pageViewControl = [[GuidePageView alloc] initWith:self.imageNameArr.count];
        [self.view addSubview:self.pageViewControl];
        [_pageViewControl mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(gs_Screen_Width / 3, 20));
            make.centerX.equalTo(_pageScroll);
            make.bottom.equalTo(_pageScroll).offset(- 30);
        }];
    }
    return  _pageViewControl;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    CGPoint point = [[change objectForKey:@"new"] CGPointValue];
    for (UILabel *label in self.pageViewControl.subviews) {
        label.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.3];
    }
    if (point.x < gs_Screen_Width * 0.5) {
        self.tempLabel = [self.pageViewControl.subviews objectAtIndex:0];
        self.tempLabel.backgroundColor = [UIColor whiteColor];
    }
    if (point.x >= gs_Screen_Width * 0.5 && point.x < gs_Screen_Width * 1.5) {
        self.tempLabel = [self.pageViewControl.subviews objectAtIndex:1];
        self.tempLabel.backgroundColor = [UIColor whiteColor];
    }
    if (point.x >= gs_Screen_Width * 1.5 && point.x < gs_Screen_Width * 2.5) {
        self.tempLabel = [self.pageViewControl.subviews objectAtIndex:2];
        self.tempLabel.backgroundColor = [UIColor whiteColor];
    }
}


/* 跳转按钮 */
- (void)setJumpButton {
    UIButton *endButton = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImageView *img= [self.pageScroll.subviews objectAtIndex:2];
    
    [self.pageScroll addSubview:endButton];
    [endButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img);
        make.bottom.equalTo(img).offset(fnt_bottom);
        make.size.mas_equalTo(CGSizeMake(gs_Screen_Width / 3, fnt_hight));
    }];
    endButton.backgroundColor = [UIColor clearColor];
    endButton.layer.borderColor = [UIColor whiteColor].CGColor;
    endButton.timeInterval = 0.5;
    endButton.layer.borderWidth = 2;
    endButton.layer.cornerRadius = 8;
    endButton.layer.masksToBounds = YES;
    [endButton setTitle:@"立即体验" forState:(UIControlStateNormal)];
    [endButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    endButton.titleLabel.font = [UIFont systemFontOfSize:gs_FontInfo.titleFontNum];
    [endButton addTarget:self action:@selector(pressEnterButton:) forControlEvents:(UIControlEventTouchUpInside)];
}




- (void)initUI {
    
    [super initUI];
    [self imageNameArr];
    [self pageScroll];
    [self pageViewControl];
    [self setImage];
    [self setJumpButton];
//    UIWebView *wv = [[UIWebView alloc] initWithFrame:gs_Screen_Frame];
//    [self.view addSubview:wv];
//    [wv loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.0.178/lll/mob"]]];
}

- (void)setImage {
    NSString *imgName = nil;
    UIView *view;
    for (int i = 0; i < _imageNameArr.count; i++)
    {
        imgName = [_imageNameArr objectAtIndex:i];
        view = [[UIView alloc] initWithFrame:CGRectMake((gs_Screen_Width * i),
                                                        0.f,
                                                        gs_Screen_Width,
                                                        gs_Screen_Height)];
        
        UIImage *image = [UIImage imageNamed:imgName];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                               0,
                                                                               gs_Screen_Width,
                                                                               gs_Screen_Height
                                                                               )];
        imageview.contentMode = UIViewContentModeScaleToFill;
        imageview.image = image;
        [view addSubview:imageview];
        [self.pageScroll addSubview:view];
        
        }
}

- (void)dataHandle {
    
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
