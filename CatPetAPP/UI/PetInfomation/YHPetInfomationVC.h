//
//  YHPetInfomationVC.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/20.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHBaseViewController.h"
#import "YHPetData.h"

@interface YHPetInfomationVC : YHBaseViewController
-(instancetype)initWithPetData:(YHPetData*)petData;
-(instancetype)initWithPetId:(NSUInteger)petID;
@end
