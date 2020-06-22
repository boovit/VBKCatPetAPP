//
//  YHInfoTextTableCell.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/15.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHInfoTextTableCell.h"

#import "NSStringIsEmpty.h"

@interface YHInfoTextTableCell()
@property(nonatomic,strong)UIView *bottomLine;
@end

@implementation YHInfoTextTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHexValue:0x323232];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        self.introLabel = [[UILabel alloc] init];
        _introLabel.textColor = [UIColor colorWithHexValue:0x959595];
        _introLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_introLabel];
        
        self.posterImageView = [[UIImageView alloc] init];
        _posterImageView.hidden = YES;
        [self.contentView addSubview:_posterImageView];
        
        self.bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithHexValue:0xd9d9d9];
        [self.contentView addSubview:_bottomLine];
        
        [self masLayoutSubview];
    }
    return self;
}

-(void)masLayoutSubview
{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
    }];
    
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-20);
        make.left.greaterThanOrEqualTo(self.titleLabel.mas_right);
    }];
    
    [_posterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-20);
        make.width.height.equalTo(@(YHInfoTextTableCellHeight-10));
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.width.equalTo(self.contentView);
        make.height.equalTo(@SINGLE_PIXEL_HEIGHT);
    }];
}

-(void)refreshTitle:(NSString*)title intro:(NSString*)intro poster:(NSString*)imgUrl
{
    _titleLabel.text = title;
    _introLabel.text = intro;
    if(__isStrNotEmpty(imgUrl)){
        _introLabel.hidden = YES;
        _posterImageView.hidden = NO;
        [_posterImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"default_150"]];
    }else{
        _introLabel.hidden = NO;
        _posterImageView.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
