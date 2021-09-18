//
//  AppDelegate.m
//  tools
//
//  Created by TheChosenOne on 2021/9/17.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "XXTools.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ViewController *vc = [[ViewController alloc] init];
    self.window.rootViewController = vc;
    return YES;
}


@end
