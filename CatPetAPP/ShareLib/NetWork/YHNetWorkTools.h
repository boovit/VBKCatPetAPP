//
//  YHNetWorkTools.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/9.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "YHNetWorkMacro.h"

extern NSString * const kYHNetWorkToolsNotification_NetError_Login;

@interface YHNetWorkToolsFileModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,strong)NSData *data;
@end

@interface YHNetWorkTools : NSObject
+(instancetype)shareInstance;

+(void)netRequestGetHost:(NSString*)host path:(NSString*)path param:(NSDictionary*)paramDic completeBlock:(void(^)(NSURLSessionDataTask * task, id  responseObject))completeBlock errorBlock:(void(^)(NSURLSessionDataTask * task, NSError * error))errorBlock;
+(void)netRequestGetUrl:(NSString*)url param:(NSDictionary*)paramDic completeBlock:(void(^)(NSURLSessionDataTask * task, id  responseObject))completeBlock errorBlock:(void(^)(NSURLSessionDataTask * task, NSError * error))errorBlock;
+(void)netRequestPostUrl:(NSString*)url param:(NSDictionary*)paramDic completeBlock:(void(^)(NSURLSessionDataTask * task, id responseObject))completeBlock errorBlock:(void(^)(NSURLSessionDataTask * task, NSError * error))errorBlock;
+(void)netRequestPostHost:(NSString*)host path:(NSString*)path param:(NSDictionary*)paramDic completeBlock:(void(^)(NSURLSessionDataTask * task, id responseObject))completeBlock errorBlock:(void(^)(NSURLSessionDataTask * task, NSError * error))errorBlock;

//文件上传
+(void)netUploadFile4Url:(NSString*)url param:(NSDictionary*)paramDic data:(NSData*)data type:(NSString*)type fileName:(NSString*)fileName progressBlock:(void(^)(float progress))progressBlock completeBlock:(void(^)(NSURLSessionDataTask * task, id responseObject))completeBlock errorBlock:(void(^)(NSURLSessionDataTask * task, NSError * error))errorBlock;
+(void)netUploadFile4Url:(NSString*)url param:(NSDictionary*)paramDic files:(NSArray*)files progressBlock:(void(^)(float progress))progressBlock completeBlock:(void(^)(NSURLSessionDataTask * task, id responseObject))completeBlock errorBlock:(void(^)(NSURLSessionDataTask * task, NSError * error))errorBlock;
@end

@interface YHNetWorkTools (ParameterExt)
+(NSDictionary*)appendUrlParameterExt:(NSDictionary*)param;
+(NSDictionary*)appendBodyParameterExt:(NSDictionary*)param;
@end
