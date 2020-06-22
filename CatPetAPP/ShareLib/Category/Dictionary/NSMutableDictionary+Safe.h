//
//  NSMutableDictionary+Safe.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/2/28.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Safe)
- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey;
- (void)safe_removeObjectForKey:(id<NSCopying>)key;
@end
