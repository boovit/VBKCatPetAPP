//
//  YHPetMessageNotifyVC.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/2/27.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPetMessageNotifyVC.h"
#import "YHPassportManager.h"
#import "UIViewController+Ext.h"
#import "YHUIUtilMacro.h"

#import "YHAddPetInfoVC.h"
#import "YHScanningVC.h"
#import "YHImageTextTableCell.h"
#import "YHPetMessageNotifyOP.h"
#import "YHChannelUtilTools.h"
#import "YHExceptionView.h"
#import "YHDesignMacro.h"

@interface YHPetMessageNotifyVC ()<UITableViewDelegate,UITableViewDataSource,YHPetImmuneHistoryVCDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)YHPetMessageNotifyOP *messageOP;
@property (nonatomic,strong)YHExceptionView *nullDataErrorView;
@property (nonatomic,strong)YHExceptionView *networkErrorView;
@end

@implementation YHPetMessageNotifyVC
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self registerNotification];
    }
    return self;
}
#pragma mark - vc live cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self requestMessageList:YES];
}

-(YHPetMessageNotifyOP *)messageOP
{
    if (!_messageOP) {
        _messageOP = [[YHPetMessageNotifyOP alloc] init];
    }
    return _messageOP;
}

#pragma mark - override
-(void)initNavigationBar
{
    [super initNavigationBar];
    [self createNavigationItems];
    [self setNavBarTitle:@"消息"];
}

-(void)createNavigationItems
{
    UIView *leftCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, NavHeight)];
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, NavHeight, NavHeight);
    [addBtn setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
    [addBtn setImage:[UIImage imageNamed:@"add_icon_150"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"add_icon_150"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftCustomView addSubview:addBtn];
    
    UIView *rightCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, NavHeight)];
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.frame = CGRectMake(WIDTH(rightCustomView)-NavHeight, 0, NavHeight, NavHeight);
    [scanBtn setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
    [scanBtn setImage:[UIImage imageNamed:@"qr_icon_150"] forState:UIControlStateNormal];
    [scanBtn setImage:[UIImage imageNamed:@"qr_icon_150"] forState:UIControlStateHighlighted];
    [scanBtn addTarget:self action:@selector(scanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightCustomView addSubview:scanBtn];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftCustomView];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightCustomView];
    
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;
    
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer,leftItem];
    self.navigationItem.rightBarButtonItems = @[nagetiveSpacer,rightItem];
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

#pragma mark - private
-(void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:kNotification_PassportManager_Login object:nil];
}

-(void)loginSuccess:(NSNotification*)notification
{
    [self requestMessageList:YES];
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
        
        MJWeakSelf;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf reloadTableView4PullDown];
        }];
    }
}

-(void)pushAddPetInfoViewController
{
    [YHChannelUtilTools pushAddPetInfoVC:self.navigationController delegate:self data:nil];
}

-(void)pushScanningViewController
{
    [YHChannelUtilTools pushScanningVC:self.navigationController];
}

-(void)refreshTable
{
    [_tableView reloadData];
}

-(void)endLoadingRefreshTableView
{
    [_tableView.mj_header endRefreshing];
}

-(void)configCell:(YHImageTextTableCell*)cell indexPath:(NSIndexPath*)indexPath
{
    YHPetMessageData *data = [self getDataByDataSourceIndexPath:indexPath];
    NSString *gapStr = @"";
    if (data.next_gap.integerValue<0) {
        gapStr = [NSString stringWithFormat:@"您有%ld天偷懒",(long)-data.next_gap.integerValue];
    }else{
        gapStr = [NSString stringWithFormat:@"距下次%ld天",(long)data.next_gap.integerValue];
    }
    NSString *subStr = [NSString stringWithFormat:@"上次免疫:%@ %@",data.last_record,gapStr];
    [cell refreshPoster:data.img_url title:data.name subTitle:subStr];
}

-(YHPetMessageData*)getDataByDataSourceIndexPath:(NSIndexPath*)indexPath
{
    YHMessageBlockItem *item = [_dataSource safe_objectAtIndex:indexPath.section];
    YHPetMessageData *data = [item.items safe_objectAtIndex:indexPath.row];
    return data;
}

#pragma mark - MJRefreshBlcok
-(void)reloadTableView4PullDown
{
    [self requestMessageList:NO];
}

#pragma mark - NetWork req
-(void)requestMessageList:(BOOL)isShow
{
    if (isShow) {
        [YHShareUtil showLoadingOnView:self.view];
    }
    weakify(self);
    [self.messageOP request:nil completeBlock:^(YHPetMessageNotifyData *data) {
        strongify(self);
        [YHShareUtil hideLoadingOnView:self.view];
        [self dealWithData:data.result];
        [self dissmissNetworkError];
    } errorBlock:^(NSError *error) {
        //错误提示
        [YHShareUtil hideLoadingOnView:self.view];
        [self endLoadingRefreshTableView];
        if (![[error domain] isEqualToString:YHNetWork_ErrorDomain] || error.code != YHNetWrok_ErrorType_Login_Code) {
            [self showNetworkError4View:self.tableView];
        }
    }];
}

-(void)dealWithData:(NSMutableArray*)dataArray
{
    self.dataSource = dataArray;
    [self refreshTable];
    [self endLoadingRefreshTableView];
    
    if (dataArray.count == 0) {
        [self showNothingError4View:self.tableView];
    }else{
        [self dissmissNothingError];
    }
}

#pragma mark - Button Action
-(void)addButtonClick:(id)sender
{
    [self pushAddPetInfoViewController];
}

-(void)scanButtonClick:(id)sender
{
    [self pushScanningViewController];
}

#pragma mark - tableViewDelegate & datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YHMessageBlockItem* sectionData = [_dataSource safe_objectAtIndex:section];
    NSInteger number = [sectionData.items count];
    return number;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = YHImageTextTableCellHeight;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identify = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[YHImageTextTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    [self configCell:(YHImageTextTableCell*)cell indexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    YHMessageBlockItem *item = [_dataSource safe_objectAtIndex:indexPath.section];
    YHPetMessageData *data = [self getDataByDataSourceIndexPath:indexPath];
    [YHChannelUtilTools pushImmuneHistoryVC:self.navigationController delegate:self petID:data._id.unsignedIntegerValue type:item.type title:item.title];
}

#pragma mark - YHPetImmuneHistoryVCDelegate
-(void)didUpdateHistoryVC:(UIViewController*)vc
{
    [self requestMessageList:YES];
}
@end


