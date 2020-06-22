//
//  UIView+YHExtend.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/28.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "UIView+YHExtend.h"

@implementation UIView (YHExtend)
-(void)cutCircular
{
    self.layer.cornerRadius = self.frame.size.width/2;
}

-(void)setBorderWidth:(CGFloat)width color:(UIColor*)color
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}
@end
