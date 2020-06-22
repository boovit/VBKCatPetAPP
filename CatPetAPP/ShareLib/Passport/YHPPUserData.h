//
//  YHPPUserData.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/4/14.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface YHPPUserData : JSONModel
@property(nonatomic, copy )NSString<Optional>* sessionID;       //session id
@property(nonatomic, copy )NSString<Optional>* uid;             //用户id
@property(nonatomic, copy )NSString<Optional>* account_id;      //账号id
@property(nonatomic, copy )NSString<Optional>* username;        //用户名
@property(nonatomic, copy )NSString<Optional>* phone_number;    //电话号码
@property(nonatomic, copy )NSString<Optional>* password;        //密码
@property(nonatomic, copy )NSString<Optional>* device_token;    //token;
@end

@interface YHLoginRespResultData : JSONModel
@property(nonatomic, copy )NSString<Optional>* sessionID;
@property(nonatomic,strong)NSMutableArray* author;
@property(nonatomic,strong)YHPPUserData* user;
@end

@interface YHLoginRespData : JSONModel
@property(nonatomic, copy )NSString<Optional>* success;
@property(nonatomic,strong)YHLoginRespResultData* result;
@end

@interface YHLogoutRespData : JSONModel
@property(nonatomic,assign)BOOL success;
@end
