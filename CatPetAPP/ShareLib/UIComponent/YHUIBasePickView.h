//
//  YHUIBasePickView.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/18.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

#import "YHUIUtilMacro.h"

@interface YHUIBasePickView : UIView
@property(nonatomic,strong)UIButton *finishButton;
@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UIView *controlView;
@property(nonatomic, copy )NSArray *dataSource;
@property(nonatomic, copy )NSString *tagStr;
@property(nonatomic, copy )void(^selectedBlock)(YHUIBasePickView *pickView,NSString *text,NSIndexPath *indexPath);

-(void)show:(UIView*)superView didSelectedItemIndex:(void(^)(YHUIBasePickView *pickView,NSString *text,NSIndexPath *indexPath))selectedBlock;

//Action
-(void)finishButtonClick:(id)sender;
-(void)cancelButtonClick:(id)sender;

-(void)reloadData:(NSArray*)data;
@end
