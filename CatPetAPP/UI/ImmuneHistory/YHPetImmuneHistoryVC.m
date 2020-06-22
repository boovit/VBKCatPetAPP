//
//  YHPetImmuneHistoryVC.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/21.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPetImmuneHistoryVC.h"

#import "NSMutableDictionary+Safe.h"
#import "YHUIUtilMacro.h"
#import "YHUIDatePickView.h"

#import "YHImmueHistoryOP.h"
#import "YHInfoTextTableCell.h"
#import "YHDesignMacro.h"
#import "YHPetMoreHistoryVC.h"

@interface YHPetImmuneHistoryVC ()<UITableViewDelegate,UITableViewDataSource,YHPetMoreHistoryVCDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)UIButton *addHistoryBtn;
@property (nonatomic,strong)YHUIDatePickView *dataPickView;
@property (nonatomic,strong)YHImmueHistoryOP *immueHistoryOP;
@property (nonatomic,assign)NSUInteger petID;
@property (nonatomic, copy )NSString* type;
@property (nonatomic, copy )NSString* typeName;
@end

@implementation YHPetImmuneHistoryVC

-(instancetype)initWithPetId:(NSUInteger)petID type:(NSString*)type title:(NSString*)title
{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        self.petID = petID;
        self.type = type;
        self.typeName = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self requestHistoryList];
}

-(void)initNavigationBar
{
    [super initNavigationBar];
    [self setNavBarTitle:__isStrNotEmpty(self.typeName)?self.typeName:@"记录"];
}

-(UIButton *)addHistoryBtn
{
    if (!_addHistoryBtn) {
        _addHistoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addHistoryBtn.layer.borderWidth = SINGLE_PIXEL_HEIGHT;
        _addHistoryBtn.layer.borderColor = [[UIColor colorWithHexValue:YHDesignMacroColor_Deputy_Light] CGColor];
        _addHistoryBtn.layer.cornerRadius = 10;
        [_addHistoryBtn setTitle:@"新增记录" forState:UIControlStateNormal];
        [_addHistoryBtn setBackgroundColor:[UIColor colorWithHexValue:YHDesignMacroColor_Theme]];
        [_addHistoryBtn setTitleColor:[UIColor colorWithHexValue:YHDesignMacroColor_Deputy_Light] forState:UIControlStateNormal];
        [_addHistoryBtn addTarget:self action:@selector(addRecordClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_addHistoryBtn];
        
        [_addHistoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-10);
            make.centerX.equalTo(self.view);
            make.width.equalTo(self.view).offset(-10);
            make.height.equalTo(@50);
        }];
        
        [self.view layoutIfNeeded];
    }
    return _addHistoryBtn;
}

-(YHUIDatePickView *)dataPickView
{
    if (!_dataPickView) {
        _dataPickView = [[YHUIDatePickView alloc] initWithFrame:self.view.bounds];
    }
    return _dataPickView;
}

-(YHImmueHistoryOP *)immueHistoryOP
{
    if (!_immueHistoryOP) {
        _immueHistoryOP = [[YHImmueHistoryOP alloc] init];
    }
    return _immueHistoryOP;
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
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, HEIGHT(self.addHistoryBtn), 0);
        [self.view addSubview:_tableView];
        [self.view sendSubviewToBack:_tableView];
    }
}

-(void)requestHistoryList
{
    [YHShareUtil showLoadingOnView:self.view];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSNumber numberWithUnsignedInteger:self.petID],@"cat_info_id",
                         self.type,@"type",
                         nil];
    weakify(self);
    [self.immueHistoryOP request:dic type:self.type completeBlock:^(YHBaseData *data) {
        strongify(self);
        [YHShareUtil hideLoadingOnView:self.view];
        [self dealWithData:data];
        [self dissmissNetworkError];
    } errorBlock:^(NSError *error) {
        strongify(self);
        [YHShareUtil hideLoadingOnView:self.view];
        if (![[error domain] isEqualToString:YHNetWork_ErrorDomain] || error.code != YHNetWrok_ErrorType_Login_Code) {
            [self showNetworkError4View:self.tableView];
        }
    }];
}

-(void)requestAddHistoryData:(YHImmuneHistoryData*)historyData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic safe_setObject:[NSNumber numberWithUnsignedInteger:self.petID] forKey:@"cat_info_id"];
    [dic safe_setObject:self.type forKey:@"type"];
    [dic safe_setObject:historyData.last_record forKey:@"last_record"];
    if([historyData isKindOfClass:[YHPetWeightHistoryData class]]){
        [dic safe_setObject:[(YHPetWeightHistoryData*)historyData weight] forKey:@"weight"];
    }
    
    [YHShareUtil showLoadingOnView:self.view];
    weakify(self);
    [self.immueHistoryOP addHistoryRequest:dic completeBlock:^(YHAddPetHistoryData *data) {
        strongify(self);
        [YHShareUtil hideLoadingOnView:self.view];
        [self requestHistoryList];
        [self dealUpateEvent];
    } errorBlock:^(NSError *error) {
        strongify(self);
        [YHShareUtil hideLoadingOnView:self.view];
    }];
}

-(void)requestDelHistoryDate:(NSNumber*)dateid
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic safe_setObject:dateid forKey:@"cat_info_id"];
    [dic safe_setObject:self.type forKey:@"type"];
    [dic safe_setObject:dateid forKey:@"id"];
    
    [YHShareUtil showLoadingOnView:self.view];
    weakify(self);
    [self.immueHistoryOP deleteHistoryRequest:dic completeBlock:^(YHDelPetHistoryData *data) {
        strongify(self);
        [YHShareUtil hideLoadingOnView:self.view];
        [self requestHistoryList];
        [self dealUpateEvent];
    } errorBlock:^(NSError *error) {
        strongify(self);
        [YHShareUtil hideLoadingOnView:self.view];
    }];
}

-(void)dealWithData:(YHBaseData*)data
{
    [self.dataSource removeAllObjects];
    if ([data isKindOfClass:[YHPetWeightHistoryPageData class]]) {
        self.dataSource = [(YHPetWeightHistoryPageData*)data result];
    }else{
        self.dataSource = [(YHPetImmueHistoryPageData*)data result];
    }
    if (self.dataSource.count<=0) {
        [self showNothingError4View:self.tableView];
    }else{
        [self dissmissNothingError];
    }
    [self.tableView reloadData];
}

-(void)configCell:(YHInfoTextTableCell*)cell andData:(YHImmuneHistoryData*)data
{
    if ([data isKindOfClass:[YHPetWeightHistoryData class]]) {
        YHPetWeightHistoryData *wdata = (YHPetWeightHistoryData*)data;
        [cell refreshTitle:[NSString stringWithFormat:@"%ld克",(long)wdata.weight.integerValue] intro:wdata.last_record poster:nil];
    }else{
        [cell refreshTitle:@"时间：" intro:data.last_record poster:nil];
    }
}

-(void)dealUpateEvent
{
    if ([_delegate respondsToSelector:@selector(didUpdateHistoryVC:)]) {
        [_delegate didUpdateHistoryVC:self];
    }
}

#pragma mark - Action
- (void)addRecordClick:(id)sender
{
    if ([self.type isEqualToString:@"weight"]) {
        YHPetMoreHistoryVC *vc = [[YHPetMoreHistoryVC alloc] initWithType:self.type];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.dataPickView show:self.view.window didSelectedItemIndex:^(YHUIBasePickView *pickView, NSString *text, NSIndexPath *indexPath) {
            YHImmuneHistoryData *data = [[YHImmuneHistoryData alloc] init];
            data.last_record = text;
            [self requestAddHistoryData:data];
        }];
    }
}

#pragma mark - TableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = [_dataSource count];
    return number;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = YHInfoTextTableCellHeight;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identify = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[YHInfoTextTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    YHImmuneHistoryData *data = [self.dataSource safe_objectAtIndex:indexPath.row];
    [self configCell:(YHInfoTextTableCell*)cell andData:data];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSLog(@"提交删除");
        YHImmuneHistoryData *item = [self.dataSource safe_objectAtIndex:indexPath.row];
        [self requestDelHistoryDate:item._id];
    }
}

#pragma mark -
-(void)didFinishMoreHistory:(UIViewController*)vc data:(YHPetWeightHistoryData*)weightData
{
    [self requestAddHistoryData:weightData];
}
@end
