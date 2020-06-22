//
//  YHAllPetListVC.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/2/28.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHAllPetListVC.h"
#import "NSMutableDictionary+Safe.h"

#import "YHImageTextTableCell.h"
#import "YHPetInfoListOP.h"
#import "YHChannelUtilTools.h"
#import "YHPetInfomationVC.h"
#import "YHDesignMacro.h"

@interface YHAllPetListVC ()<UITableViewDelegate,UITableViewDataSource,YHAddPetInfoVCDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)YHPetInfoListOP *infoListOP;

@end

@implementation YHAllPetListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createTableView];
    [self requestList:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - override
-(void)initNavigationBar
{
    [super initNavigationBar];
    [self createNavigationItems];
    [self setNavBarTitle:@"列表"];
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
    [scanBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [scanBtn setTitleColor:[UIColor colorWithHexValue:YHDesignMacroColor_Deputy_Light] forState:UIControlStateNormal];
    scanBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [scanBtn addTarget:self action:@selector(filterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [rightCustomView addSubview:scanBtn];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftCustomView];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightCustomView];
    
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;
    
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer,leftItem];
//    self.navigationItem.rightBarButtonItem = rightItem;
}

-(YHPetInfoListOP *)infoListOP
{
    if (!_infoListOP) {
        _infoListOP = [[YHPetInfoListOP alloc] init];
    }
    return _infoListOP;
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
        
        MJWeakSelf;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf reloadTableView4PullDown];
        }];
    }
}

-(void)requestList:(BOOL)loadingView
{
    weakify(self);
    if (loadingView) [YHShareUtil showLoadingOnView:self.view];
    [self.infoListOP request:nil completeBlock:^(YHPetInfoListData *data) {
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
    YHPetData *data = [_dataSource safe_objectAtIndex:indexPath.row];
    NSString *subStr = [NSString stringWithFormat:@"%@   %@   %@",data.birthday,data.sex,data.hair_color];
    [cell refreshPoster:data.img_url title:data.name subTitle:subStr];
}

-(void)pushAddPetInfoViewController
{
    [YHChannelUtilTools pushAddPetInfoVC:self.navigationController delegate:self data:nil];
}

#pragma mark - Action
-(void)addButtonClick:(id)sender
{
    [self pushAddPetInfoViewController];
}

-(void)filterButtonClick:(id)sender
{
    
}

#pragma mark - MJRefreshBlcok
-(void)reloadTableView4PullDown
{
    [self requestList:NO];
}

#pragma mark - tableViewDelegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = [_dataSource count];
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
    
    YHPetData *data = [_dataSource safe_objectAtIndex:indexPath.row];
    YHPetInfomationVC *vc = [[YHPetInfomationVC alloc] initWithPetData:data];
    [self.navigationController pushViewController:vc animated:YES];
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
    //TODO:删除操作，提交删除记录
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSLog(@"提交删除");
        YHPetData *petData = [self.dataSource safe_objectAtIndex:indexPath.row];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic safe_setObject:petData._id forKey:@"id"];
        weakify(self);
        [YHShareUtil showLoadingOnView:self.view];
        [self.infoListOP deletePetInfo:dic completeBlock:^() {
            strongify(self);
            [YHShareUtil hideLoadingOnView:self.view];
            [self.dataSource removeObjectAtIndex:indexPath.row];//删除数据源
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];//刷新cell
        } errorBlock:^(NSError *error) {
            [YHShareUtil hideLoadingOnView:self.view];
        }];
    }
}

#pragma mark - YHAddPetInfoVCDelegate
-(void)didUpdatePetInfoVC:(UIViewController*)vc
{
    [self requestList:YES];
}
@end
