//
//  BaseViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/21.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseViewController.h"
#import "ABAConfig.h"

@interface BaseViewController ()
{
    MBProgressHUD * _tipsView;
    MBProgressHUD * _loadingView;
    NSInteger _activityIndeacterNumbers;
}
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

@end

@implementation BaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _activityIndeacterNumbers = 0 ;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupController];
}

#pragma mark - Common method

- (void)setupController
{
    [self leftButton];
}


- (void)setNaviLeftItemNormalImage:(id)normalImage HighlightedIamge:(id)highLightedImage
{
    
    if ([normalImage isKindOfClass:[UIImage class]] && [highLightedImage isKindOfClass:[UIImage class]]) {
        [self.leftButton setImage:normalImage forState:UIControlStateNormal];
        [self.leftButton setImage:highLightedImage forState:UIControlStateHighlighted];
        [self.leftButton sizeToFit];
    }
    if ([normalImage isKindOfClass:[NSString class]] && [highLightedImage isKindOfClass:[NSString class]]) {
        [self.leftButton sd_setImageWithURL:[NSURL URLWithString:normalImage] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"headerImage"]];
        [self.leftButton setFrame:CGRectMake(0, 0, 37, 37)];
        self.leftButton.layer.cornerRadius = 37.0/2;
        self.leftButton.layer.masksToBounds = YES;
    }
}


- (void)setNaviRightItemNormalImage:(UIImage *)normalImage HighlightedIamge:(UIImage *)highLightedImage
{
    if (normalImage && highLightedImage) {
        [self.rightButton setImage:normalImage forState:UIControlStateNormal];
        [self.rightButton setImage:highLightedImage forState:UIControlStateHighlighted];
        [self.rightButton sizeToFit];
    }
}

- (void)showTipsMsg:(NSString *)msg {
    [self showTipsMsg:msg withDelay:1.5f];
}
-(void)showTipsMsg:(NSString *)msg withDelay:(NSTimeInterval)delay {
    if (msg && msg.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _tipsView=[MBProgressHUD showHUDAddedTo:kAppDelegate.window animated:YES];
            _tipsView.mode =MBProgressHUDModeText;
            _tipsView.detailsLabel.font = [UIFont systemFontOfSize:14];
            _tipsView.detailsLabel.text = msg;
            _tipsView.removeFromSuperViewOnHide = YES;
            [_tipsView hideAnimated:YES afterDelay:delay];
        });
    }
    
}

-(void)showLoadingView:(BOOL)isShow {
    if (isShow) {
        if (_activityIndeacterNumbers++) {
            return;
        }
    }else{
        
        if (--_activityIndeacterNumbers>0) {
            
            return;
        }
        
        _activityIndeacterNumbers = MAX(0, _activityIndeacterNumbers);
        
    }
    if (isShow) {
        _loadingView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        _loadingView.bezelView.color = [UIColor blackColor];
//        _loadingView.bezelView.alpha = 1;
//        [_loadingView setActivityIndicatorColor:[UIColor whiteColor]];
        
    }else{
        [_loadingView hideAnimated:YES];
    }
}

- (void)showTipsMessageDelayPopBackWithMessage:(NSString *)message
{
    [self showTipsMsg:message withDelay:1.0];
    dispatch_time_t second = 1.0;
    
    typeof(self) weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf popBack];
    });
}

- (void)showTipsMsg:(NSString *)msg delayPsuhViewController:(UIViewController *)viewController
{
    [self showTipsMsg:msg withDelay:1.0];
    dispatch_time_t second = 1.0;
    typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf pushToNextNavigationController:viewController];
        
    });
}

- (void)showTipsMsg:(NSString *)msg delayDo:(void (^)())complete
{
    [self showTipsMsg:msg withDelay:1.0];
    dispatch_time_t second = 1.0;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (complete) {
            complete();
        }
        
    });
}

#pragma mark - push、pop

- (void)pushToNextNavigationController:(UIViewController *)viewcontroller
{
    [self.navigationController pushViewController:viewcontroller animated:YES];
}

- (void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popRootViewController
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popToViewController:(Class)controller
{
    for (UIViewController *subViewController in self.navigationController.viewControllers) {
        if ([subViewController isKindOfClass:controller]) {
            [self.navigationController popToViewController:subViewController animated:YES];
        }
    }

}

#pragma mark - lazyLoading

- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"nav_button_back"] forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"nav_button_back"] forState:UIControlStateHighlighted];
        _leftButton.backgroundColor = [UIColor clearColor];
        [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton sizeToFit];
        self.navigationItem.leftBarButtonItem = self.leftBarButtonItem;
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightButton.backgroundColor = [UIColor clearColor];
        [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton sizeToFit];
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    }
    return _rightButton;
}

- (UIBarButtonItem *)leftBarButtonItem
{
    if (!_leftBarButtonItem) {
        _leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    }
    return _leftBarButtonItem;
}

- (UIBarButtonItem *)rightBarButtonItem
{
    if (!_rightBarButtonItem) {
        _rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    }
    return _rightBarButtonItem;
}

- (void)leftButtonAction:(UIButton *)sender
{
    [self popBack];
}

- (void)rightButtonAction:(UIButton *)sender
{
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
