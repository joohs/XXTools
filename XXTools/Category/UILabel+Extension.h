//
//  UILabel+Extension.h
//  component
//
//  Created by WXX on 2020/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extension)

- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor;
- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor attributedString:(NSString *)attributedString;
- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor attributedString:(NSString *)attributedString attributedColor:(UIColor *)attributedColor;

- (void)allText:(NSString *)allText matchTextDiction:(nullable NSDictionary *)matchTextDiction matchColor:(UIColor *)matchColor;
- (void)allText:(NSString *)allText matchTextDiction:(NSDictionary *)matchTextDiction matchColor:(UIColor *)matchColor lineSpacing:(CGFloat)lineSpacing;
- (void)allText:(NSString *)allText matchTextDiction:(NSDictionary *)matchTextDiction matchColor:(UIColor *)matchColor lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font;

- (void)allText:(NSString *)allText matchText:(NSString *)matchText matchColor:(UIColor *)matchColor;
- (void)allText:(NSString *)allText matchText:(NSString *)matchText matchColor:(UIColor *)matchColor lineSpacing:(CGFloat)lineSpacing;

- (NSMutableAttributedString *) getAttributedStringWithAllText:(NSString *)allText matchTextDiction:(NSDictionary *)matchTextDiction matchColor:(UIColor *)matchColor lineSpacing:(CGFloat)lineSpacing;


@end

NS_ASSUME_NONNULL_END
