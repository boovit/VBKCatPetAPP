//
//  NSMutableDictionary+Safe.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/2/28.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import "YHAssertMacro.h"

@implementation NSMutableDictionary (Safe)
- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject && aKey)
    {
        [self setObject:anObject forKey:aKey];
    }
    else
    {
        VERROR();
    }
}

- (void)safe_removeObjectForKey:(id<NSCopying>)key
{
    if (key) {
        [self removeObjectForKey:key];
    }else
    {
        VERROR();
    }
}
@end
