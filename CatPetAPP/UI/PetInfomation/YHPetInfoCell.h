//
//  YHPetInfoCell.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/26.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHBaseTableViewCell.h"

@protocol YHPetInfoCellDelegate <NSObject>
-(void)didClickQRCodeOnCell:(UITableViewCell*)cell;
@end

#define YHPetInfoCellHeight 150

@interface YHPetInfoCell : YHBaseTableViewCell
@property(nonatomic, weak )id<YHPetInfoCellDelegate> delegate;
@property(nonatomic,strong)UIImageView *posterImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *subLabel;
@property(nonatomic,strong)UILabel *sexLabel;
@property(nonatomic,strong)UILabel *birthdayLabel;
@property(nonatomic,strong)UILabel *ageLabel;
@end
