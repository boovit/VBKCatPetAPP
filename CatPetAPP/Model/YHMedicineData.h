//
//  YHMedicineData.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/13.
//  Copyright © 2018年 yaohr. All rights reserved.
//
//  药物信息

#import "YHBaseData.h"

@interface YHMedicineData : YHBaseData
@property(nonatomic,copy)NSString* name;    //名称
@property(nonatomic,copy)NSString* intro;   //简介
@property(nonatomic,copy)NSString* dosage;  //用量
@end
