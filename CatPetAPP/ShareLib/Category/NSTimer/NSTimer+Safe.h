//
//  NSTimer+Safe.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/16.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Safe)
+ (NSTimer *)safe_scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                          target:(id)aTarget            // weak reference, avoid crash bug
                                        selector:(SEL)aSelector
                                        userInfo:(id)userInfo
                                         repeats:(BOOL)yesOrNo
                             disableIfBackground:(BOOL)disableIfBackground;

- (int)tickSum;     // 累计总次数
@end
