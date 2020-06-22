//
//  YHBaseViewController.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/2/27.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHBaseViewController.h"
#import "NSMutableDictionary+Safe.h"
#import "UIColor+HexValue.h"
#import "YHUIUtilMacro.h"
#import "YHDesignMacro.h"
#import "YHExceptionView.h"

@interface YHBaseViewController ()
@property(nonatomic,strong)UILabel *navigationBarTitle;
@property (nonatomic,strong)YHExceptionView *nullDataErrorView;
@property (nonatomic,strong)YHExceptionView *networkErrorView;
@end

@implementation YHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexValue:YHDesignMacroColor_Background];
    [self initNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(YHExceptionView *)networkErrorView
{
    if (!_networkErrorView) {
        _networkErrorView = [[YHExceptionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-NavigtionBarHeight-TabBarHeight) type:YHExceptionView_Network];
    }
    return _networkErrorView;
}

-(YHExceptionView *)nullDataErrorView
{
    if (!_nullDataErrorView) {
        _nullDataErrorView = [[YHExceptionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-NavigtionBarHeight-TabBarHeight) type:YHExceptionView_NullData];
    }
    return _nullDataErrorView;
}

#pragma mark - public
-(void)initNavigationBar
{
    UIImageView* blackLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];//找到导航栏底部黑线
    blackLineImageView.hidden = YES;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexValue:YHDesignMacroColor_Theme];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexValue:YHDesignMacroColor_Deputy_Light];
    //子类实现
}

-(void)setNavBarTitle:(NSString *)title
{
    self.navigationBarTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 44)];
    _navigationBarTitle.backgroundColor=[UIColor clearColor];
    _navigationBarTitle.font = [UIFont systemFontOfSize:YHDesignMacroFontSize_NavTitle];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes safe_setObject:self.navigationBarTitle.font forKey:NSFontAttributeName];
    CGSize size = [title sizeWithAttributes:attributes];
    _navigationBarTitle.textColor = [UIColor colorWithHexValue:YHDesignMacroColor_Deputy_Light];
    
    CGFloat titleWidth = MIN(self.navigationBarTitle.frame.size.width, size.width);
    _navigationBarTitle.frame = CGRectMake(0, 0, titleWidth, NavigtionBarHeight);
    _navigationBarTitle.textAlignment = NSTextAlignmentCenter;
    _navigationBarTitle.text = title;
    self.navigationItem.titleView = _navigationBarTitle;
}

-(void)showNothingError4View:(UIView*)view
{
    [self.nullDataErrorView show:view];
}

-(void)dissmissNothingError
{
    [self.nullDataErrorView dissmiss];
}

-(void)showNetworkError4View:(UIView*)view
{
    [self.networkErrorView show:view];
}

-(void)dissmissNetworkError
{
    [self.networkErrorView dissmiss];
}

#pragma mark - pravite
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
@end
