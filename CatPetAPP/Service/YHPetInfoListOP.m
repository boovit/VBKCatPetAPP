//
//  YHPetInfoListOP.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/20.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPetInfoListOP.h"

@implementation YHPetInfoListData
@end

@implementation YHPetDeleteRespData
@end

@implementation YHPetInfoListOP
-(void)request:(NSDictionary*)param completeBlock:(void(^)(YHPetInfoListData* data))completeBlcok errorBlock:(void(^)(NSError* error))errorBlock
{
    [YHNetWorkTools netRequestGetHost:YHNetWork_Host path:@"admin/biz_cat_info?action=query" param:param completeBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *err;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            YHPetInfoListData *data = [[YHPetInfoListData alloc] initWithDictionary:responseObject error:&err];
            completeBlcok(data);
        }else{
            err = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{@"error":@"非json数据"}];
            errorBlock(err);
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        errorBlock(error);
    }];
}

-(void)deletePetInfo:(NSDictionary*)param completeBlock:(void(^)(void))completeBlcok errorBlock:(void(^)(NSError* error))errorBlock
{
    [YHNetWorkTools netRequestPostHost:YHNetWork_Host path:@"admin/biz_cat_info?action=del" param:param completeBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *err;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            YHPetDeleteRespData *respData = [[YHPetDeleteRespData alloc] initWithDictionary:responseObject error:&err];
            if ([respData.success boolValue]) {
                completeBlcok();
            }else{
                err = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{@"error":@"服务端返回错误"}];
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
