//
//  YHUIDatePickView.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/16.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHUIDatePickView.h"

@interface YHUIDatePickView()
@property(nonatomic,strong)UIDatePicker *dataPicker;
@end

@implementation YHUIDatePickView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self masLayoutSubview];
    }
    return self;
}

-(UIDatePicker *)dataPicker
{
    if (!_dataPicker) {
        _dataPicker = [[UIDatePicker alloc] init];
        _dataPicker.backgroundColor = [UIColor whiteColor];
        [_dataPicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        [_dataPicker setDatePickerMode:UIDatePickerModeDate];
        [_dataPicker addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
        [self addSubview:_dataPicker];
    }
    return _dataPicker;
}

-(void)finishButtonClick:(id)sender
{
    [super finishButtonClick:sender];
    if (self.selectedBlock) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateString = [dateFormatter stringFromDate:self.dataPicker.date];
        self.selectedBlock(self, currentDateString, nil);
    }
}

#pragma mark - private
-(void)masLayoutSubview
{
    [self.dataPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.width.equalTo(self);
        make.height.equalTo(@160);
    }];
    
    [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.dataPicker.mas_top);
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

#pragma mark - Action
-(void)dateChange:(id)sender
{
    
}
@end
