//
//  YHPetInfoCell.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/26.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPetInfoCell.h"
#import "YHUIUtilMacro.h"

@interface YHPetInfoCell()
@property(nonatomic,strong)UIButton *qrCodeBtn;
@end

@implementation YHPetInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.posterImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_posterImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _titleLabel.textColor = [UIColor colorWithHexValue:0x333333];
        [self.contentView addSubview:_titleLabel];
        
        self.subLabel = [[UILabel alloc] init];
        _subLabel.font = [UIFont systemFontOfSize:14.0];
        _subLabel.textColor = [UIColor colorWithHexValue:0x959595];
        [self.contentView addSubview:_subLabel];
        
        self.birthdayLabel = [[UILabel alloc] init];
        _birthdayLabel.font = [UIFont systemFontOfSize:14.0];
        _birthdayLabel.textColor = [UIColor colorWithHexValue:0x959595];
        [self.contentView addSubview:_birthdayLabel];
        
        self.ageLabel = [[UILabel alloc] init];
        _ageLabel.font = [UIFont systemFontOfSize:14.0];
        _ageLabel.textColor = [UIColor colorWithHexValue:0x959595];
        [self.contentView addSubview:_ageLabel];
        
        self.sexLabel = [[UILabel alloc] init];
        _sexLabel.font = [UIFont systemFontOfSize:14.0];
        _sexLabel.textColor = [UIColor colorWithHexValue:0x959595];
        [self.contentView addSubview:_sexLabel];
        
        self.qrCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qrCodeBtn setImageEdgeInsets:UIEdgeInsetsMake(13, 13, 13, 13)];
        [_qrCodeBtn setImage:[UIImage imageNamed:@"qrcode_icon_150"] forState:UIControlStateNormal];
        [_qrCodeBtn setImage:[UIImage imageNamed:@"qrcode_icon_150"] forState:UIControlStateHighlighted];
        [_qrCodeBtn addTarget:self action:@selector(qrCodeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_qrCodeBtn];
        
        [self masLayoutSubviews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - private
-(void)masLayoutSubviews
{
    [_posterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(@15);
        make.width.height.equalTo(@65);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.posterImageView.mas_right).offset(10);
        make.top.equalTo(self.posterImageView).offset(10);
        make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-10);
    }];
    
    [_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.posterImageView).offset(-10);
    }];
    
    [_birthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.posterImageView.mas_bottom).offset(5);
        make.left.equalTo(self.posterImageView);
    }];
    
    [_ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.birthdayLabel.mas_right).offset(5);
        make.centerY.equalTo(self.birthdayLabel);
    }];
    
    [_sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ageLabel);
        make.left.equalTo(self.ageLabel.mas_right).offset(10);
    }];
    
    [_qrCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.posterImageView.mas_centerY);
        make.right.equalTo(self.contentView).offset(-10);
        make.width.height.equalTo(@60);
    }];
}

#pragma mark - Action
-(void)qrCodeClick:(id)sender
{
    if ([_delegate respondsToSelector:@selector(didClickQRCodeOnCell:)]) {
        [_delegate didClickQRCodeOnCell:self];
    }
}

@end
