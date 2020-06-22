//
//  YHNetWorkTools+ParameterExt.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/4/26.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHNetWorkTools+ParameterExt.h"
#import "NSMutableDictionary+Safe.h"
#import "YHPassportManager.h"

@implementation YHNetWorkTools (ParameterExt)
+(NSDictionary*)appendUrlParameterExt:(NSDictionary*)param
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:param];
    [params safe_setObject:[YHPassportManager shareInstance].userData.sessionID forKey:@"sessionID"];
    [params safe_setObject:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] forKey:@"t"];
    return [params copy];
}

+(NSDictionary*)appendBodyParameterExt:(NSDictionary*)param
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:param];
    return [params copy];
}
@end
