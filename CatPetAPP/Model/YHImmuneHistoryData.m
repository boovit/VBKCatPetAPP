//
//  YHImmuneHistoryData.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/13.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHImmuneHistoryData.h"

@implementation YHImmuneHistoryData
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"_id": @"id"}];
}
@end

@implementation YHPetWeightHistoryData
@end
