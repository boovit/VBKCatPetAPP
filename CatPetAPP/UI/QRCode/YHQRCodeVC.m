//
//  YHQRCodeVC.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/4/1.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHQRCodeVC.h"
#import <UIKit/UIBezierPath.h>

@interface YHQRCodeVC ()
@property(nonatomic, copy )NSString *qrCode;
@property(nonatomic,strong)UIImage *posterImage;
@property(nonatomic,strong)UIImageView *codeImageView;
@property(nonatomic,strong)UILabel *tipsLabel;
@end

@implementation YHQRCodeVC
-(instancetype)initWithQRCodeString:(NSString*)code posterImage:(UIImage*)posterImage
{
    if (self = [super init]) {
        self.qrCode = code;
        self.posterImage = posterImage;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createQRCodeImage];
    self.tipsLabel.text = @"长按二维码保存";
}

#pragma mark - override
-(void)initNavigationBar
{
    [super initNavigationBar];
    [self setNavBarTitle:@"我的二维码"];
}

-(UIImageView *)codeImageView
{
    if (!_codeImageView) {
        _codeImageView = [[UIImageView alloc] init];
        _codeImageView.userInteractionEnabled = YES;
        [self.view addSubview:_codeImageView];
        
        //初始化一个长按手势
        UILongPressGestureRecognizer *longPressGest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressView:)];
        //长按等待时间
        longPressGest.minimumPressDuration = 0.5;
        //长按时候,手指头可以移动的距离
        longPressGest.allowableMovement = 100;
        [_codeImageView addGestureRecognizer:longPressGest];
        
        [_codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.width.height.equalTo(self.view.mas_width);
        }];
    }
    return _codeImageView;
}

-(UILabel *)tipsLabel
{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.textColor = [UIColor grayColor];
        _tipsLabel.font = [UIFont systemFontOfSize:15.0];
        [self.view addSubview:_tipsLabel];
        
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.codeImageView.mas_bottom).offset(10);
            make.centerX.equalTo(self.view);
        }];
    }
    return _tipsLabel;
}

#pragma mark - private
-(void)createQRCodeImage
{
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    // 2. 给滤镜添加数据
    NSString *string = self.qrCode;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 使用KVC的方式给filter赋值
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 3. 生成二维码
    CIImage *image = [filter outputImage];
    // 4. 显示二维码
    UIImage *codeImage = [self createNonInterpolatedUIImageFormCIImage:image withSize:500];
    
    self.codeImageView.image = [self addCenterImage:self.posterImage onSourceImage:codeImage];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

-(UIImage*)addCenterImage:(UIImage*)image onSourceImage:(UIImage*)srcImage
{
    UIGraphicsBeginImageContext(srcImage.size);
    //将二维码的图片画入
    [srcImage drawInRect:CGRectMake(0, 0, srcImage.size.width, srcImage.size.height)];
    //中心图片
    UIImage *centerImg=image;
    CGFloat centerW=100;
    CGFloat centerH=100;
    CGFloat centerX=(srcImage.size.width-centerW)*0.5;
    CGFloat centerY=(srcImage.size.height-centerH)*0.5;
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(centerX, centerY, centerW, centerH) cornerRadius:10.0] addClip];
    [centerImg drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
    //获取绘制好的图片
    UIImage *finalImg=UIGraphicsGetImageFromCurrentImageContext();
    //关闭图像上下文
    UIGraphicsEndImageContext();
    return finalImg;
}

#pragma mark - Action
-(void)longPressView:(UILongPressGestureRecognizer *)longPressGest
{
    NSLog(@"%ld",longPressGest.state);
    if (longPressGest.state==UIGestureRecognizerStateBegan) {
        [self showSavePhotoSelectView];
    }
}

-(void)showSavePhotoSelectView
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self saveImageToPhotos:self.codeImageView.image];
    }];
    [alertController addAction:saveAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

//实现该方法
- (void)saveImageToPhotos:(UIImage*)savedImage
{
    if (savedImage) {
        UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        [YHShareUtil showLoadingOnView:self.view];
    }
}

#pragma mark - save photo delegate
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [YHShareUtil hideLoadingOnView:self.view];
    [YHShareUtil showToast:msg];
}
@end
