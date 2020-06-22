//
//  YHNotificationHelper.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/14.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHNotificationHelper : NSObject
+(void)clearNotificationBadge;
+(void)updateDeviceToken:(NSString*)token;
+(NSString*)getCacheToken;
@end
