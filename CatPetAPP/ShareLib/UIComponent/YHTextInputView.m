//
//  YHTextInputView.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/15.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHTextInputView.h"
#import <Masonry/Masonry.h>

#import "UIColor+HexValue.h"

#define MIN_LIMIT_NUMS 2
#define MAX_LIMIT_NUMS 7

@interface YHTextInputView()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *numLimitLabel;
@property (nonatomic, strong) UIButton *sendBtn;
@end

@implementation YHTextInputView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor colorWithHexValue:0xd8d8d8];
    [self addSubview:self.lineView];
    
    self.inputView = [[UIView alloc] init];
    self.inputView.backgroundColor = [UIColor colorWithHexValue:0xf4f3f3];
    self.inputView.layer.masksToBounds = YES;
    self.inputView.layer.cornerRadius = 17.0;
    [self addSubview:self.inputView];
    
    self.textField = [[UITextField alloc] init];
    self.textField.backgroundColor = [UIColor clearColor];
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"2-7位字符，支持中英文、数字" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName:[UIColor colorWithHexValue:0xcecece]}];
    self.textField.font = [UIFont systemFontOfSize:16.0];
    self.textField.textColor = [UIColor colorWithHexValue:0x373737];
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.enablesReturnKeyAutomatically = YES;
    [self.textField addTarget:self action:@selector(textViewEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    self.textField.delegate = self;
    [self.inputView addSubview:self.textField];
    
    self.numLimitLabel = [[UILabel alloc] init];
    self.numLimitLabel.textAlignment = NSTextAlignmentRight;
    self.numLimitLabel.textColor = [UIColor colorWithHexValue:0xcecece];
    self.numLimitLabel.font = [UIFont systemFontOfSize:13.0];
    self.numLimitLabel.text = [NSString stringWithFormat:@"%d", MAX_LIMIT_NUMS];
    [self.inputView addSubview:self.numLimitLabel];
    
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self.sendBtn setTitleColor:[UIColor colorWithHexValue:0x1779fe] forState:UIControlStateNormal];
    [self.sendBtn setTitleColor:[UIColor colorWithHexValue:0xcacaca] forState:UIControlStateDisabled];
    [self.sendBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.sendBtn.enabled = NO;
    [self addSubview:self.sendBtn];
    
    [self setSubviewsLayout];
}

- (void)setSubviewsLayout
{
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@0.5);
    }];
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self.sendBtn.mas_left);
        make.top.equalTo(self).offset(9);
        make.bottom.equalTo(self).offset(-9);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputView).offset(10);
        make.right.equalTo(self.inputView).offset(-25);
        make.top.equalTo(self.inputView);
        make.bottom.equalTo(self.inputView);
    }];
    
    [self.numLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.inputView).offset(-9);
        make.bottom.equalTo(self.inputView);
        make.height.equalTo(@35);
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.bottom.equalTo(self.inputView);
        make.width.equalTo(@60);
        make.height.equalTo(@35);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendBtnClick:nil];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *lang = [(UITextInputMode*)[[UITextInputMode activeInputModes] firstObject] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) {// 简体中文输入，包括简体拼音，健体五笔，简体手写
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        //有高亮选择的字符串，则暂不对文字进行统计和限制
        if (position) {
            return YES;
        }
    }
    
    BOOL shouldChange = NO;
    NSString *comcatstr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    if (caninputlen >= 0) {
        shouldChange = YES;
    } else {
        NSInteger len = string.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0) {
            NSString *s = [string substringWithRange:rg];
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
            NSInteger existTextNum = textField.text.length;
            self.sendBtn.enabled = (existTextNum >= MIN_LIMIT_NUMS);
            //不让显示负数
            self.numLimitLabel.text = [NSString stringWithFormat:@"%ld",(long)MAX(0, MAX_LIMIT_NUMS - existTextNum)];
            if (existTextNum >= MAX_LIMIT_NUMS) {
                self.numLimitLabel.text = @"0";
            }
        }
        shouldChange = NO;
    }
    return shouldChange;
}

- (void)textViewEditingChanged:(UITextField *)textField
{
    NSString *lang = [(UITextInputMode*)[[UITextInputMode activeInputModes] firstObject] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        if (position) {
            return;
        }
    }
    
    NSString *nsTextContent = textField.text;
    NSInteger existTextNum = nsTextContent.length;
    self.sendBtn.enabled = (existTextNum >= MIN_LIMIT_NUMS);
    
    //不让显示负数
    self.numLimitLabel.text = [NSString stringWithFormat:@"%ld",(long)MAX(0,MAX_LIMIT_NUMS - existTextNum)];
    if (existTextNum >= MAX_LIMIT_NUMS) {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        [textField setText:s];
        self.numLimitLabel.text = @"0";
    }
}

- (void)clearText
{
    [self.textField setText:@""];
    self.numLimitLabel.text = [NSString stringWithFormat:@"%d", MAX_LIMIT_NUMS];
    self.sendBtn.enabled = NO;
}

- (void)show
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>11.0) {
        [self.window makeKeyWindow];
    }
    [self.textField becomeFirstResponder];
}

- (void)dismiss
{
    [self.textField resignFirstResponder];
}

- (void)sendBtnClick:(UIButton *)sender
{
    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendBtnClick:text:)]) {
        [self.delegate sendBtnClick:self text:self.textField.text];
    }
}
@end
