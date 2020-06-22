//
//  YHInfoItemData.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/15.
//  Copyright © 2018年 yaohr. All rights reserved.
//
//  用户新页数据

#import "YHBaseData.h"

@interface YHInfoItemData : YHBaseData
@property(nonatomic,copy)NSString<Optional>* title;       //标题
@property(nonatomic,copy)NSString<Optional>* intro;       //内容
@property(nonatomic,copy)NSString<Optional>* placeholder; //占位描述
@property(nonatomic,copy)NSString<Optional>* imgurl;      //图片
@property(nonatomic,copy)NSString<Optional>* tag;         //数据类型
@end
