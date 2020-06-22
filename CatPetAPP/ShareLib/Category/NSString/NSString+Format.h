//
//  NSString+Format.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/15.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Format)
- (NSString *)md5;
- (NSString *)trim;
- (BOOL)validateCellPhoneNumber;//电话号码校验
@end
