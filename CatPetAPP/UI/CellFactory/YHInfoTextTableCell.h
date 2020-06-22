//
//  YHInfoTextTableCell.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/15.
//  Copyright © 2018年 yaohr. All rights reserved.
//
//  资料信息页cell

#import "YHBaseTableViewCell.h"

#define YHInfoTextTableCellHeight (50)

@interface YHInfoTextTableCell : YHBaseTableViewCell
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *introLabel;
@property (nonatomic,strong)UIImageView *posterImageView;//图片上传成功后显示

-(void)refreshTitle:(NSString*)title intro:(NSString*)intro poster:(NSString*)imgUrl;
@end
