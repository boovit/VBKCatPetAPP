//
//  YHBaseTableViewCell.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/2.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHBaseTableViewCell.h"

#import "UIColor+HexValue.h"

@implementation YHBaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *selectedColor = [[UIView alloc] init];
        selectedColor.backgroundColor = [UIColor colorWithHexValue:0xf7f7f7];
        self.selectedBackgroundView = selectedColor;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
