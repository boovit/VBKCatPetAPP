//
//  NSMutableArray+Safe.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/1.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "YHAssertMacro.h"

@implementation NSMutableArray (Safe)
- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject && index <= [self count])
    {
        [self insertObject:anObject atIndex:index];
    }
    else
    {
        VERROR();
    }
}

- (void)safe_addObject:(id)anObject
{
    if (anObject)
    {
        [self addObject:anObject];
    }
    else
    {
        VERROR();
    }
}

- (void)safe_removeObjectAtIndex:(NSUInteger)index
{
    if (index < [self count]) {
        [self removeObjectAtIndex:index];
    }else
    {
        VERROR();
    }
}

- (void)safe_removeObject:(id)anObject
{
    if (anObject) {
        [self removeObject:anObject];
    }else
    {
        VERROR();
    }
}
@end
