//
//  YHPetManagerCardView.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/28.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPetManagerCardView.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "UIColor+HexValue.h"
#import "UIView+YHExtend.h"
#import "YHDesignMacro.h"
#import "YHUIUtilMacro.h"

@interface YHPetManagerCardView ()
@property (nonatomic,strong)UIImageView *posterImageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIView *bottomLine;
@property (nonatomic,strong)YHPetManagerCardViewModel *data;
@end

@implementation YHPetManagerCardView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClicked:)];
        [self addGestureRecognizer:tap];
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    self.posterImageView = [[UIImageView alloc] init];
    [self addSubview:_posterImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:YHDesignMacroFontSize_Title];
    _titleLabel.textColor = [UIColor colorWithHexValue:YHDesignMacroColor_Title];
    [self addSubview:_titleLabel];
    
    self.bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = [UIColor colorWithHexValue:YHDesignMacroColor_Gray];
    [self addSubview:_bottomLine];
    
    [self masLayoutSubviews];
}

-(void)masLayoutSubviews
{
    [_posterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.width.height.equalTo(@80);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.posterImageView);
        make.left.equalTo(self.posterImageView.mas_right).offset(10);
        make.right.lessThanOrEqualTo(self.mas_right).offset(-10);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self);
        make.width.equalTo(self).offset(-20);
        make.height.equalTo(@(SINGLE_PIXEL_HEIGHT));
    }];
    
    [self layoutIfNeeded];
    [_posterImageView cutCircular];
    [_posterImageView setBorderWidth:0.5 color:[UIColor colorWithHexValue:YHDesignMacroColor_Gray]];
}

-(void)didClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectedCardView:)]) {
        [self.delegate didSelectedCardView:self];
    }
}

#pragma mark - public
-(void)reloadWithData:(YHPetManagerCardViewModel*)cardData
{
    self.data = cardData;
    [self.posterImageView sd_setImageWithURL:[NSURL URLWithString:cardData.imgUrl] placeholderImage:[UIImage imageNamed:@"default_150"]];
    self.titleLabel.text = cardData.title;
}
@end

@implementation YHPetManagerCardViewModel
@end
