//
//  YHAddPetInfoVC.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/8.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHBaseViewController.h"
#import "YHPetData.h"

@protocol YHAddPetInfoVCDelegate <NSObject>
-(void)didUpdatePetInfoVC:(UIViewController*_Nullable)vc;
@end

@interface YHAddPetInfoVC : YHBaseViewController
@property(nonatomic,weak)id<YHAddPetInfoVCDelegate> delegate;
-(instancetype _Nullable )initWithPetData:(nullable YHPetData*)petData;
@end
