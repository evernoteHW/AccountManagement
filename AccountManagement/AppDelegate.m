//
//  AppDelegate.m
//  AccountManagement
//
//  Created by WeiHu on 15/6/9.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "AppDelegate.h"
#import "UIImage+ImageFormColor.h"
#import "AddressBookDetailInfo.h"
#import "AVOSCloud.h"
#import "UserLoginModel.h"
#import "MenuItemModel.h"
#import "MainfestModel.h"
#import "DisburseModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self avobjectDefalutSettings];
    [AVOSCloud setApplicationId:@"695os0990ym1fkbm4k6dco5cs93q4qfcw5txppw4622ait69"
                      clientKey:@"y0acg04szjo2w2eatfocm0n9qhavtgc9s8e1xansx00ytkp5"];
    [self viewsDefaultSettings];
//     [self dataDefaultSettings];
    [self initViewControllers];
    
    return YES;
}

- (void)viewsDefaultSettings
{
    [[UITabBar appearance] setTintColor:[UIColor colorWithR:252 G:85 B:112]];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithR:240 G:120 B:122]];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithR:240 G:120 B:122]];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    id barButtonAppearanceInSearchBar = [UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:@{
                                                                                                   NSFontAttributeName : [UIFont systemFontOfSize:15.0f],
                                                                                                   NSForegroundColorAttributeName : [UIColor colorWithR:240 G:120 B:122]                                                             } forState:UIControlStateNormal];
    [barButtonAppearanceInSearchBar setTitle:@"取消"];
}
- (void)avobjectDefalutSettings
{
    [BaseDataModel registerSubclass];
    [AddressBookDetailInfo registerSubclass];
    [UserLoginModel registerSubclass];
    [MenuItemModel registerSubclass];
    [MainfestModel registerSubclass];
    [CashierModel registerSubclass];
    [OrderInfoModel registerSubclass];
    [DisburseModel registerSubclass];
}
- (void)initViewControllers
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor colorWithR:186 G:185 B:192];
    
    UserLoginModel *currentUser = [UserLoginModel currentUser];
    if (currentUser != nil) {
//         允许用户使用应用
        [UIApplication sharedApplication].keyWindow.rootViewController = [self instantiateViewControllerWithIdentifier:@"RootTabBarViewController"];
    } else {
        //缓存用户对象为空时，可打开用户注册界面…
         [UIApplication sharedApplication].keyWindow.rootViewController = [self instantiateViewControllerWithIdentifier:@"LoginAndRegiestNavigationController"];
    }

}
- (void)dataDefaultSettings
{

}
- (UIViewController *)instantiateViewControllerWithIdentifier:(NSString *)identifier
{
   return  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:identifier];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
