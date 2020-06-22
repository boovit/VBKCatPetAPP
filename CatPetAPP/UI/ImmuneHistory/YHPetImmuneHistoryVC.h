//
//  YHPetImmuneHistoryVC.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/21.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHBaseViewController.h"

@protocol YHPetImmuneHistoryVCDelegate <NSObject>
-(void)didUpdateHistoryVC:(UIViewController*)vc;
@end

@interface YHPetImmuneHistoryVC : YHBaseViewController
@property(nonatomic,weak)id<YHPetImmuneHistoryVCDelegate> delegate;

-(instancetype)initWithPetId:(NSUInteger)petID type:(NSString*)type title:(NSString*)title;

@end
