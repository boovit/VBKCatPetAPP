//
//  YHTextInputView.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/15.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHTextInputView;
@protocol YHTextInputViewDelegate <NSObject>
- (void)sendBtnClick:(YHTextInputView *)inputView text:(NSString *)text;
@end

@interface YHTextInputView : UIView
@property (nonatomic, copy) NSString *tagStr;
@property (nonatomic, weak) id<YHTextInputViewDelegate> delegate;
- (void)clearText;
- (void)show;
- (void)dismiss;
@end
