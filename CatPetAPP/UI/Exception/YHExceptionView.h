//
//  YHExceptionView.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/13.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

typedef enum : NSUInteger {
    YHExceptionView_NullData,
    YHExceptionView_Network,
} YHExceptionType;

@interface YHExceptionView : UIView
@property(nonatomic,strong)UILabel *tipsLab;
-(instancetype)initWithFrame:(CGRect)frame type:(YHExceptionType)type;
-(void)show:(UIView*)view;
-(void)dissmiss;
@end
