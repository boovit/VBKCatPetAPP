//
//  YHNetWorkTools.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/9.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHNetWorkTools.h"
#import "NSString+URL.h"

#define YH_UPLOAD_FILE_TYPE_PNG @"png"
#define YH_UPLOAD_FILE_TYPE_JPEG @"jpeg"
#define YH_UPLOAD_FILE_TYPE_JPG @"jpg"
#define YH_UPLOAD_FILE_TYPE_JPE @"jpe"

NSString * const kYHNetWorkToolsNotification_NetError_Login = @"kYHNetWorkToolsNotification_NetError_Login";

@interface YHNetWorkTools ()
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@end

@implementation YHNetWorkTools
- (AFURLSessionManager *)manager
{
    if (_manager==nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

+(instancetype)shareInstance
{
    static YHNetWorkTools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc] init];
    });
    return instance;
}

+(void)netRequestGetUrl:(NSString*)url
                  param:(NSDictionary*)paramDic
          completeBlock:(void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))completeBlock
             errorBlock:(void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))errorBlock
{
    [self debugLog:url];
    AFHTTPSessionManager *manager = [[self shareInstance] manager];
    
    [manager GET:url parameters:[YHNetWorkTools appendUrlParameterExt:paramDic] progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completeBlock) {
            completeBlock(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        error = [self dealWithNetError:error];
        if (errorBlock) {
            errorBlock(task,error);
        }
    }];
}

+(void)netRequestPostUrl:(NSString*)url
                   param:(NSDictionary*)paramDic
           completeBlock:(void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))completeBlock
              errorBlock:(void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))errorBlock
{
    NSDictionary *urldic = [YHNetWorkTools appendUrlParameterExt:nil];
    url = [url stringByAppendedURLParams:urldic keyList:[urldic allKeys]];
    [self debugLog:url];
    AFHTTPSessionManager *manager = [[self shareInstance] manager];
    
    [manager POST:url parameters:[YHNetWorkTools appendBodyParameterExt:paramDic] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completeBlock) {
            completeBlock(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(task,error);
        }
    }];
}

+(void)netRequestPostHost:(NSString*)host path:(NSString*)path param:(NSDictionary*)paramDic completeBlock:(void(^)(NSURLSessionDataTask * task, id responseObject))completeBlock errorBlock:(void(^)(NSURLSessionDataTask * task, NSError * error))errorBlock
{
    NSString *url = [NSString stringWithFormat:@"http://%@/%@",host,path];
    NSDictionary *urldic = [YHNetWorkTools appendUrlParameterExt:nil];
    url = [url stringByAppendedURLParams:urldic keyList:[urldic allKeys]];
    [self debugLog:url];
    AFHTTPSessionManager *manager = [[self shareInstance] manager];
    
    [manager POST:url parameters:[YHNetWorkTools appendBodyParameterExt:paramDic] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completeBlock) {
            completeBlock(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(task,error);
        }
    }];
}

+(void)netUploadFile4Url:(NSString*)url
                   param:(NSDictionary*)paramDic
                    data:(NSData*)data
                    type:(NSString*)type
                fileName:(NSString*)fileName
           progressBlock:(void(^)(float progress))progressBlock
           completeBlock:(void(^)(NSURLSessionDataTask * task, id responseObject))completeBlock
              errorBlock:(void(^)(NSURLSessionDataTask * task, NSError * error))errorBlock
{
    NSDictionary *urldic = [YHNetWorkTools appendUrlParameterExt:nil];
    url = [url stringByAppendedURLParams:urldic keyList:[urldic allKeys]];
    [self debugLog:url];
    AFHTTPSessionManager *manager = [[self shareInstance] manager];
    [manager POST:url parameters:[YHNetWorkTools appendBodyParameterExt:paramDic] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *fileType = @"";
        if ([type isEqualToString:YH_UPLOAD_FILE_TYPE_PNG]) {
            fileType = @"image/png";
        }else if([type isEqualToString:YH_UPLOAD_FILE_TYPE_JPEG] ||
                 [type isEqualToString:YH_UPLOAD_FILE_TYPE_JPG] ||
                 [type isEqualToString:YH_UPLOAD_FILE_TYPE_JPE]){
            fileType = @"image/jpeg";
        }
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:fileType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            float progress = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
            if (progressBlock) {
                progressBlock(progress);
            }
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completeBlock) {
            completeBlock(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(task,error);
        }
    }];
}

+(void)netUploadFile4Url:(NSString*)url param:(NSDictionary*)paramDic files:(NSArray*)files progressBlock:(void(^)(float progress))progressBlock completeBlock:(void(^)(NSURLSessionDataTask * task, id responseObject))completeBlock errorBlock:(void(^)(NSURLSessionDataTask * task, NSError * error))errorBlock;
{
    NSDictionary *urldic = [YHNetWorkTools appendUrlParameterExt:nil];
    url = [url stringByAppendedURLParams:urldic keyList:[urldic allKeys]];
    [self debugLog:url];
    AFHTTPSessionManager *manager = [[self shareInstance] manager];
    [manager POST:url parameters:[YHNetWorkTools appendBodyParameterExt:paramDic] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (YHNetWorkToolsFileModel *file in files) {
            if ([file isKindOfClass:[YHNetWorkToolsFileModel class]]) {
                NSString *fileType = @"";
                NSString *type = file.type;
                if ([type isEqualToString:YH_UPLOAD_FILE_TYPE_PNG]) {
                    fileType = @"image/png";
                }else if([type isEqualToString:YH_UPLOAD_FILE_TYPE_JPEG] ||
                         [type isEqualToString:YH_UPLOAD_FILE_TYPE_JPG] ||
                         [type isEqualToString:YH_UPLOAD_FILE_TYPE_JPE]){
                    fileType = @"image/jpeg";
                }
                [formData appendPartWithFileData:file.data name:@"file" fileName:file.name mimeType:fileType];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            float progress = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
            if (progressBlock) {
                progressBlock(progress);
            }
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completeBlock) {
            completeBlock(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(task,error);
        }
    }];
}

+(void)netRequestGetHost:(NSString*)host
                    path:(NSString*)path
                   param:(NSDictionary*)paramDic
           completeBlock:(void(^)(NSURLSessionDataTask * task, id responseObject))completeBlock
              errorBlock:(void(^)(NSURLSessionDataTask * task, NSError* error))errorBlock
{
    NSString *url = [NSString stringWithFormat:@"http://%@/%@",host,path];
    [self netRequestGetUrl:url param:[YHNetWorkTools appendUrlParameterExt:paramDic] completeBlock:^(NSURLSessionDataTask *task, id responseObject) {
        if (completeBlock) {
            completeBlock(task,responseObject);
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        if (errorBlock) {
            errorBlock(task,error);
        }
    }];
}

+(void)debugLog:(NSString*)log
{
    NSLog(@"handleURL:%@",log);
}

+(NSError*)dealWithNetError:(NSError*)error
{
    if (error) {
        NSString *stateCode = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        NSURL *url = [error.userInfo objectForKey:@"NSErrorFailingURLKey"];
        if ([stateCode containsString:@"503"] && [[url absoluteString] containsString:@"admin/index?action=login"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kYHNetWorkToolsNotification_NetError_Login object:nil];
            
            NSError *customErr = [NSError errorWithDomain:YHNetWork_ErrorDomain code:YHNetWrok_ErrorType_Login_Code userInfo:@{YHNetWrok_ErrorType:YHNetWrok_ErrorType_Login}];
            return customErr;
        }
    }
    return error;
}
@end

@implementation YHNetWorkToolsFileModel
@end
