//
//  YHPetDetailInfoOP.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/27.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHBaseOP.h"

#import "YHBaseData.h"
#import "YHPetData.h"
#import "YHImmuneHistoryData.h"

@protocol YHImmuneHistoryData
@end

@interface YHPetImmuneItem : YHBaseData
@property(nonatomic, copy )NSString<Optional> *title;
@property(nonatomic, copy )NSString<Optional> *type;
@property(nonatomic,strong)NSMutableArray<YHImmuneHistoryData,Optional> *dates;
@end

@protocol YHPetImmuneItem
@end

@interface YHPetDataExtDetail : YHPetData
@property(nonatomic,strong)NSMutableArray<YHPetImmuneItem> *action_event;
@end

@protocol YHPetDataExtDetail
@end
@interface YHPetDetailInfoData : YHBaseData
@property(nonatomic,strong)NSMutableArray<YHPetDataExtDetail> *result;
-(YHPetDataExtDetail*)getPetDetailInfo;
@end

@interface YHPetDetailInfoOP : YHBaseOP
-(void)request:(NSDictionary*)param completeBlock:(void(^)(YHPetDetailInfoData* data))completeBlcok errorBlock:(void(^)(NSError* error))errorBlock;
@end
