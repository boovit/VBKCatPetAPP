//
//  YHPetMessageData.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/13.
//  Copyright © 2018年 yaohr. All rights reserved.
//
//  消息体

#import "YHBaseData.h"
#import "YHPetData.h"

@interface YHPetMessageData : YHPetData
@property(nonatomic,copy)NSString<Optional>* last_record;       //上次免疫时间
@property(nonatomic,strong)NSNumber<Optional>* next_gap;        //下次免疫时间间隔
@end
