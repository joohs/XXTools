//
//  ImageTool.m
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import "ImageTool.h"

@implementation ImageTool

//从图片转到颜色
+ (UIColor *)colorFromImage:(UIImage *)image {
    if (image == nil) {
        return [UIColor clearColor];
    } else {
        return [UIColor colorWithPatternImage:image];
    }
}

//从颜色生成图片
+ (UIImage *)imageFromUIColor:(UIColor *)color size:(CGSize)size {
    if (!color) {
        color = [UIColor clearColor];
    }
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    // create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 压缩图片按照大小
+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size {
    CGImageRef imgRef = image.CGImage;
    CGSize originSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // 原始大小
    if (CGSizeEqualToSize(originSize, size)) {
        return image;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);            //[UIScreen mainScreen].scale
    CGContextRef context = UIGraphicsGetCurrentContext();
    /**
     *  设置CGContext集插值质量
     *  kCGInterpolationHigh 插值质量高
     */
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

// 压缩图片按照比例
+ (UIImage *)image:(UIImage *)image scaleWithRatio:(CGFloat)ratio {
    CGImageRef imgRef = image.CGImage;
    if (ratio > 1 || ratio <= 0) {
        return image;
    }
    CGSize size = CGSizeMake(CGImageGetWidth(imgRef) * ratio, CGImageGetHeight(imgRef) * ratio); // 缩放后大小
    return [self image:image scaleToSize:size];
}

// 添加水印
+ (UIImage *)image:(UIImage *)img addLogo:(UIImage *)logo {
    if (logo == nil ) {
        return img;
    }
    if (img == nil) {
        return nil;
    }
    //get image width and height
    int w = img.size.width;
    int h = img.size.height;
    int logoWidth = logo.size.width;
    int logoHeight = logo.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextDrawImage(context, CGRectMake(w-logoWidth-15, 10, logoWidth, logoHeight), [logo CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage *returnImage = [UIImage imageWithCGImage:imageMasked];
    CGContextRelease(context);
    CGImageRelease(imageMasked);
    CGColorSpaceRelease(colorSpace);
    return returnImage;
}

/**
 *  屏幕截图有状态栏
 */
+ (UIImage *)imageWithScreenshot {
    CGSize imageSize = [UIScreen mainScreen].bounds.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
    
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.screen == [UIScreen mainScreen]) {
            [window drawViewHierarchyInRect:[UIScreen mainScreen].bounds afterScreenUpdates:NO];
        }
    }
    UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
    [statusBar drawViewHierarchyInRect:statusBar.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}


/**
 *  屏幕截图没有状态栏
 */
+ (UIImage *)imageWithScreenshotNoStatusBar {
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.screen == [UIScreen mainScreen]) {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, window.center.x, window.center.y);
            CGContextConcatCTM(context, window.transform);
            CGContextTranslateCTM(context, -window.bounds.size.width *window.layer.anchorPoint.x, -window.bounds.size.height *window.layer.anchorPoint.y);
            [window.layer renderInContext:context];
            CGContextRestoreGState(context);
        }
        
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  view生成图片
 */
+ (UIImage *)imageForView:( UIView * _Nonnull )view {
    CGSize size = view.bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//图片转为base64
+ (NSString *)imageTransformBase64:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

//base64转为图片
+ (UIImage *)base64TransformImage:(NSString *)base64 {
    NSData *decodedImageData = [[NSData alloc]
    initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}

/// 调整图片尺寸和大小
/// @param sourceImage 原始图片
/// @param maxImageSize 新图片最大尺寸
/// @param maxSize 新图片最大存储大小（kb）
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize {
    if (maxSize <= 0.0) maxSize = 2.0 * 1024.0;
    if (maxImageSize <= 0.0) maxImageSize = 4096.0;
    //先调整分辨率
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    CGFloat tempHeight = newSize.height / maxImageSize;
    CGFloat tempWidth = newSize.width / maxImageSize;
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    } else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(newImage,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.1;
    }
    return imageData;
}

+ (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}

//旋转image
+ (UIImage *)fixOrientation:(UIImage *)srcImg {
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGFloat width = srcImg.size.width;
    CGFloat height = srcImg.size.height;
    
    CGContextRef ctx;
    
    switch (srcImg.imageOrientation) {
        case UIImageOrientationUp: //竖屏，不旋转
            ctx = CGBitmapContextCreate(NULL, width, height,
                                        CGImageGetBitsPerComponent(srcImg.CGImage), 0,
                                        CGImageGetColorSpace(srcImg.CGImage),
                                        CGImageGetBitmapInfo(srcImg.CGImage));
            break;
            
        case UIImageOrientationLeft:  //横屏，home键在右手边，逆时针旋转90°
            transform = CGAffineTransformTranslate(transform, height, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            ctx = CGBitmapContextCreate(NULL, height, width,
                                        CGImageGetBitsPerComponent(srcImg.CGImage), 0,
                                        CGImageGetColorSpace(srcImg.CGImage),
                                        CGImageGetBitmapInfo(srcImg.CGImage));
            break;
            
        case UIImageOrientationRight:  //横屏，home键在左手边，顺时针旋转90°
            transform = CGAffineTransformTranslate(transform, 0, width);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            ctx = CGBitmapContextCreate(NULL, height, width,
                                        CGImageGetBitsPerComponent(srcImg.CGImage), 0,
                                        CGImageGetColorSpace(srcImg.CGImage),
                                        CGImageGetBitmapInfo(srcImg.CGImage));
            break;
            
        default:
            break;
    }
    CGContextConcatCTM(ctx, transform);
    CGContextDrawImage(ctx, CGRectMake(0,0,width,height), srcImg.CGImage);
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;
}

@end
