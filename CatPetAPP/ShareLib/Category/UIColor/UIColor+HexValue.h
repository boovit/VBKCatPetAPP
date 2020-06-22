//
//  UIColor+HexValue.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/2/28.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexValue)
+ (UIColor*)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor*)colorWithHexValue:(NSUInteger)hexValue;
@end
