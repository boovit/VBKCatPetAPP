//
//  YHTextViewTableCell.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/25.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHTextViewTableCell.h"
#import <Masonry/Masonry.h>
#import <YYKit/YYTextView.h>

#import "UIColor+HexValue.h"

#import "YHDesignMacro.h"
#import "YHUIUtilMacro.h"

@interface YHTextViewTableCell()<YYTextViewDelegate>
@property(nonatomic,strong)YYTextView *textView;
@property(nonatomic,strong)UIView *shadowView;
@end

@implementation YHTextViewTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textView = [[YYTextView alloc] init];
        _textView.delegate = self;
        _textView.textColor = [UIColor colorWithHexValue:YHDesignMacroColor_ContentText];
        _textView.font = [UIFont systemFontOfSize:YHDesignMacroFontSize_SubTitle];
        _textView.placeholderTextColor = [UIColor colorWithHexValue:YHDesignMacroColor_PlaceholderText];
        _textView.placeholderFont = [UIFont systemFontOfSize:YHDesignMacroFontSize_SubTitle];
        _textView.layer.borderColor = [UIColor colorWithHexValue:0xeeeeee].CGColor;
        _textView.layer.borderWidth = SINGLE_PIXEL_HEIGHT;
        [self.contentView addSubview:_textView];
        [self masLayoutSubview];
    }
    return self;
}

-(void)masLayoutSubview
{
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView);
    }];
}

-(void)refreshText:(NSString*)text placeholder:(NSString*)placeholder
{
    self.textView.text = text;
    self.textView.placeholderText = placeholder;
}

-(UIView *)shadowView
{
    if (!_shadowView) {
        _shadowView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _shadowView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickShadowView:)];
        [_shadowView addGestureRecognizer:tapGest];
    }
    return _shadowView;
}

-(void)showShadowView
{
    [self dismissShadowView];
    [self.window addSubview:self.shadowView];
}

-(void)dismissShadowView
{
    [self.shadowView removeFromSuperview];
}

-(void)clickShadowView:(id)sender
{
    [self.textView endEditing:YES];
    [self dismissShadowView];
}

#pragma mark - YYTextViewDelegate
- (BOOL)textViewShouldBeginEditing:(YYTextView *)textView
{
    [self showShadowView];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(YYTextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(textViewTableCell:didChangeText:)]) {
        [self.delegate textViewTableCell:self didChangeText:self.textView.text];
    }
    [self dismissShadowView];
    return YES;
}

- (void)textViewDidChange:(YYTextView *)textView
{
    if ([textView.text containsString:@"\n"]) {
        textView.text = [textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        [self clickShadowView:nil];
    }
}
@end
