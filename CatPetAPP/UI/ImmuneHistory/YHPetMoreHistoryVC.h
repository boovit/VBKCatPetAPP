//
//  YHPetMoreHistoryVC.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/26.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHBaseViewController.h"
#import "YHInfoItemData.h"
#import "YHImmuneHistoryData.h"

@protocol YHPetMoreHistoryVCDelegate <NSObject>
-(void)didFinishMoreHistory:(UIViewController*)vc data:(YHPetWeightHistoryData*)weightData;
@end

@interface YHPetMoreHistoryVC : YHBaseViewController
@property(nonatomic,weak)id<YHPetMoreHistoryVCDelegate> delegate;
-(instancetype)initWithType:(NSString*)type;

-(void)showInputViewWithTag:(NSString*)tag;
-(void)showDatePickViewTag:(NSString*)tag indexPath:(NSIndexPath*)cellIndex;
-(YHInfoItemData*)cellItemDataByTag:(NSString*)tag;
-(void)reloadTableViewIndexPath:(NSIndexPath*)indexPath;
@end
