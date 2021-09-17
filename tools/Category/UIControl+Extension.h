//
//  UIControl+Extension.h
//  plasticScan
//
//  Created by TheChosenOne on 2021/7/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (Extension)

// 可以用这个给重复点击加间隔
@property (nonatomic, assign) NSTimeInterval cjr_acceptEventInterval;

@end

NS_ASSUME_NONNULL_END
