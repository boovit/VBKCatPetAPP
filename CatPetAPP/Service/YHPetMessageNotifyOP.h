//
//  YHPetMessageNotifyOP.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/13.
//  Copyright © 2018年 yaohr. All rights reserved.
//
//  消息提醒列表数据请求

#import <Foundation/Foundation.h>
#import "YHBaseOP.h"

#import "YHBaseData.h"
#import "YHPetMessageData.h"

@protocol YHPetMessageData
@end
@interface YHMessageBlockItem : YHBaseData
@property(nonatomic,copy)NSString* title;
@property(nonatomic,copy)NSString* type;
@property(nonatomic,strong)NSMutableArray<YHPetMessageData>* items;
@end

@protocol YHMessageBlockItem
@end
@interface YHPetMessageNotifyData : YHBaseData
@property(nonatomic,strong)NSMutableArray<YHMessageBlockItem>* result;
@end

@interface YHPetMessageNotifyOP : YHBaseOP
-(void)request:(NSDictionary*)param completeBlock:(void(^)(YHPetMessageNotifyData* data))completeBlcok errorBlock:(void(^)(NSError* error))errorBlock;
@end
