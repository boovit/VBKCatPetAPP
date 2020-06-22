//
//  NSStringIsEmpty.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/15.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#ifndef NSStringIsEmpty_h
#define NSStringIsEmpty_h

#import "NSString+Format.h"

// evaluate whether a string is empty.
#define __isStrNotEmpty(string) (   string                                 \
                                && ![string isEqual:[NSNull null]]         \
                                && [string isKindOfClass:[NSString class]] \
                                && ![string isEqualToString:@"(null)"]     \
                                && [string trim].length)
#define __isStrEmpty(string) !(__isStrNotEmpty(string))

#endif /* NSStringIsEmpty_h */
