//
//  YHDataErrorView.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/13.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHDataErrorView.h"

@interface YHDataErrorView()
@end

@implementation YHDataErrorView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.tipsLab = [[UILabel alloc] init];
    self.tipsLab.font = [UIFont systemFontOfSize:18.0];
    self.tipsLab.textColor = [UIColor grayColor];
    self.tipsLab.text = @"暂无数据";
    [self addSubview:self.tipsLab];
    
    [self masLayoutSubview];
}

-(void)masLayoutSubview
{
    [self.tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

-(void)show:(UIView*)view
{
    [view addSubview:self];
}

-(void)dissmiss
{
    [self removeFromSuperview];
}
@end
