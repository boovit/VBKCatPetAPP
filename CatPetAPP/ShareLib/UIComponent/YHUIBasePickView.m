//
//  YHUIBasePickView.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/18.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHUIBasePickView.h"

@implementation YHUIBasePickView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = YHUIShadowColor;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButtonClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(UIView *)controlView
{
    if (!_controlView) {
        _controlView = [[UIView alloc] init];
        _controlView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_controlView];
    }
    return _controlView;
}

-(UIButton *)finishButton
{
    if (!_finishButton) {
        _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_finishButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
        [_finishButton addTarget:self action:@selector(finishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.controlView addSubview:_finishButton];
    }
    return _finishButton;
}

-(UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.controlView addSubview:_cancelButton];
    }
    return _cancelButton;
}

-(void)finishButtonClick:(id)sender
{
    [self removeFromSuperview];
}

-(void)cancelButtonClick:(id)sender
{
    [self removeFromSuperview];
}

-(void)reloadData:(NSArray*)data
{
    
}
-(void)show:(UIView*)superView didSelectedItemIndex:(void(^)(YHUIBasePickView *pickView,NSString *text,NSIndexPath *indexPath))selectedBlock
{
    [superView addSubview:self];
    self.selectedBlock = selectedBlock;
}
@end
