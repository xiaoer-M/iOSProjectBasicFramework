//
//  AppDelegate.m
//  i84zcc
//
//  Created by 小二 on 2019/9/2.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "AppDelegate.h"

#import "ZCInfoTool.h"
#import "ZCTabBarController.h"
#import "GuildViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 项目网络请求默认配置
    [self networkConfig];
    
    // 设置初始界面
    [self p_setupRootViewController];
    
    [NSThread sleepForTimeInterval:1.0];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)networkConfig {
    // http://zccc.ngrok.i84.com.cn   测试
    // https://zccc.5i84.cn 正式
    [XENetworkConfig sharedConfig].baseUrl = [NSBundle mainBundle].infoDictionary[@"ZC_BASE_URL"];
    [XENetworkConfig sharedConfig].defaultParams = @{@"apptype": @"ios", @"version": [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]};
    [XENetworkConfig sharedConfig].debugLog = YES;
}

- (void)p_setupRootViewController {
    /*************引导页**************/
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (![[ZCInfoTool getValueWithKey:AppVersion] isEqualToString:version]) {
        self.window.rootViewController = [GuildViewController new];
    } else {
        self.window.rootViewController = [ZCTabBarController new];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
