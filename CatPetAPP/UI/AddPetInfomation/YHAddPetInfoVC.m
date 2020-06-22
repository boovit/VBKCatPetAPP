//
//  YHAddPetInfoVC.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/8.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHAddPetInfoVC.h"
#import <AssetsLibrary/AssetsLibrary.h>
//third party
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
//sharelib
#import "YHTextInputView.h"
#import "YHUIPickView.h"
#import "YHUIDatePickView.h"
#import "NSString+Format.h"
//project
#import "YHInfoTextTableCell.h"
#import "YHTextViewTableCell.h"
#import "YHInfoItemData.h"
#import "YHFileUploadOP.h"
#import "YHAddPetInfoOP.h"
#import "YHTextInputView.h"
#import "YHDesignMacro.h"

#define ADD_INFO_NAME_TAG @"addinfo_name"
#define ADD_INFO_POSTER_TAG @"addinfo_poster"
#define ADD_INFO_BIRTHDAY_TAG @"addinfo_birthday"
#define ADD_INFO_COLOR_TAG @"addinfo_color"
#define ADD_INFO_SEX_TAG @"addinfo_sex"
#define ADD_INFO_VARIET_TAG @"addinfo_variety" //品种
#define ADD_INFO_REMARK_TAG @"addinfo_remark" //备注

@interface YHAddPetInfoVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,YHTextInputViewDelegate,YHTextViewTableCellDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)YHFileUploadOP *fileUploadOP;
@property (nonatomic,strong)YHAddPetInfoOP *addPetInfoOP;
@property (nonatomic,strong)YHTextInputView *inputView;
@property (nonatomic,strong)UIView *shadowView;
@property (nonatomic,strong)YHUIBasePickView *pickView;
@property (nonatomic,strong)YHUIDatePickView *dataPickView;
@property (nonatomic,strong)YHPetData *petData;
@property (nonatomic,assign)BOOL isupdate;
@end

@implementation YHAddPetInfoVC
#pragma mark - vc live cycle
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
        [self initDataSource];
        [self registerNotification];
    }
    return self;
}

-(instancetype)initWithPetData:(nullable YHPetData*)petData
{
    if (self = [super init]) {
        self.petData = petData;
        if (petData) {
            self.isupdate = YES;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self setupDataSourceWithPetData:self.petData];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - override
-(void)initNavigationBar
{
    [super initNavigationBar];
    [self createNavigationItems];
    [self setNavBarTitle:[self getNavigationTitle]];
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

-(YHTextInputView *)inputView
{
    if (!_inputView) {
        _inputView = [[YHTextInputView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 53)];
        _inputView.backgroundColor = [UIColor whiteColor];
        _inputView.delegate = self;
    }
    return _inputView;
}

-(YHUIBasePickView *)pickView
{
    if (!_pickView) {
        _pickView = [[YHUIPickView alloc] initWithFrame:self.view.bounds dataSource:@[@[@"黑",@"白",@"黄",@"黄白",@"黑白"]]];
    }
    return _pickView;
}

-(YHUIDatePickView *)dataPickView
{
    if (!_dataPickView) {
        _dataPickView = [[YHUIDatePickView alloc] initWithFrame:self.view.bounds];
    }
    return _dataPickView;
}

-(YHAddPetInfoOP *)addPetInfoOP
{
    if (!_addPetInfoOP) {
        _addPetInfoOP = [[YHAddPetInfoOP alloc] init];
    }
    return _addPetInfoOP;
}

-(YHFileUploadOP *)fileUploadOP
{
    if (!_fileUploadOP) {
        _fileUploadOP = [[YHFileUploadOP alloc] init];
    }
    return _fileUploadOP;
}

#pragma mark - private
-(void)initDataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
        YHInfoItemData *nameItem = [[YHInfoItemData alloc] init];
        nameItem.title = @"昵称:";
        nameItem.placeholder = @"点击输入";
        nameItem.tag = ADD_INFO_NAME_TAG;
        [_dataSource addObject:nameItem];
        
        YHInfoItemData *posterItem = [[YHInfoItemData alloc] init];
        posterItem.title = @"头像:";
        posterItem.placeholder = @"点击上传";
        posterItem.tag = ADD_INFO_POSTER_TAG;
        [_dataSource addObject:posterItem];
        
        YHInfoItemData *birthdayItem = [[YHInfoItemData alloc] init];
        birthdayItem.title = @"出生日期:";
        birthdayItem.placeholder = @"点击选择";
        birthdayItem.tag = ADD_INFO_BIRTHDAY_TAG;
        [_dataSource addObject:birthdayItem];
        
        YHInfoItemData *colorItem = [[YHInfoItemData alloc] init];
        colorItem.title = @"花色:";
        colorItem.placeholder = @"点击输入";
        colorItem.tag = ADD_INFO_COLOR_TAG;
        [_dataSource addObject:colorItem];
        
        YHInfoItemData *varietyItem = [[YHInfoItemData alloc] init];
        varietyItem.title = @"品种:";
        varietyItem.placeholder = @"点击选择";
        varietyItem.tag = ADD_INFO_VARIET_TAG;
        [_dataSource addObject:varietyItem];
        
        YHInfoItemData *sexItem = [[YHInfoItemData alloc] init];
        sexItem.title = @"性别:";
        sexItem.placeholder = @"点击选择";
        sexItem.tag = ADD_INFO_SEX_TAG;
        [_dataSource addObject:sexItem];
        
        YHInfoItemData *remarkItem = [[YHInfoItemData alloc] init];
        remarkItem.title = @"备注";
        remarkItem.placeholder = @"你想对小主说些什么";
        remarkItem.tag = ADD_INFO_REMARK_TAG;
        [_dataSource addObject:remarkItem];
    }
}

-(void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDismiss:) name:UIKeyboardWillHideNotification object:nil];
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

-(void)modifyNickName:(NSString*)rename
{
    YHInfoItemData *item = [_dataSource firstObject];
    item.intro = rename;
    [_tableView reloadData];
}

-(void)modifyBodyColor:(NSString*)colorStr
{
    YHInfoItemData *item = [self cellItemDataByTag:ADD_INFO_COLOR_TAG];
    item.intro = colorStr;
    [_tableView reloadData];
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

-(void)configCell:(YHInfoTextTableCell*)cell indexPath:(NSIndexPath*)indexPath
{
    YHInfoItemData *item = [_dataSource safe_objectAtIndex:indexPath.row];
    if (__isStrEmpty(item.intro)) {
        [cell refreshTitle:item.title intro:item.placeholder poster:item.imgurl];
    }else{
        [cell refreshTitle:item.title intro:item.intro poster:item.imgurl];
    }
}

-(void)configRemarkCell:(YHTextViewTableCell*)cell indexPath:(NSIndexPath*)indexPath
{
    YHInfoItemData *item = [_dataSource safe_objectAtIndex:indexPath.row];
    [cell refreshText:item.intro placeholder:item.placeholder];
}

-(void)showPhotoSelectView
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"头像"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showPhotoOrCamera:@"photo"];
    }];
    [alertController addAction:moreAction];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self showPhotoOrCamera:@"camera"];
        }];
        [alertController addAction:OKAction];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)showPhotoOrCamera:(NSString*)type
{
    UIImagePickerController *imagePickerVc = [[UIImagePickerController alloc] init];
    imagePickerVc.delegate = self;
    if ([type isEqualToString:@"photo"]) {
        imagePickerVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }else{
        imagePickerVc.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(NSString*)getNavigationTitle
{
    NSString* title = @"添加";
    if (!_petData) {
        title = @"添加";
    }else {
        title = @"修改";
    }
    return title;
}

-(void)setupDataSourceWithPetData:(YHPetData*)data
{
    for (YHInfoItemData *item in self.dataSource) {
        if([item.tag isEqualToString:ADD_INFO_NAME_TAG]){
            item.intro = data.name;
        }else if ([item.tag isEqualToString:ADD_INFO_POSTER_TAG]){
            item.imgurl = data.img_url;
        }else if ([item.tag isEqualToString:ADD_INFO_BIRTHDAY_TAG]){
            item.intro = data.birthday;
        }else if ([item.tag isEqualToString:ADD_INFO_COLOR_TAG]){
            item.intro = data.hair_color;
        }else if ([item.tag isEqualToString:ADD_INFO_SEX_TAG]){
            item.intro = data.sex;
        }else if ([item.tag isEqualToString:ADD_INFO_REMARK_TAG]){
            item.intro = data.remark;
        }
    }
    [self.tableView reloadData];
}

-(void)saveAndUpdatePetInfo
{
    if (!self.petData) {
        self.petData = [[YHPetData alloc] init];
    }
    for (YHInfoItemData *item in self.dataSource) {
        if([item.tag isEqualToString:ADD_INFO_NAME_TAG]){
            self.petData.name = item.intro;
        }else if ([item.tag isEqualToString:ADD_INFO_POSTER_TAG]){
            self.petData.img_url = item.imgurl;
        }else if ([item.tag isEqualToString:ADD_INFO_BIRTHDAY_TAG]){
            self.petData.birthday = item.intro;
        }else if ([item.tag isEqualToString:ADD_INFO_VARIET_TAG]){
            self.petData.variety = item.intro;
        }else if ([item.tag isEqualToString:ADD_INFO_COLOR_TAG]){
            self.petData.hair_color = item.intro;
        }else if ([item.tag isEqualToString:ADD_INFO_SEX_TAG]){
            self.petData.sex = item.intro;
        }else if ([item.tag isEqualToString:ADD_INFO_REMARK_TAG]){
            self.petData.remark = item.intro;
        }
    }
    
    [YHShareUtil showLoadingOnView:self.view];
    if (self.isupdate) {
        [self.addPetInfoOP updatePetInfo:self.petData completeBlock:^(NSError *error) {
            [self dealFinishEvent];
            [YHShareUtil hideLoadingOnView:self.view];
            [YHShareUtil showToast:@"更新成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
    }else{
        [self.addPetInfoOP savePetInfo:self.petData completeBlock:^(NSError *error) {
            [self dealFinishEvent];
            [YHShareUtil hideLoadingOnView:self.view];
            [YHShareUtil showToast:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

-(void)uploadImage:(UIImage*)image
{
    NSData *imageData = UIImageJPEGRepresentation(image,1);
    NSMutableArray *fileArr = [NSMutableArray array];
    YHNetWorkToolsFileModel *fileItem = [[YHNetWorkToolsFileModel alloc] init];
    fileItem.name = [[NSString stringWithFormat:@"%lf%u%d",[[NSDate date] timeIntervalSince1970],arc4random(),0] md5];
    fileItem.data = imageData;
    fileItem.type = @"jpeg";
    [fileArr addObject:fileItem];
    
    [YHShareUtil showLoadingOnView:self.view text:@"上传中"];
    weakify(self);
    [self.fileUploadOP uploadFiles:[fileArr copy] url:@"http://cat.yaohr.com/admin/sys_upload?action=upload_pub" param:nil completeBlock:^(YHFileUploadRespData *fileResp) {
        strongify(self);
        [YHShareUtil hideLoadingOnView:self.view];
        YHUploadFileItem *item = [fileResp.result firstObject];
        YHInfoItemData *info = [self.dataSource safe_objectAtIndex:1];
        info.imgurl = item.onLineUrl;
        [self refreshPoster:image];
    } errorBlock:^(NSError *error) {
        strongify(self);
        [YHShareUtil hideLoadingOnView:self.view];
        [YHShareUtil showToast:@"上传失败"];
    }];
}

-(void)refreshPoster:(UIImage*)image
{
    YHInfoTextTableCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell.posterImageView.image = image;
    cell.posterImageView.hidden = NO;
    cell.introLabel.hidden = YES;
}

-(void)dealFinishEvent
{
    if ([_delegate respondsToSelector:@selector(didUpdatePetInfoVC:)]) {
        [_delegate didUpdatePetInfoVC:self];
    }
}

#pragma mark - Button Action
-(void)finishButtonClick:(id)sender
{
    [self saveAndUpdatePetInfo];
}

-(void)dismissInput:(id)sender
{
    [self.inputView dismiss];
}

#pragma mark - tableViewDelegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = [_dataSource count];
    return number;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHInfoItemData *item = [_dataSource safe_objectAtIndex:indexPath.row];
    CGFloat height = YHInfoTextTableCellHeight;
    if ([item.tag isEqualToString:ADD_INFO_REMARK_TAG]) {
        height = 200.0f;
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identify = @"cellid";
    static NSString * remarkIdentify = @"remarkIdentifyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    YHInfoItemData *item = [_dataSource safe_objectAtIndex:indexPath.row];
    if ([item.tag isEqualToString:ADD_INFO_REMARK_TAG]) {
        if (cell == nil) {
            cell = [[YHTextViewTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:remarkIdentify];
            [(YHTextViewTableCell*)cell setDelegate:self];
        }
        [self configRemarkCell:(YHTextViewTableCell*)cell indexPath:indexPath];
    }else{
        if (cell == nil) {
            cell = [[YHInfoTextTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        [self configCell:(YHInfoTextTableCell*)cell indexPath:indexPath];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSIndexPath *cellIndex = indexPath;
    YHInfoItemData *itemData = [_dataSource safe_objectAtIndex:indexPath.row];
    if ([itemData.tag isEqualToString:ADD_INFO_NAME_TAG]) {
        [self showInputViewWithTag:ADD_INFO_NAME_TAG];
    }else if ([itemData.tag isEqualToString:ADD_INFO_POSTER_TAG]){
        [self showPhotoSelectView];
    }else if ([itemData.tag isEqualToString:ADD_INFO_BIRTHDAY_TAG]){
        [self.dataPickView show:self.view.window didSelectedItemIndex:^(YHUIBasePickView *pickView,NSString *text,NSIndexPath *indexPath) {
            YHInfoItemData *item = [_dataSource safe_objectAtIndex:cellIndex.row];
            item.intro = text;
            [self.tableView reloadData];
        }];
    }else if ([itemData.tag isEqualToString:ADD_INFO_VARIET_TAG]){
        [self.pickView reloadData:@[@[@"暹罗猫",@"布偶猫",@"苏格兰折耳猫",@"波斯猫",@"俄罗斯蓝猫",@"缅因猫",@"新加坡猫",@"索马里猫",@"土耳其梵猫",@"美国短尾猫",@"西伯利亚森林猫",@"巴厘猫",@"土耳其安哥拉猫",@"东奇尼猫"]]];
        [self.pickView show:self.view.window didSelectedItemIndex:^(YHUIBasePickView *pickView, NSString *text, NSIndexPath *indexPath) {
            YHInfoItemData *item = [_dataSource safe_objectAtIndex:cellIndex.row];
            item.intro = text;
            [self.tableView reloadData];
        }];
    }else if ([itemData.tag isEqualToString:ADD_INFO_COLOR_TAG]){
        [self showInputViewWithTag:ADD_INFO_COLOR_TAG];
    }else if ([itemData.tag isEqualToString:ADD_INFO_SEX_TAG]){
        [self.pickView reloadData:@[@[@"公",@"母"]]];
        [self.pickView show:self.view.window didSelectedItemIndex:^(YHUIBasePickView *pickView, NSString *text, NSIndexPath *indexPath) {
            YHInfoItemData *item = [_dataSource safe_objectAtIndex:cellIndex.row];
            item.intro = text;
            [self.tableView reloadData];
        }];
    }
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

#pragma mark - YHTextInputViewDelegate
- (void)sendBtnClick:(YHTextInputView *)inputView text:(NSString *)text
{
    if ([self isIllegalNickName:text]) {
        return;
    }
    if ([inputView.tagStr isEqualToString:ADD_INFO_NAME_TAG]) {
        [self modifyNickName:text];
    }else if ([inputView.tagStr isEqualToString:ADD_INFO_COLOR_TAG]){
        [self modifyBodyColor:text];
    }
    [inputView clearText];
}

#pragma mark - YHTextViewTableCellDelegate
-(void)textViewTableCell:(YHTextViewTableCell*)cell didChangeText:(NSString*)text
{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    YHInfoItemData *item = [_dataSource safe_objectAtIndex:indexPath.row];
    item.intro = text;
}

#pragma mark -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //把Modal出来的imagePickerController弹出
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 获取用户选择照片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self uploadImage:image];
}
@end
