//
//  ImageTool.h
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageTool : NSObject

/**
 图片生成颜色
 */
+ (UIColor *)colorFromImage:(UIImage *)image;

/**
 颜色生成图片
 */
+ (UIImage *)imageFromUIColor:(UIColor *)color size:(CGSize)size;

/**
 按照大小压缩图片
 */
+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size;

/**
 按照比例压缩图片
 */
+ (UIImage *)image:(UIImage *)image scaleWithRatio:(CGFloat)ratio;

/**
 添加水印
 */
+ (UIImage *)image:(UIImage *)img addLogo:(UIImage *)logo;

/**
 屏幕截图有状态栏
 */
+ (UIImage *)imageWithScreenshot;

/**
 屏幕截图没有状态栏
 */
+ (UIImage *)imageWithScreenshotNoStatusBar;

/**
 view生成图片
 */
+ (UIImage *)imageForView:( UIView * _Nonnull )view;

/**
 图片转为base64
 */
+ (NSString *)imageTransformBase64:(UIImage *)image;

/**
 base64转为图片
 */
+ (UIImage *)base64TransformImage:(NSString *)base64;

/**
 调整图片尺寸和大小
 默认maxImageSize：4096
 默认MaxSize：3M
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat)maxSize;

/**
 获取图片的后缀名
 */
+ (NSString *)contentTypeForImageData:(NSData *)data;

/**
 旋转image成竖屏
 */
+ (UIImage *)fixOrientation:(UIImage *)srcImg;

@end

NS_ASSUME_NONNULL_END
