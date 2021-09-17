//
//  GravityInductionTool.m
//  plasticScan
//
//  Created by TheChosenOne on 2021/7/28.
//

#import "GravityInductionTool.h"
#import <CoreMotion/CoreMotion.h>
#import <UIKit/UIKit.h>

@interface GravityInductionTool ()

@property (strong, nonatomic) CMMotionManager *motionManager;
 
@property (assign, nonatomic) BOOL isHorizontal;

@end

@implementation GravityInductionTool

- (void)dealloc {
    _motionManager = nil;
}

- (CMMotionManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        self.orientation = UIImageOrientationUp;
    }
    return _motionManager;
}

- (void)startUpdateAccelerometer {
    if ([self.motionManager isAccelerometerAvailable]) {
        [self.motionManager setAccelerometerUpdateInterval:.2];
        [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            if (error) {
                [self.motionManager stopAccelerometerUpdates];
            } else {
                double x = accelerometerData.acceleration.x;
                double y = accelerometerData.acceleration.y;
                NSLog(@"%f:%f", x, y);
                if (fabs(y) >= fabs(x)) {
                    if (y >= 0) {
                        //Down
                        NSLog(@"down");
                        self.orientation = UIImageOrientationDown;
                    } else {
                        //Portrait
                        NSLog(@"Portrait");
                        self.orientation = UIImageOrientationUp;
                    }
                } else {
                    if (x >= 0) {
                        //Right
                        NSLog(@"Right");
                        self.orientation = UIImageOrientationRight;
                    } else {
                        //Left
                        NSLog(@"Left");
                        self.orientation = UIImageOrientationLeft;
                    }
                }
            }
        }];
    }
}

- (void)stopUpdate {
    if ([self.motionManager isAccelerometerActive]) {
        [self.motionManager stopAccelerometerUpdates];
    }
}

@end
