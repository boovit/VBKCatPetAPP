//
//  YHAddPetInfoOP.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/4/25.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHAddPetInfoOP.h"
#import "NSMutableDictionary+Safe.h"
#import "YHNetWorkTools.h"
#import "YHPassportManager.h"

@implementation YHAddPetInfoOP
-(void)savePetInfo:(YHPetData*)petData completeBlock:(void(^)(NSError *error))completeBlock
{
    NSDictionary *dic = [self assemblePetInfo:petData];
    [YHNetWorkTools netRequestPostHost:YHNetWork_Host path:@"admin/biz_cat_info?action=save" param:dic completeBlock:^(NSURLSessionDataTask *task, id responseObject) {
        completeBlock(nil);
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        completeBlock(error);
    }];
}

-(void)updatePetInfo:(YHPetData*)petData completeBlock:(void(^)(NSError *error))completeBlock
{
    NSDictionary *dic = [self assemblePetInfo:petData];
    [YHNetWorkTools netRequestPostHost:YHNetWork_Host path:@"admin/biz_cat_info?action=update" param:dic completeBlock:^(NSURLSessionDataTask *task, id responseObject) {
        completeBlock(nil);
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        completeBlock(error);
    }];
}

-(NSDictionary*)assemblePetInfo:(YHPetData*)petData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic safe_setObject:petData.name forKey:@"name"];
    [dic safe_setObject:petData.img_url forKey:@"img_url"];
    [dic safe_setObject:petData.birthday forKey:@"birthday"];
    [dic safe_setObject:petData.sex forKey:@"sex"];
    [dic safe_setObject:petData.variety forKey:@"variety"];
    [dic safe_setObject:petData.hair_color forKey:@"hair_color"];
    [dic safe_setObject:petData._id forKey:@"id"];
    [dic safe_setObject:petData.remark forKey:@"remark"];
    return [dic copy];
}
@end
