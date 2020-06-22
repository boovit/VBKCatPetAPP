//
//  ShareUtil.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/20.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YHShareUtil : NSObject

+(NSString*)appDisplayName;
+(NSString*)appVersion;
+(NSString*)buildVersion;

+(void)showToast:(NSString*)text;
+(void)showLoadingOnView:(UIView*)superView;
+(void)showLoadingOnView:(UIView*)superView text:(NSString*)text;
+(void)hideLoadingOnView:(UIView*)superView;
@end
