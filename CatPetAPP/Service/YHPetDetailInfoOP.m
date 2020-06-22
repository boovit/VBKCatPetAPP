//
//  YHPetDetailInfoOP.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/27.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPetDetailInfoOP.h"

#import "NSMutableDictionary+Safe.h"
#import "YHPassportManager.h"

@implementation YHPetImmuneItem
@end

@implementation YHPetDataExtDetail
@end

@implementation YHPetDetailInfoData
-(YHPetDataExtDetail*)getPetDetailInfo
{
    return [self.result firstObject];
}
@end

@implementation YHPetDetailInfoOP
-(void)request:(NSDictionary*)param completeBlock:(void(^)(YHPetDetailInfoData* data))completeBlcok errorBlock:(void(^)(NSError* error))errorBlock
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic addEntriesFromDictionary:param];
    [YHNetWorkTools netRequestGetHost:YHNetWork_Host path:@"admin/biz_cat_info?action=query" param:dic completeBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *err;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            YHPetDetailInfoData *data = [[YHPetDetailInfoData alloc] initWithDictionary:responseObject error:&err];
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
