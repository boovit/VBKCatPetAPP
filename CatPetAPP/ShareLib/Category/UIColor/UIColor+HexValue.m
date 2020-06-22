//
//  UIColor+HexValue.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/2/28.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "UIColor+HexValue.h"

@implementation UIColor (HexValue)
+ (UIColor*)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha
{
    CGFloat r = ((hexValue & 0x00FF0000) >> 16) / 255.0;
    CGFloat g = ((hexValue & 0x0000FF00) >> 8) / 255.0;
    CGFloat b = (hexValue & 0x000000FF) / 255.0;
    CGFloat a = alpha / 255.0;
    
    return [self colorWithRed:r green:g blue:b alpha:a];
}

+ (UIColor*)colorWithHexValue:(NSUInteger)hexValue
{
    return [self colorWithHexValue:hexValue alpha:255];
}
@end
