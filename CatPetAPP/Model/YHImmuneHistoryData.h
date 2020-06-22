//
//  YHImmuneHistoryData.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/13.
//  Copyright © 2018年 yaohr. All rights reserved.
//
//  免疫历史信息

#import "YHBaseData.h"

@interface YHImmuneHistoryData : YHBaseData
@property(nonatomic,strong)NSNumber<Optional> *_id;            //id
@property(nonatomic,copy)NSString<Optional>* last_record;      //免疫日期
@end

@interface YHPetWeightHistoryData : YHImmuneHistoryData;
@property (nonatomic,copy)NSNumber<Optional>* weight;          //单位为g
@end
