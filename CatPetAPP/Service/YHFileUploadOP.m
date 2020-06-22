//
//  YHFileUploadOP.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/15.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHFileUploadOP.h"

@implementation YHFileUploadOP
-(void)uploadFiles:(NSArray*)files url:(NSString *)url param:(NSDictionary *)param completeBlock:(void (^)(YHFileUploadRespData *))completeBlock errorBlock:(void (^)(NSError *))errorBlock
{
    [YHNetWorkTools netUploadFile4Url:url param:param files:files progressBlock:^(float progress) {
        
    } completeBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *err;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            YHFileUploadRespData *data = [[YHFileUploadRespData alloc] initWithDictionary:responseObject error:&err];
            if (completeBlock) {
                completeBlock(data);
            }
        }else{
            err = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{@"error":@"非json数据"}];
            if (errorBlock) {
                errorBlock(err);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}
@end

@implementation YHFileUploadRespData
@end

@implementation YHUploadFileItem
@end

