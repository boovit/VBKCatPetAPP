//
//  YHImageTextTableCell.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/2.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHImageTextTableCell.h"

@interface YHImageTextTableCell()
@property(nonatomic,strong)UIView *bottomLine;
@end

@implementation YHImageTextTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.posterImageView = [[UIImageView alloc] init];
        _posterImageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_posterImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        _titleLabel.textColor = [UIColor colorWithHexValue:0x333333];
        [self.contentView addSubview:_titleLabel];
        
        self.subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:14.0];
        _subTitleLabel.textColor = [UIColor colorWithHexValue:0x959595];
        [self.contentView addSubview:_subTitleLabel];
        
        self.bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithHexValue:0xeaeaea];
        [self.contentView addSubview:_bottomLine];
        
        [self masLayoutSubviews];
    }
    return self;
}

-(void)masLayoutSubviews
{
    [_posterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(5);
        make.width.height.equalTo(@45);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.posterImageView.mas_right).offset(5);
        make.top.equalTo(self.posterImageView).offset(2);
    }];
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.lessThanOrEqualTo(self.contentView).offset(-5);
        make.bottom.equalTo(self.posterImageView).offset(-2);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView);
        make.width.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@(SINGLE_PIXEL_HEIGHT));
    }];
}

-(void)refreshPoster:(NSString*)imgUrl title:(NSString*)title subTitle:(NSString*)subTitle
{
    _titleLabel.text = title;
    _subTitleLabel.text = subTitle;
    [_posterImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"default_150"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
