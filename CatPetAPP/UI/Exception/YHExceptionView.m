//
//  YHExceptionView.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/13.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHExceptionView.h"
#import "YHNetworkErrorView.h"
#import "YHDataErrorView.h"

#import "YHNetWorkTools+NetStatus.h"

@interface YHExceptionView()
@property(nonatomic,strong)YHNetworkErrorView *networkView;
@property(nonatomic,strong)YHDataErrorView *nullDataView;
@end

@implementation YHExceptionView
-(instancetype)initWithFrame:(CGRect)frame type:(YHExceptionType)type
{
    if (self=[super initWithFrame:frame]) {
        [self createView4type:type];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dissmiss) name:kNotification_NetworkChangeWifi object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dissmiss) name:kNotification_NetworkChangeMobile object:nil];
    }
    return self;
}

-(void)createView4type:(YHExceptionType)type
{
    switch (type) {
        case YHExceptionView_NullData:
        {
            [self nullDataView];
        }
            break;
        case YHExceptionView_Network:
        {
            [self networkView];
        }
            break;
        default:
            break;
    }
}

-(void)show:(UIView*)view
{
    [view addSubview:self];
}

-(void)dissmiss
{
    [self removeFromSuperview];
}

-(YHNetworkErrorView *)networkView
{
    if (!_networkView) {
        _networkView = [[YHNetworkErrorView alloc] initWithFrame:self.frame];
        [_networkView show:self];
    }
    return _networkView;
}

-(YHDataErrorView *)nullDataView
{
    if (!_nullDataView) {
        _nullDataView = [[YHDataErrorView alloc] initWithFrame:self.frame];
        [_nullDataView show:self];
    }
    return _nullDataView;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
