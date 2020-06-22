//
//  YHPetInfoListOP.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/20.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHBaseOP.h"
#import "YHPetData.h"

@protocol YHPetData
@end
@interface YHPetInfoListData : YHBaseData
@property(nonatomic,strong)NSMutableArray<YHPetData>* result;
@end

@interface YHPetDeleteRespData : YHBaseData
@end

@interface YHPetInfoListOP : YHBaseOP
-(void)request:(NSDictionary*)param completeBlock:(void(^)(YHPetInfoListData* data))completeBlcok errorBlock:(void(^)(NSError* error))errorBlock;
-(void)deletePetInfo:(NSDictionary*)param completeBlock:(void(^)(void))completeBlcok errorBlock:(void(^)(NSError* error))errorBlock;
@end
