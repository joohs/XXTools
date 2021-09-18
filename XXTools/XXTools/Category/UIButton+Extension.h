//
//  UIButton+Extension.h
//  component
//
//  Created by WXX on 2020/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ButtonPosition) {
    ButtonPositionWithLeftImageRightTitle = 0,//default
    ButtonPositionWithLeftTitleRightImage = 1,
    ButtonPositionWithTopImageBottomTitle = 2,
    ButtonPositionWithTopTitleBottomImage = 3,
    ButtonPositionWithCenter = 4,
};

@interface UIButton (Extension)

- (void)setFrame:(CGRect)frame font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor;
- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor attributedString:(NSString *)attributedString attributedColor:(UIColor *)attributedColor;
- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor;
- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor cornerRadius:(CGFloat)cornerRadius;
- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor;
- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;

#pragma mark - 控制图片和文字的位置
- (void)edgePosition:(ButtonPosition)edgePosition;
- (void)edgePosition:(ButtonPosition)edgePosition gap:(CGFloat)gap;

@end

NS_ASSUME_NONNULL_END
