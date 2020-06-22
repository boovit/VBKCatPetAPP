//
//  YHAddPetInfoOP.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/4/25.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHBaseOP.h"
#import "YHPetData.h"

@interface YHAddPetInfoOP : YHBaseOP
-(void)savePetInfo:(YHPetData*)petData completeBlock:(void(^)(NSError *error))completeBlock;
-(void)updatePetInfo:(YHPetData*)petData completeBlock:(void(^)(NSError *error))completeBlock;
@end
