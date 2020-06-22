//
//  YHImmueHistoryOP.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/31.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHImmueHistoryOP.h"

@implementation YHPetImmueHistoryPageData
@end

@implementation YHPetWeightHistoryPageData
@end

@implementation YHAddPetHistoryData
@end

@implementation YHDelPetHistoryData
@end

@implementation YHImmueHistoryOP
-(void)request:(NSDictionary*)param type:(NSString*)type completeBlock:(void(^)(YHBaseData *data))completeBlcok errorBlock:(void(^)(NSError* error))errorBlock
{
    [YHNetWorkTools netRequestGetHost:YHNetWork_Host path:@"admin/biz_action_event?action=query" param:param completeBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *err;
        YHBaseData *data;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([type isEqualToString:@"weight"]) {
                data = [[YHPetWeightHistoryPageData alloc] initWithDictionary:responseObject error:&err];
            }else{
                data = [[YHPetImmueHistoryPageData alloc] initWithDictionary:responseObject error:&err];
            }
            if (data.success.boolValue) {
                completeBlcok(data);
            }else{
                err = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{@"error":@"服务端error"}];
                errorBlock(err);
            }
        }else{
            err = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{@"error":@"非json数据"}];
            errorBlock(err);
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        errorBlock(error);
    }];
}

-(void)addHistoryRequest:(NSDictionary*)param completeBlock:(void(^)(YHAddPetHistoryData* data))completeBlcok errorBlock:(void(^)(NSError* error))errorBlock
{
    [YHNetWorkTools netRequestPostHost:YHNetWork_Host path:@"admin/biz_action_event?action=save" param:param completeBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *err;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            YHAddPetHistoryData *data = [[YHAddPetHistoryData alloc] initWithDictionary:responseObject error:&err];
            if (data.success.boolValue) {
                completeBlcok(data);
            }else{
                errorBlock(err);
            }
        }else{
            err = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{@"error":@"非json数据"}];
            errorBlock(err);
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        errorBlock(error);
    }];
}

-(void)deleteHistoryRequest:(NSDictionary*)param completeBlock:(void(^)(YHDelPetHistoryData* data))completeBlcok errorBlock:(void(^)(NSError* error))errorBlock
{
    [YHNetWorkTools netRequestPostHost:YHNetWork_Host path:@"admin/biz_action_event?action=del" param:param completeBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *err;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            YHDelPetHistoryData *data = [[YHDelPetHistoryData alloc] initWithDictionary:responseObject error:&err];
            if (data.success.boolValue) {
                completeBlcok(data);
            }else{
                errorBlock(err);
            }
        }else{
            err = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{@"error":@"非json数据"}];
            errorBlock(err);
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        errorBlock(error);
    }];
}
@end
