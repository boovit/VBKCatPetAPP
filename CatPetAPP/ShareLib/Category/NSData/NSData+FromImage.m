//
//  NSData+FromImage.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/16.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "NSData+FromImage.h"

@implementation NSData (FromImage)
+ (instancetype)YH_dataFromImage:(UIImage *)image{
    NSData *data = nil;
    int alphaInfo = CGImageGetAlphaInfo(image.CGImage);
    BOOL hasAlpha = !(alphaInfo == kCGImageAlphaNone ||
                      alphaInfo == kCGImageAlphaNoneSkipFirst ||
                      alphaInfo == kCGImageAlphaNoneSkipLast);
    BOOL imageIsPng = hasAlpha;
    
    if (imageIsPng) {
        data = UIImagePNGRepresentation(image);
    }
    else {
        data = UIImageJPEGRepresentation(image, (CGFloat)1.0);
    }
    
    return data;
}
@end
