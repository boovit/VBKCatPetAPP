//
//  YHPassportVC.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/4/16.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPassportVC.h"
#import <Masonry/Masonry.h>

#import "UIColor+HexValue.h"
#import "YHPassportManager.h"
#import "YHUIUtilMacro.h"
#import "YHShareUtil.h"
#import "YHNotificationHelper.h"
#import "YHDesignMacro.h"

@interface YHPassportVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong)UILabel *userNameLab;
@property(nonatomic,strong)UILabel *passwordLab;
@property(nonatomic,strong)UITextField *userNameTF;
@property(nonatomic,strong)UITextField *passwordTF;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *registBtn;
@end

@implementation YHPassportVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBarTitle:@"欢迎使用喵宠"];
    [self createUI];
}

-(void)createUI
{
    self.logoImageView = [[UIImageView alloc] init];
    _logoImageView.image = [UIImage imageNamed:@"icon"];
    [self.view addSubview:_logoImageView];
    
    self.userNameTF = [[UITextField alloc] init];
    _userNameTF.placeholder = @"手机号";
    _userNameTF.borderStyle = UITextBorderStyleRoundedRect;
    _userNameTF.delegate = self;
    [self.view addSubview:_userNameTF];
    
    self.passwordTF = [[UITextField alloc] init];
    _passwordTF.placeholder = @"密码";
    _passwordTF.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTF.delegate = self;
    _passwordTF.secureTextEntry = YES;
    [self.view addSubview:_passwordTF];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.layer.cornerRadius = 5.0f;
    _loginBtn.backgroundColor = [UIColor colorWithHexValue:YHDesignMacroColor_Theme];
    [_loginBtn setTitleColor:[UIColor colorWithHexValue:YHDesignMacroColor_Deputy_Light] forState:UIControlStateNormal];
    [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
//    self.registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _registBtn.layer.borderColor = [UIColor blueColor].CGColor;
//    _registBtn.layer.borderWidth = SINGLE_PIXEL_HEIGHT;
//    [_registBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
//    [_registBtn addTarget:self action:@selector(registButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_registBtn];
    
    [self masLayoutSubviews];
}

#pragma mark - private
-(void)masLayoutSubviews
{
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(NavigtionBarHeight+20);
        make.width.height.equalTo(@80);
    }];
    
    [_userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.logoImageView.mas_bottom).offset(20);
        make.width.equalTo(@(YHScreen_width-80));
        make.height.equalTo(@40);
    }];
    
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.userNameTF);
        make.top.equalTo(self.userNameTF.mas_bottom).offset(20);
        make.width.height.equalTo(self.userNameTF);
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(60);
        make.width.equalTo(@(YHScreen_width-80));
        make.height.equalTo(@40);
    }];
    
//    [_registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.loginBtn.mas_bottom).offset(20);
//        make.width.equalTo(@(YHScreen_width-40));
//        make.height.equalTo(@50);
//    }];
}

#pragma mark - Action
-(void)loginButtonClicked:(id)sender
{
    if (__isStrNotEmpty(_userNameTF.text) && __isStrNotEmpty(_passwordTF.text)) {
        YHPPUserData *userData = [[YHPPUserData alloc] init];
        userData.username = _userNameTF.text;
        userData.password = _passwordTF.text;
        userData.device_token = [YHNotificationHelper getCacheToken];
        [YHShareUtil showLoadingOnView:self.view];
        [[YHPassportManager shareInstance] loginWithUserData:userData completeBlock:^(NSError *error) {
            [YHShareUtil hideLoadingOnView:self.view];
            if (error == nil) {
                //登陆成功
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [YHShareUtil showToast:@"登陆失败!"];
            }
        }];
    }
}

-(void)registButtonClicked:(id)sender
{
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
