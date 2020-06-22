//
//  YHTimerProxy.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/16.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHTimerProxy.h"
#import <UIKit/UIKit.h>
#import "YHAssertMacro.h"

@implementation YHTimerProxy
- (void)timerCallbackHandler:(NSTimer*)timer
{
    if (self.disableIfBackground &&
        [UIApplication sharedApplication].applicationState != UIApplicationStateActive)
    {
        return;
    }
    
    self.tickSum++;
    
    if (self.target && [self.target respondsToSelector:self.selector])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:timer];
#pragma clang diagnostic pop
    }
    else
    {
        VERROR();
    }
}
@end
