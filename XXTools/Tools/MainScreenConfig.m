//
//  MainScreenConfig.m
//  plasticScan
//
//  Created by Jon on 2021/6/23.
//

#import "MainScreenConfig.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

@implementation MainScreenConfig

+ (void)config {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"完成"];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:80];
}

@end
