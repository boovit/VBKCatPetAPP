//
//  NSArray+Safe.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/1.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Safe)
- (id)safe_objectAtIndex:(NSUInteger)index;
@end
