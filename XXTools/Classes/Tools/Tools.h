//
//  Tools.h
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    iPhoneSizeSmall,    //320,375
    iPhoneSizeCustom,   //390
    iPhoneSizeBig,      //414
} iPhoneSize;

typedef void(^CheckNetworkStatusBlock)(void);
typedef void(^SystemShareCallbackBlock)(UIActivityType activityType, BOOL completed);


@interface Tools : NSObject

/**
 appName
 */
+ (NSString *)appName;

/**
 deviceId（CFUUID）
 假的设备ID，通过保存在Keychain上来保持唯一
 */
+ (NSString *)deviceId;

+ (NSString *)idfa;

+ (NSString *)idfv;

/**
 系统版本
 */
+ (NSString *)systemVersion;

/**
 获得设备型号
 */
+ (NSString *)deviceModel;

/**
  appName
 */
+ (NSString *)bundleName;

/**
 bundleID
 */
+ (NSString *)bundleId;

/**
 app版本
 */
+ (NSString *)appVersion;

/**
 编译版本号
 */
+ (NSString *)appBuildVersion;

/**
 底部tabBar高度
 */
+ (CGFloat)tabBarHeight;

/**
 tabBar下方的安全区域高度
 */
+ (CGFloat)bottomSafeAreaHeight;

/**
 电池状态栏高度
 */
+ (CGFloat)statusBarHeight;

/**
 导航栏高度
 */
+ (CGFloat)navigationBarHeight;

/**
 网络是否连通
 */
+ (BOOL)networkReachable;

/**
 无网络弹框
 */
+ (void)noNetworkAlert;

/**
 无相机权限弹框
 */
+ (void)showCameraToast;

/**
 相机是否可用
 */
+ (BOOL)canUseCamera;

/**
 无相册权限弹框
 */
+ (void)showPhotoAlbumToast;

/**
 判断刘海屏
 */
+ (Boolean)bangScreen;

/**
 获取当前界面的controller
 */
+ (UIViewController *)currentVisibleViewController;

/**
 调用系统分享
 */
+ (void)systemActivityViewControllerWithTitle:(nullable NSString *)title shareImage:(nullable UIImage *)shareImage shareUrl:(nullable NSURL *)shareUrl callback:(nonnull SystemShareCallbackBlock)callback;

/*
 0-10000的随机数
 */
+ (NSString *)fileRandom;

/**
  屏幕不同的手机高度调整
 */
+ (CGFloat)differentPhoneValue:(CGFloat)value;

/**
  屏幕大小
 */
+ (iPhoneSize)iPhoneSize;

@end

NS_ASSUME_NONNULL_END
