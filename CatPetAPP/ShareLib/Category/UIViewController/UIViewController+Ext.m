//
//  UIViewController+Ext.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/13.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "UIViewController+Ext.h"

@implementation UIViewController (Ext)
-(BOOL)isTopViewController
{
    return [self.navigationController topViewController] == self;
}
@end
