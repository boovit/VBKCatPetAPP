//
//  YHMacro.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/13.
//  Copyright © 2018年 yaohr. All rights reserved.
//
//  通用宏

#define weakify(x)      __weak __typeof__(x) weak_##x = (x)
#define strongify(x)    __strong __typeof__(x) (x) = (weak_##x)

