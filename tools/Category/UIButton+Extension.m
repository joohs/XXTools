//
//  UIButton+Extension.m
//  component
//
//  Created by WXX on 2020/11/24.
//

#import "UIButton+Extension.h"
#import <YYText/YYText.h>

@interface UIButton ()

@end

@implementation UIButton (Extension)

- (void)setFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor {
    self.titleLabel.font = font;
    [self setTitleColor:textColor forState:UIControlStateNormal];
    self.layer.cornerRadius = frame.size.height / 2;
    self.layer.masksToBounds = YES;
}

- (void)setFrame:(CGRect)frame font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor {
    self.frame = frame;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = frame.size.height / 2;
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setBackgroundColor:backgroundColor];
    self.titleLabel.font = font;
}

- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor {
    self.titleLabel.font = font;
    [self setTitleColor:textColor forState:UIControlStateNormal];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
}

- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor cornerRadius:(CGFloat)cornerRadius {
    self.titleLabel.font = font;
    [self setTitleColor:textColor forState:UIControlStateNormal];
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor {
    self.titleLabel.font = font;
    [self setTitleColor:textColor forState:UIControlStateNormal];
    [self setBackgroundColor:backgroundColor];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
}

- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius {
    self.titleLabel.font = font;
    [self setTitleColor:textColor forState:UIControlStateNormal];
    [self setBackgroundColor:backgroundColor];
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor attributedString:(NSString *)attributedString attributedColor:(UIColor *)attributedColor {
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    NSMutableAttributedString *descAttributeString = [[NSMutableAttributedString alloc] initWithString:[self clearTagString:attributedString]];
    descAttributeString.yy_font = font;
    descAttributeString.yy_color = textColor;
    [descAttributeString addAttribute:NSForegroundColorAttributeName value:attributedColor range:[[self clearTagString:attributedString] rangeOfString:[self insideTagString:attributedString]]];
    [self setAttributedTitle:descAttributeString forState:UIControlStateNormal];
}

#pragma mark - 正则去除网络标签
- (NSString *)clearTagString:(NSString *)string {
    string = [NSString stringWithFormat:@"%@",string];
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>" options:0 error:nil];
    string=[regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}

#pragma mark - 获取标签内的字符串
- (NSString *)insideTagString:(NSString *)string {
    if ([string containsString:@"<em>"] && [string containsString:@"</em>"]) {
        NSArray *arr = [string componentsSeparatedByString:@"<em>"];
        NSArray *arr2 = [arr[1] componentsSeparatedByString:@"</em>"];
        return arr2[0];
    }
    return @"";
}

- (void)edgePosition:(ButtonPosition)edgePosition {
    [self edgePosition:edgePosition gap:0];
}

/**
 ⚠️如果出现图片和文字没有居中对齐的情况，是由于宽度不够
 */
- (void)edgePosition:(ButtonPosition)edgePosition gap:(CGFloat)gap{
    if (edgePosition == ButtonPositionWithLeftTitleRightImage) {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.bounds.size.width-gap, 0, self.imageView.bounds.size.width)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width+gap, 0, -self.titleLabel.bounds.size.width)];
    }else if(edgePosition == ButtonPositionWithTopImageBottomTitle){
        [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.bounds.size.height+gap ,-self.imageView.bounds.size.width, 0, 0)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width/2, self.titleLabel.bounds.size.height+gap, -self.titleLabel.bounds.size.width/2)];
    }else if(edgePosition == ButtonPositionWithTopTitleBottomImage){
        [self setTitleEdgeInsets:UIEdgeInsetsMake(-self.imageView.bounds.size.height-gap ,-self.imageView.bounds.size.width, 0, 0)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(self.titleLabel.bounds.size.height+gap, 0, 0, -self.titleLabel.bounds.size.width)];
    } else if (edgePosition == ButtonPositionWithLeftImageRightTitle) {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, gap, 0, 0)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, -gap, 0, 0)];
    } else {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.frame.size.width, 0, 0)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -self.titleLabel.frame.size.width)];
    }
}

@end
