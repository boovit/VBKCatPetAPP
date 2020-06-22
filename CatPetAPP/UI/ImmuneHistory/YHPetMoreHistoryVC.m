//
//  YHPetMoreHistoryVC.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/26.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPetMoreHistoryVC.h"
#import "YHTextInputView.h"
#import "YHUIDatePickView.h"

#import "YHDesignMacro.h"
#import "YHInfoTextTableCell.h"
#import "YHPetMoreHistoryVC+Weight.h"

@interface YHPetMoreHistoryVC ()<UITableViewDelegate,UITableViewDataSource,YHTextInputViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic, copy )NSString *type;
@property (nonatomic,strong)YHTextInputView *inputView;
@property (nonatomic,strong)YHUIDatePickView *dataPickView;
@property (nonatomic,strong)UIView *shadowView;
@end

@implementation YHPetMoreHistoryVC
-(instancetype)initWithType:(NSString*)type
{
    if (self = [super init]) {
        self.type = type;
        [self registerNotification];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self initDataSource];
}

-(void)initNavigationBar
{
    [super initNavigationBar];
    [self createNavigationItems];
    [self setNavBarTitle:@"更多记录"];
}

-(void)createNavigationItems
{
    UIView *rightCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, NavHeight)];
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.frame = CGRectMake(WIDTH(rightCustomView)-NavHeight, 0, NavHeight, NavHeight);
    [scanBtn setTitle:@"完成" forState:UIControlStateNormal];
    [scanBtn setTitleColor:[UIColor colorWithHexValue:YHDesignMacroColor_Deputy_Light] forState:UIControlStateNormal];
    scanBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [scanBtn addTarget:self action:@selector(finishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightCustomView addSubview:scanBtn];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightCustomView];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(YHUIDatePickView *)dataPickView
{
    if (!_dataPickView) {
        _dataPickView = [[YHUIDatePickView alloc] initWithFrame:self.view.bounds];
    }
    return _dataPickView;
}

-(YHTextInputView *)inputView
{
    if (!_inputView) {
        _inputView = [[YHTextInputView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 53)];
        _inputView.backgroundColor = [UIColor whiteColor];
        _inputView.delegate = self;
    }
    return _inputView;
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
        [self.view sendSubviewToBack:_tableView];
    }
}

-(void)initDataSource
{
    if (!_dataSource) {
        if ([self.type isEqualToString:@"weight"]) {
            _dataSource = [self weightDataSource];
        }
    }
}

-(void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDismiss:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)reloadTableViewIndexPath:(NSIndexPath*)indexPath
{
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

- (void)showDatePickViewTag:(NSString*)tag indexPath:(NSIndexPath*)cellIndex
{
    self.dataPickView.tagStr = tag;
    weakify(self);
    [self.dataPickView show:self.view.window didSelectedItemIndex:^(YHUIBasePickView *pickView,NSString *text,NSIndexPath *indexPath) {
        strongify(self);
        [self modifiyData:text tag:pickView.tagStr dataSource:self.dataSource];
    }];
}

-(YHInfoItemData*)cellItemDataByTag:(NSString*)tag
{
    for (YHInfoItemData *info in self.dataSource) {
        if ([info.tag isEqualToString:tag]) {
            return info;
        }
    }
    return nil;
}

- (void)showInputViewWithTag:(NSString*)tag;
{
    [self showShadowMask];
    [self.view.window addSubview:self.inputView];
    self.inputView.y = self.view.height;
    self.inputView.tagStr = tag;
    [self.inputView show];
}

-(void)dismissInputView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.inputView.y = self.view.height;
    } completion:^(BOOL finished) {
        [self.inputView removeFromSuperview];
    }];
}

-(void)showShadowMask
{
    self.shadowView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissInput:)];
    [_shadowView addGestureRecognizer:tap];
    _shadowView.backgroundColor = YHUIShadowColor;
    [self.view.window addSubview:_shadowView];
}

-(void)dismissShadowMask
{
    [self.shadowView removeFromSuperview];
    _shadowView = nil;
}

-(void)dismissInput:(id)sender
{
    [self.inputView dismiss];
}

- (BOOL)verifyNickName:(NSString *)nickName
{
    NSString *pattern = @"^[a-zA-Z0-9\u4E00-\u9FA5]{2,7}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [predicate evaluateWithObject:nickName];
    return isMatch;
}

- (BOOL)isIllegalNickName:(NSString *)nickName
{
    if (nickName.length == 0) {
        return YES;
    } else if (![self verifyNickName:nickName]) {
        return YES;
    }
    return NO;
}

#pragma mark - Button Action
-(void)finishButtonClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didFinishMoreHistory:data:)]) {
        YHPetWeightHistoryData *data = [self assambleItemDataWithDataSource:self.dataSource];
        [self.delegate didFinishMoreHistory:self data:data];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.inputView.y = self.view.height - height - self.inputView.height;
    }];
}

- (void)keyboardWillDismiss:(NSNotification *)notification
{
    [self dismissShadowMask];
    [self dismissInputView];
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
    [self configTableView:tableView cell:(YHInfoTextTableCell*)cell indexPath:indexPath dataSource:self.dataSource];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self.type isEqualToString:@"weight"]) {
        [self didSelectedWeightTableView:tableView indexPath:indexPath dataSource:self.dataSource];
    }
}

#pragma mark - YHTextInputViewDelegate
- (void)sendBtnClick:(YHTextInputView *)inputView text:(NSString *)text
{
    if ([self isIllegalNickName:text]) {
        return;
    }
    [self modifiyData:text tag:inputView.tagStr dataSource:self.dataSource];
    [inputView clearText];
}
@end
