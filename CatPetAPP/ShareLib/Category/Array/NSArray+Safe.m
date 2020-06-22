//
//  NSArray+Safe.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/1.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "NSArray+Safe.h"
#import "YHAssertMacro.h"

@implementation NSArray (Safe)
- (id)safe_objectAtIndex:(NSUInteger)index
{
    if (index < [self count])
    {
        return [self objectAtIndex:index];
    }
    else
    {
        VERROR();
    }
    return nil;
}
@end
