//
//  AnimationTool.h
//  plasticScan
//
//  Created by Jon on 2021/6/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnimationTool : NSObject

/**
 呼吸/脉冲动画效果
 */
+ (void)animationScale:(UIView *)view;

/**
 present动画
 */
+ (void)animationPresentView:(UIView *)view;

/**
 alert动画
 */
+ (void)animationAlert:(UIView *)view;

/**
  360度旋转，可以控制旋转次数
 */
+ (void)animationRotation:(UIView *)view;

/**
 绕着某个位置进行旋转固定的角度
 可以自定义旋转的角度、绕着哪个点进行旋转
 */
+ (void)animationRotationPosition:(UIView *)view;

#pragma mark === 永久闪烁的动画 ======
-(CABasicAnimation *)opacityForever_Animation:(float)time;
   
#pragma mark =====横向、纵向移动===========
-(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x;
   
#pragma mark =====缩放-=============
-(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repertTimes;
   
#pragma mark =====组合动画-=============
-(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes;
   
#pragma mark =====路径动画-=============
-(CAKeyframeAnimation *)keyframeAnimation:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes;
   
#pragma mark ====旋转动画======
-(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount;

@end

NS_ASSUME_NONNULL_END
