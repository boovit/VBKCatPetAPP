//
//  YHPetManagerVC.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/2/28.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPetManagerVC.h"
#import <Masonry.h>
#import "UIView+Rect.h"
#import "UIColor+HexValue.h"
#import "YHShareUtil.h"
#import "YHDesignMacro.h"
#import "YHPassportManager.h"
#import "YHPetManagerCardView.h"
#import "YHPetManagerDetailVC.h"
#import "YHPassportManager.h"
#import "YHPassportUtility.h"

@interface YHPetManagerVC ()<YHPetManagerCardViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)YHPetManagerCardView *cardView;
@property (nonatomic,strong)UILabel *appVersionLabel;
@end

@implementation YHPetManagerVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self registerNotification];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self refreshCardInfo];
    self.appVersionLabel.text = [NSString stringWithFormat:@"v%@",[YHShareUtil appVersion]];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - override
-(void)initNavigationBar
{
    [super initNavigationBar];
    [self setNavBarTitle:@"宠窝"];
}

-(void)createTableView
{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
}

-(YHPetManagerCardView *)cardView
{
    if (!_cardView) {
        self.cardView = [[YHPetManagerCardView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), YHPetManagerCardViewHeight)];
        _cardView.delegate = self;
    }
    return _cardView;
}

-(UILabel *)appVersionLabel
{
    if (!_appVersionLabel) {
        self.appVersionLabel = [[UILabel alloc] init];
        _appVersionLabel.textColor = [UIColor colorWithHexValue:YHDesignMacroColor_Gray];
        _appVersionLabel.font = [UIFont systemFontOfSize:YHDesignMacroFontSize_SubTitle];
        [self.view addSubview:_appVersionLabel];
        
        [_appVersionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-TabBarHeight-10);
        }];
    }
    return _appVersionLabel;
}

-(void)refreshCardInfo
{
    if ([YHPassportManager shareInstance].isLogin) {
        [self setupLoginCardInfo];
    }else{
        [self setupLogoutCardInfo];
    }
}

-(void)setupLoginCardInfo
{
    YHPetManagerCardViewModel *cardData = [[YHPetManagerCardViewModel alloc] init];
    cardData.imgUrl = @"";
    cardData.title = [NSString stringWithFormat:@"欢迎舍长,%@",[YHPassportManager shareInstance].userData.user.username];
    [self.cardView reloadWithData:cardData];
    [self refreshTableHeadView];
}

-(void)setupLogoutCardInfo
{
    YHPetManagerCardViewModel *cardData = [[YHPetManagerCardViewModel alloc] init];
    cardData.imgUrl = @"";
    cardData.title = [NSString stringWithFormat:@"您未登录，请点击登录"];
    [self.cardView reloadWithData:cardData];
    [self refreshTableHeadView];
}

-(void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFinish:) name:kNotification_PassportManager_Login object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutFinish:) name:kNotification_PassportManager_Logout object:nil];
}

-(void)loginFinish:(id)sender
{
    [self setupLoginCardInfo];
}

-(void)logoutFinish:(id)sender
{
    [self setupLogoutCardInfo];
}

-(void)refreshTableHeadView
{
    self.tableView.tableHeaderView = nil;
    self.tableView.tableHeaderView = self.cardView;
}

#pragma mark - CardView Delegate
-(void)didSelectedCardView:(UIView*)view
{
    if ([YHPassportManager shareInstance].isLogin) {
        YHPetManagerDetailVC *vc = [[YHPetManagerDetailVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [YHPassportUtility presentPassportFromVC:self];
    }
}

#pragma mark - TableViewDelegate & DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 30;
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * info_identify = @"info_identify";
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:info_identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:info_identify];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
