//
//  YHPetManagerDetailVC.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/28.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPetManagerDetailVC.h"
#import "YHPassportManager.h"
#import "UIColor+HexValue.h"
#import "YHDesignMacro.h"

@interface YHPetManagerDetailVC ()
@property(nonatomic,strong)UIButton *logoutBtn;
@end

@implementation YHPetManagerDetailVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
        [self registerNotification];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

#pragma mark - override
-(void)initNavigationBar
{
    [super initNavigationBar];
    [self setNavBarTitle:@"舍长详情"];
}

-(void)createUI
{
    if (!_logoutBtn) {
        self.logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutBtn.layer.cornerRadius = 5.0;
        _logoutBtn.backgroundColor = [UIColor colorWithHexValue:YHDesignMacroColor_Warning];
        [_logoutBtn setTitle:@"退出" forState:UIControlStateNormal];
        [_logoutBtn addTarget:self action:@selector(logoutClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_logoutBtn];
    }
    [self masLayoutSubViews];
}

-(void)masLayoutSubViews
{
    [_logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).offset(-30);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@50);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
    }];
}

-(void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFinish:) name:kNotification_PassportManager_Login object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutFinish:) name:kNotification_PassportManager_Logout object:nil];
}

-(void)loginFinish:(id)sender
{
    _logoutBtn.hidden = NO;
}

-(void)logoutFinish:(id)sender
{
    _logoutBtn.hidden = YES;
}

-(void)logoutClicked:(id)sender
{
    [[YHPassportManager shareInstance] logout];
}

@end
