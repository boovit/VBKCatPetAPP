//
//  YHPetData.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/13.
//  Copyright © 2018年 yaohr. All rights reserved.
//
//  宠物数据

#import "YHBaseData.h"

@interface YHPetData : YHBaseData
@property (nonatomic,strong)NSNumber<Optional>* _id;          //数据库id
@property (nonatomic,copy)NSString<Optional>* identity;       //唯一编码
@property (nonatomic,copy)NSString<Optional>* img_url;        //头像
@property (nonatomic,copy)NSString<Optional>* name;           //昵称
@property (nonatomic,copy)NSString<Optional>* birthday;       //生日
@property (nonatomic,copy)NSString<Optional>* sex;            //性别
@property (nonatomic,strong)NSNumber<Optional>* age;          //年龄
@property (nonatomic,copy)NSString<Optional>* hair_color;     //毛色
@property (nonatomic,copy)NSString<Optional>* variety;        //品种
@property (nonatomic,copy)NSString<Optional>* remark;         //备注
@end
