//
//  UIView+Extension.m
//  Scaning
//
//  Created by william on 13-11-14.
//  Copyright (c) 2013年 iphone. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)cornerRadius:(UIRectCorner)rectCorner cornerDii:(CGSize)size {
   UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:size];
   CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
   maskLayer.frame = self.bounds;
   maskLayer.path = maskPath.CGPath;
   self.layer.mask = maskLayer;
}

@end
