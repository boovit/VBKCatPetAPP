//
//  YHUIPickView.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/16.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHUIPickView.h"
#import "NSArray+Safe.h"

@interface YHUIPickView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIPickerView *pickView;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end

@implementation YHUIPickView
-(instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray*)dataSource
{
    if (self = [super initWithFrame:frame]) {
        self.dataSource = dataSource;
        self.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self masLayoutSubview];
    }
    return self;
}

-(UIPickerView *)pickView
{
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] init];
        _pickView.backgroundColor = [UIColor whiteColor];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        [self addSubview:_pickView];
    }
    return _pickView;
}

#pragma mark - public
-(void)reloadData:(NSArray*)data
{
    self.dataSource = data;
    self.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_pickView reloadAllComponents];
}

#pragma mark - private
-(void)masLayoutSubview
{
    [self.pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.width.equalTo(self);
        make.height.equalTo(@160);
    }];
    
    [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.pickView.mas_top);
        make.width.equalTo(self);
        make.height.equalTo(@50);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.height.equalTo(self.controlView);
    }];
    
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.height.equalTo(self.controlView);
    }];
}

-(void)dissmiss
{
    [self removeFromSuperview];
}

#pragma mark - Action
-(void)finishButtonClick:(id)sender
{
    if (self.selectedBlock && self.indexPath) {
        NSArray *rowArray = [self.dataSource objectAtIndex:_indexPath.section];
        NSString *string = [rowArray safe_objectAtIndex:_indexPath.row];
        self.selectedBlock(self, string, self.indexPath);
    }
    [self dissmiss];
}

-(void)cancelButtonClick:(id)sender
{
    [self dissmiss];
}

#pragma mark - YHUIPickViewDelegate & UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSInteger number = [self.dataSource count];
    return number;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger number = [(NSArray*)[self.dataSource objectAtIndex:component] count];
    return number;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *rowArray = [self.dataSource objectAtIndex:component];
    NSString *string = [rowArray objectAtIndex:row];
    return string;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.selectedBlock) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:component];
        self.indexPath = indexPath;
    }
}
@end
