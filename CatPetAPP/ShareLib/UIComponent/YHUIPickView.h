//
//  YHUIPickView.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/16.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHUIBasePickView.h"

@interface YHUIPickView : YHUIBasePickView
-(instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray*)dataSource;
@end
