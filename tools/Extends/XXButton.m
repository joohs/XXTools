//
//  XXButton.m
//  plasticScan
//
//  Created by Jon on 2021/6/23.
//

#import "XXButton.h"

@implementation XXButton

/**
 拓展button的点击区域，最小维持在44，44
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    CGFloat width = MAX(44.0 - bounds.size.width, 0);
    CGFloat height = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, - 0.5 * width, - 0.5 * height);
    //如果点击的点 在 新的bounds里，就返回YES
    return CGRectContainsPoint(bounds, point);
}

@end
