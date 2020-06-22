//
//  NSTimer+Safe.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/16.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "NSTimer+Safe.h"
#import "YHAssertMacro.h"
#import "YHTimerProxy.h"
#import <objc/runtime.h>

#define kYHTimerProxyAttached       "com.yaohr.Sharelib.kYHTimerProxyAttached"

@implementation NSTimer (Safe)
+ (NSTimer *)safe_scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                          target:(id)aTarget
                                        selector:(SEL)aSelector
                                        userInfo:(id)userInfo
                                         repeats:(BOOL)yesOrNo
                             disableIfBackground:(BOOL)disableIfBackground
{
    NSTimer *timer = nil;
    BOOL ret = YES;
    YHTimerProxy *proxy = [YHTimerProxy new];
    
    CPRA(aTarget);
    CPRA(aSelector);
    CPRA(proxy);
    
    proxy.target = aTarget;
    proxy.selector = aSelector;
    proxy.disableIfBackground = disableIfBackground;
    
    timer = [self scheduledTimerWithTimeInterval:ti
                                          target:proxy
                                        selector:@selector(timerCallbackHandler:)
                                        userInfo:userInfo
                                         repeats:yesOrNo];
    CPRA(timer);
    
    objc_setAssociatedObject(timer, kYHTimerProxyAttached, proxy, OBJC_ASSOCIATION_ASSIGN);
    
ERROR:
    if (!ret)
    {
        timer = nil;
    }
    
    return timer;
}

- (int)tickSum
{
    YHTimerProxy *proxy = objc_getAssociatedObject(self, kYHTimerProxyAttached);
    if ([proxy isKindOfClass:[YHTimerProxy class]])
    {
        return proxy.tickSum;
    }
    
    return 0;
}
@end
