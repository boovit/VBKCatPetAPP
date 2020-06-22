//
//  YHQRCodeVC.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/4/1.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHBaseViewController.h"

@interface YHQRCodeVC : YHBaseViewController
-(instancetype)initWithQRCodeString:(NSString*)code posterImage:(UIImage*)posterImage;
@end
