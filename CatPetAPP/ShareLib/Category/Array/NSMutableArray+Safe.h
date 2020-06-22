//
//  NSMutableArray+Safe.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/1.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Safe)
- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)safe_addObject:(id)anObject;
- (void)safe_removeObjectAtIndex:(NSUInteger)index;
- (void)safe_removeObject:(id)anObject;
@end
