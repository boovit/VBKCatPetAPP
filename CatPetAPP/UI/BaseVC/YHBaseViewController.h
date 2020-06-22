//
//  YHBaseViewController.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/2/27.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>

#import "YHMacro.h"
#import "YHUIUtilMacro.h"
#import "YHNetWorkTools.h"
#import "NSArray+Safe.h"
#import "YHUIUtilMacro.h"
#import "UIView+Rect.h"
#import "NSStringIsEmpty.h"
#import "YHShareUtil.h"

@interface YHBaseViewController : UIViewController
-(void)initNavigationBar;
-(void)setNavBarTitle:(NSString *)title;

-(void)showNothingError4View:(UIView*)view;
-(void)dissmissNothingError;
-(void)showNetworkError4View:(UIView*)view;
-(void)dissmissNetworkError;
@end
