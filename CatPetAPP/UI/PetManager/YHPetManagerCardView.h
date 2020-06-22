//
//  YHPetManagerCardView.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/28.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBaseData.h"

#define YHPetManagerCardViewHeight (120.0f)

@interface YHPetManagerCardViewModel : YHBaseData
@property (nonatomic,copy)NSString *imgUrl;
@property (nonatomic,copy)NSString *title;
@end

@protocol YHPetManagerCardViewDelegate<NSObject>
@optional
-(void)didSelectedCardView:(UIView*)view;
@end

@interface YHPetManagerCardView : UIView
@property(nonatomic,weak)id<YHPetManagerCardViewDelegate> delegate;
-(void)reloadWithData:(YHPetManagerCardViewModel*)cardData;
@end
