//
//  YHTextViewTableCell.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/25.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHBaseTableViewCell.h"

@class YHTextViewTableCell;
@protocol YHTextViewTableCellDelegate<NSObject>
-(void)textViewTableCell:(YHTextViewTableCell*)cell didChangeText:(NSString*)text;
@end

@interface YHTextViewTableCell : YHBaseTableViewCell
@property(nonatomic,weak)id<YHTextViewTableCellDelegate> delegate;
-(void)refreshText:(NSString*)text placeholder:(NSString*)placeholder;
@end
