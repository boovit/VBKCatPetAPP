//
//  YHPetInfomationVC.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/20.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPetInfomationVC.h"

#import "NSMutableArray+Safe.h"
#import "NSMutableDictionary+Safe.h"
#import "YHInfoTextTableCell.h"
#import "YHPetInfoCell.h"

#import "YHChannelUtilTools.h"
#import "YHProjectMacro.h"
#import "YHPetDetailInfoOP.h"

@interface YHPetInfomationVC ()<UITableViewDelegate,UITableViewDataSource,YHPetInfoCellDelegate,YHPetImmuneHistoryVCDelegate>
@property (nonatomic,strong)YHPetData *petData;
@property (nonatomic,assign)NSUInteger petID;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)YHPetDetailInfoOP *petDetailInfoOP;
@end

@implementation YHPetInfomationVC
-(instancetype)initWithPetData:(YHPetData*)petData
{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        self.petData = petData;
        self.petID = petData._id.unsignedIntegerValue;
    }
    return self;
}

-(instancetype)initWithPetId:(NSUInteger)petID
{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        self.petID = petID;
    }
    return self;
}

-(void)initNavigationBar
{
    [super initNavigationBar];
    [self setNavBarTitle:self.petData.name];
}

-(YHPetDetailInfoOP *)petDetailInfoOP
{
    if (!_petDetailInfoOP) {
        _petDetailInfoOP = [[YHPetDetailInfoOP alloc] init];
    }
    return _petDetailInfoOP;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self requestPetInfo];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - private
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

-(void)requestPetInfo
{
    [YHShareUtil showLoadingOnView:self.view];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic safe_setObject:[NSNumber numberWithUnsignedInteger:self.petID] forKey:@"id"];
    weakify(self);
    [self.petDetailInfoOP request:dic completeBlock:^(YHPetDetailInfoData *data) {
        strongify(self);
        [YHShareUtil hideLoadingOnView:self.view];
        [self setupInfoData4DataSource:data];
        [self dissmissNetworkError];
    } errorBlock:^(NSError *error) {
        strongify(self);
        [YHShareUtil hideLoadingOnView:self.view];
        if (![[error domain] isEqualToString:YHNetWork_ErrorDomain] || error.code != YHNetWrok_ErrorType_Login_Code) {
            [self showNetworkError4View:self.tableView];
        }
    }];
}

-(void)setupInfoData4DataSource:(YHPetDetailInfoData*)infoData
{
    [self.dataSource removeAllObjects];
    YHPetData *petData = (YHPetData*)[infoData getPetDetailInfo];
    [self setNavBarTitle:petData.name];
    [self.dataSource safe_addObject:petData];
    [self.dataSource addObjectsFromArray:[infoData getPetDetailInfo].action_event];
    
    [self.tableView reloadData];
}

-(void)configInfoCell:(YHPetInfoCell*)cell data:(YHPetData*)data
{
    [cell.posterImageView sd_setImageWithURL:[NSURL URLWithString:data.img_url] placeholderImage:nil];
    cell.titleLabel.text = data.name;
    cell.subLabel.text = data.identity;
    cell.birthdayLabel.text = data.birthday;
    cell.ageLabel.text = [NSString stringWithFormat:@"%ld",(long)data.age.integerValue];
    cell.sexLabel.text = data.sex;
}

-(void)configImmuneCell:(YHInfoTextTableCell*)cell data:(YHPetImmuneItem*)data
{
    if (!data.dates || data.dates.count<=0) {
        [cell refreshTitle:@"" intro:@"您还没有添加信息，请点击添加" poster:nil];
    }else{
        YHImmuneHistoryData *date = [data.dates firstObject];
        [cell refreshTitle:@"最近更新:" intro:date.last_record poster:nil];
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
    if (section == 0) {
        return 0;
    }
    CGFloat height = 30;
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if(indexPath.section == 0){
        height = YHPetInfoCellHeight;
    }else{
        height = YHInfoTextTableCellHeight;
    }
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return nil;
    }
    YHPetImmuneItem *item = [self.dataSource safe_objectAtIndex:section];
    if (item && [item isKindOfClass:[YHPetImmuneItem class]]) {
        UIView *header = [[UIView alloc] init];
        header.backgroundColor = [UIColor colorWithHexValue:0xeaeaea];
        UILabel *headerTitle = [[UILabel alloc] init];
        headerTitle.text = item.title;
        [header addSubview:headerTitle];
        [headerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(header).offset(10);
            make.centerY.equalTo(header);
        }];
        return header;
    }else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * info_identify = @"info_identify";
    static NSString * immune_identify = @"immune_identify";
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:info_identify];
        if (cell == nil) {
            cell = [[YHPetInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:info_identify];
            [(YHPetInfoCell*)cell setDelegate:self];
        }
        [self configInfoCell:(YHPetInfoCell*)cell data:[self.dataSource safe_objectAtIndex:0]];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:immune_identify];
        if (cell == nil) {
            cell = [[YHInfoTextTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:immune_identify];
        }
        [self configImmuneCell:(YHInfoTextTableCell*)cell data:[self.dataSource safe_objectAtIndex:indexPath.section]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        [YHChannelUtilTools pushAddPetInfoVC:self.navigationController delegate:self data:self.petData];
    }else{
        YHPetImmuneItem *item = [_dataSource safe_objectAtIndex:indexPath.section];
        [YHChannelUtilTools pushImmuneHistoryVC:self.navigationController delegate:self petID:self.petID type:item.type title:item.title];
    }
}

#pragma mark - cell delegate
-(void)didClickQRCodeOnCell:(UITableViewCell*)cell
{
    YHPetInfoCell *infoCell = (YHPetInfoCell*)cell;
    [YHChannelUtilTools pushQRCodeVC:self.navigationController code:[self createPetQRCode:self.petID] poster:infoCell.posterImageView.image];
}

-(NSString*)createPetQRCode:(NSUInteger)petid
{
    NSString *code = [NSString stringWithFormat:@"%@://%@/petinfo?id=%ld",YHCatPetScheme,YHNetWork_Host,(unsigned long)petid];
    return code;
}

#pragma mark - YHPetImmuneHistoryVCDelegate
-(void)didUpdateHistoryVC:(UIViewController*)vc
{
    [self requestPetInfo];
}

@end

