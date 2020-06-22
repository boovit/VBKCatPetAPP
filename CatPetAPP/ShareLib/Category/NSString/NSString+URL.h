//
//  NSString+URL.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/21.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)
- (NSString*)host4url;
- (NSMutableDictionary *)urlParams;
- (NSString*)removeUrlParam:(NSString*)param;
- (NSString*)stringByAppendedURLParams:(NSDictionary*)params keyList:(NSArray *)keyList;
@end
