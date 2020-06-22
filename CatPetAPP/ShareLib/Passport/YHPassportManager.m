//
//  YHPassportManager.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/4/12.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPassportManager.h"
#import "YHNetWorkTools.h"
#import "NSMutableDictionary+Safe.h"
#import "NSStringIsEmpty.h"

NSString *const kYHPassportUserSessionID = @"kYHPassportUserSessionID";
NSString *const kNotification_PassportManager_Login = @"kNotification_PassportManager_Login";
NSString *const kNotification_PassportManager_Logout = @"kNotification_PassportManager_Logout";

static YHPassportManager *_instance;
@interface YHPassportManager()
@end

@implementation YHPassportManager
+(instancetype)shareInstance
{
    return [[self alloc] init];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

-(YHLoginRespResultData *)userData
{
    if (!_userData) {
        _userData = [[YHLoginRespResultData alloc] init];
        _userData.sessionID = [self getSessionID];
    }
    return _userData;
}

#pragma mark -- public
-(void)checkLogin:(NSDictionary*)params
{
    self.userData.sessionID = [self getSessionID];
    //网络请求校验session
    [self requestCheckSession:params];
}

-(void)loginWithUserData:(YHPPUserData*)data completeBlock:(void(^)(NSError *error))completeBlcok;
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params safe_setObject:data.username forKey:@"username"];
    [params safe_setObject:data.password forKey:@"password"];
    [params safe_setObject:data.device_token forKey:@"apnstoken"];
    [YHNetWorkTools netRequestPostHost:YHNetWork_Host path:@"admin/index?action=userLogin" param:params completeBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *error = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            YHLoginRespData *data = [[YHLoginRespData alloc] initWithDictionary:responseObject error:&error];
            if (error==nil) {
                self.userData = data.result;
                [self saveSessionID:self.userData.sessionID];
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_PassportManager_Login object:nil];
            }
        }
        completeBlcok(error);
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        completeBlcok(error);
    }];
}

-(void)logout
{
    [self requestLogout];
}

-(BOOL)isLogin
{
    return self.userData.user;
}

#pragma mark - private

-(void)requestCheckSession:(NSDictionary*)dic
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params addEntriesFromDictionary:dic];
    [YHNetWorkTools netRequestPostHost:YHNetWork_Host path:@"admin/index?action=check" param:params completeBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *error = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            YHLoginRespData *data = [[YHLoginRespData alloc] initWithDictionary:responseObject error:&error];
            if (error==nil) {
                self.userData = data.result;
                [self saveSessionID:self.userData.sessionID];
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_PassportManager_Login object:nil];
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

-(void)requestLogout
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [YHNetWorkTools netRequestPostHost:YHNetWork_Host path:@"admin/index?action=userLogout" param:params completeBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *error = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            YHLogoutRespData *data = [[YHLogoutRespData alloc] initWithDictionary:responseObject error:&error];
            if (error==nil&&data.success) {
                self.userData = nil;
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_PassportManager_Logout object:nil];
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

-(void)saveSessionID:(NSString*)sessionid
{
    if (__isStrNotEmpty(sessionid)) {
        NSUserDefaults *fm = [NSUserDefaults standardUserDefaults];
        [fm setObject:sessionid forKey:kYHPassportUserSessionID];
        [fm synchronize];
    }
}

-(NSString*)getSessionID
{
    NSUserDefaults *fm = [NSUserDefaults standardUserDefaults];
    NSString *seid = [fm objectForKey:kYHPassportUserSessionID];
    return seid;
}
@end
