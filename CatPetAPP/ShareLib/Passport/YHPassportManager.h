//
//  YHPassportManager.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/4/12.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHPPUserData.h"

extern NSString *const kNotification_PassportManager_Login;
extern NSString *const kNotification_PassportManager_Logout;

@interface YHPassportManager : NSObject
@property(nonatomic,strong)YHLoginRespResultData *userData;
+(instancetype)shareInstance;
-(void)loginWithUserData:(YHPPUserData*)data completeBlock:(void(^)(NSError *error))completeBlcok;
-(void)checkLogin:(NSDictionary*)params;
-(void)logout;//退出登录
-(BOOL)isLogin;
@end
