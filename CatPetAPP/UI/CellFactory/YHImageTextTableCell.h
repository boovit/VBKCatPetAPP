//
//  YHImageTextTableCell.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/2.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHBaseTableViewCell.h"

#define YHImageTextTableCellHeight (60)

//左图 右文(两行)
@interface YHImageTextTableCell : YHBaseTableViewCell
@property(nonatomic,strong)UIImageView *posterImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *subTitleLabel;

-(void)refreshPoster:(NSString*)imgUrl title:(NSString*)title subTitle:(NSString*)subTitle;
@end
