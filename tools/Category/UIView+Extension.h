//
//  UIView+Extension.h
//  Scaning
//
//  Created by william on 13-11-14.
//  Copyright (c) 2013年 iphone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/**
 自定义圆角
 rectCorner：UIRectCornerBottomLeft | UIRectCornerBottomRight
 */
- (void)cornerRadius:(UIRectCorner)rectCorner cornerDii:(CGSize)size;

@end
