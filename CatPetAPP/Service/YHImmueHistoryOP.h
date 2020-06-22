//
//  YHImmueHistoryOP.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/31.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHBaseOP.h"
#import "YHBaseData.h"
#import "YHImmuneHistoryData.h"

@protocol YHImmuneHistoryData
@end

@protocol YHPetWeightHistoryData
@end

@interface YHPetImmueHistoryPageData : YHBaseData
@property(nonatomic,strong)NSMutableArray<YHImmuneHistoryData> *result;
@end

@interface YHPetWeightHistoryPageData : YHBaseData
@property(nonatomic,strong)NSMutableArray<YHPetWeightHistoryData> *result;
@end

@interface YHAddPetHistoryData:YHBaseData
@end

@interface YHDelPetHistoryData:YHBaseData
@end

@interface YHImmueHistoryOP : YHBaseOP
-(void)request:(NSDictionary*)param type:(NSString*)type completeBlock:(void(^)(YHBaseData *data))completeBlcok errorBlock:(void(^)(NSError* error))errorBlock;
-(void)addHistoryRequest:(NSDictionary*)param completeBlock:(void(^)(YHAddPetHistoryData* data))completeBlcok errorBlock:(void(^)(NSError* error))errorBlock;
-(void)deleteHistoryRequest:(NSDictionary*)param completeBlock:(void(^)(YHDelPetHistoryData* data))completeBlcok errorBlock:(void(^)(NSError* error))errorBlock;
@end
