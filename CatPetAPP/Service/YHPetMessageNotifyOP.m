//
//  YHPetMessageNotifyOP.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/13.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPetMessageNotifyOP.h"

@implementation YHMessageBlockItem
@end

@implementation YHPetMessageNotifyData
@end

@implementation YHPetMessageNotifyOP
-(void)request:(NSDictionary*)param completeBlock:(void(^)(YHPetMessageNotifyData* data))completeBlcok errorBlock:(void(^)(NSError* error))errorBlock
{
    [YHNetWorkTools netRequestGetHost:YHNetWork_Host path:@"admin/biz_cat_info?action=query_message" param:param completeBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *err;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            YHPetMessageNotifyData *data = [[YHPetMessageNotifyData alloc] initWithDictionary:responseObject error:&err];
            completeBlcok(data);
        }else{
            err = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{@"error":@"非json数据"}];
            errorBlock(err);
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        errorBlock(error);
    }];
}
@end
