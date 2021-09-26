//
//  GravityInductionTool.h
//  plasticScan
//
//  Created by TheChosenOne on 2021/7/28.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface GravityInductionTool : NSObject

@property (nonatomic, assign) UIImageOrientation orientation;

- (void)startUpdateAccelerometer;
- (void)stopUpdate;

@end

NS_ASSUME_NONNULL_END
