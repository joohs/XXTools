//
//  Tools.m
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import "Tools.h"
#import "AppDelegate.h"
#import "StringTool.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <Social/Social.h>
#import <AdSupport/AdSupport.h>
#import <SAMKeychain/SAMKeychain.h>
#import "UserDefaultTool.h"
#import <YYCategories/YYCategories.h>
#import <AFNetworking/AFNetworking.h>
#import <RTRootNavigationController/RTRootNavigationController.h>
#import <Photos/Photos.h>

@implementation Tools

/**
 appName
 */
+ (NSString *)appName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

//假的deviceId，通过保存在Keychain上来保持唯一
//为了防止用户删掉keychain导致新生成用户，用userDefault做保护
+ (NSString *)deviceId {
    NSString *code = [StringTool hanziTransform:[self appName]];
    NSString *deviceId = [SAMKeychain passwordForService:code account:@"deviceID"];
    NSString *userDefaultDeviceId = [UserDefaultTool getString:code];
    if (![StringTool isEmpty:userDefaultDeviceId] && [StringTool isEmpty:deviceId]) {
        //本地缓存中存在，但是keychain中没有，认为是用户删掉了keychian，将deviceId重新写入keychain中
        [SAMKeychain deletePasswordForService:code account:@"deviceID"];
        [SAMKeychain setPassword:userDefaultDeviceId forService:code account:@"deviceID"];
        return userDefaultDeviceId;
    }
    if (deviceId == nil || [deviceId isEqualToString:@"nil"]) {
        deviceId  = [NSString stringWithUUID];
        [SAMKeychain deletePasswordForService:code account:@"deviceID"];
        [SAMKeychain setPassword:deviceId forService:code account:@"deviceID"];
    }
    [UserDefaultTool setString:deviceId key:code];
    return deviceId;
}

+ (NSString *)idfa {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString *)idfv {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

//系统版本
+ (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

//获得设备型号
+ (NSString *)deviceModel {
    int mib[2];
    size_t len;
    char *machine;
 
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
 
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone12,8"]) return @"iPhone SE 2";
    if ([platform isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([platform isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPodTouch6G";
    if ([platform isEqualToString:@"iPod9,1"])   return @"iPodTouch7G";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4";

    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPadAir2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPadAir2";
 
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPadmini4";
 
    if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    return platform;
}

+ (NSString *)bundleName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

+ (NSString *)bundleId {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

+ (NSString *)appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+ (CGFloat)tabBarHeight {
    return 49 + [self bottomSafeAreaHeight];
}

+ (CGFloat)bottomSafeAreaHeight {
    return [Tools bangScreen] ? 34 : 0;
}

+ (CGFloat)statusBarHeight {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (CGFloat)navigationBarHeight {
    return [Tools statusBarHeight] + 44;
}

//网络是否连通
+ (BOOL)networkReachable {
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

//无网络弹框
+ (void)noNetworkAlert {
    if ([Tools networkReachable]) {
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您未开启网络" message:@"需要您打开网络才能正常访问" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"前往打开" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [[Tools currentVisibleViewController].navigationController presentViewController:alertController animated:YES completion:^{
            
    }];
}

+ (void)showCameraToast {
    if ([Tools canUseCamera]) {
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"相机权限未开启" message:@"为了您能进行拍照识别文字，我们需要您打开相机权限" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"前往打开" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [[Tools currentVisibleViewController].navigationController presentViewController:alertController animated:YES completion:^{
            
    }];
}

//相机是否可用
+ (BOOL)canUseCamera {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusAuthorized || authStatus == AVAuthorizationStatusNotDetermined) {
        return YES;
    } else {
        return NO;
    }
    return YES;
}

+ (void)showPhotoAlbumToast {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"相册权限未开启" message:@"为了您能选择照片进行文字识别，我们需要您打开相册权限" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"前往打开" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [[Tools currentVisibleViewController].navigationController presentViewController:alertController animated:YES completion:^{
            
    }];
}

/**
 获取当前界面的controller
 */
+ (UIViewController *)currentVisibleViewController {
    return [self getVisibleViewControllerFrom:((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController];
}

/**
 获取当前界面的controller
 */
+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [self getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

+ (UIViewController *)getCurrentDetailViewController {
    RTContainerController *vc = (RTContainerController *)[self currentVisibleViewController];
    if ([vc isKindOfClass:[RTContainerController class]]) {
        return vc.contentViewController;
    }
    return nil;
}

//判断刘海屏
+ (Boolean)bangScreen {
    if (@available(iOS 11.0, *)) {
        if ([UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom > 0) {
            return YES;
        }
        return NO;
    } else {
        CGFloat height = MAX(kScreenWidth, kScreenHeight);
        return height == 812 || height == 896;
    }
}

+ (void)systemActivityViewControllerWithTitle:(NSString *)title shareImage:(UIImage *)shareImage shareUrl:(NSURL *)shareUrl callback:(nonnull SystemShareCallbackBlock)callback {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 分享内容
        NSMutableArray *activityItemsArray = [NSMutableArray array];
        if (title != nil) {
            [activityItemsArray addObject:title];
        }
        if (shareImage != nil) {
            [activityItemsArray addObject:shareImage];
        }
        if (shareUrl != nil) {
            [activityItemsArray addObject:shareUrl];
        }
        UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:activityItemsArray applicationActivities:@[]];
        vc.modalInPopover = YES;
        // 禁用分享渠道
        //    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypeAirDrop, UIActivityTypeOpenInIBooks];
        vc.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
            if (completed) {
                NSLog(@"分享成功");
            } else {
                NSLog(@"分享取消");
            }
            if (callback) {
                callback(activityType, completed);
            }
        };
        [[Tools currentVisibleViewController] presentViewController:vc animated:YES completion:^{
                
        }];
    });
}

+ (NSString *)fileRandom {
    return [NSString stringWithFormat:@"%d", arc4random() % 10000];
}

+ (CGFloat)differentPhoneValue:(CGFloat)value {
    if (MIN(kScreenWidth, kScreenHeight) == 390) {
        //iPhone X 大小
        return value * 1.1;
    } else if (MIN(kScreenWidth, kScreenHeight) > 390) {
        //大于iPhone X
        return value * 1.25;
    }
    //MIN(kScreenWidth, kScreenHeight) == 320、375，iPhone 8, 12 mini
    return value;
}

+ (iPhoneSize)iPhoneSize {
    if (MIN(kScreenWidth, kScreenHeight) == 390) {
        //iPhone X 大小
        return iPhoneSizeCustom;
    } else if (MIN(kScreenWidth, kScreenHeight) > 390) {
        //大于iPhone X
        return iPhoneSizeBig;
    }
    //MIN(kScreenWidth, kScreenHeight) == 320、375，iPhone 8, 12 mini
    return iPhoneSizeSmall;
}

@end
