//
//  YHTimerProxy.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/16.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHTimerProxy : NSObject
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

@property (nonatomic, assign) int tickSum;      // 累计
@property (nonatomic, assign) BOOL disableIfBackground;

@property (nonatomic, strong) id info;

- (void)timerCallbackHandler:(NSTimer*)timer;
@end
