//
//  ABCAppDelegate.m
//  Album
//
//  Created by smq on 13-8-7.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "ABCAppDelegate.h"

#import "ABCViewController.h"

@interface ABCAppDelegate ()

@property (nonatomic, strong) UIWindow * statusWindow;
@property (nonatomic, strong) UILabel * statusLabel;

- (void) dismissStatus;

@end

@implementation ABCAppDelegate
- (void) dealloc{
    [_viewController release],_viewController = nil;
    self.dmVc = nil;
    self.upPicVc = nil;
    self.tagVc = nil;
    self.tabBarCtr = nil;
    self.theatreModeVc = nil;
    
    self.navCtl = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
     self.viewController = [[ABCViewController alloc]init];
    self.navCtl = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    [self.viewController.navigationItem setTitle:@"登录"];
    [self.viewController.navigationController.navigationBar setTintColor:[UIColor redColor]];
//    self.viewController = [[ABCViewController alloc] initWithNibName:@"ABCViewController" bundle:nil];
    self.window.rootViewController = self.navCtl;
    [self.window makeKeyAndVisible];
    return YES;
}

+ (void) showStatusWithText:(NSString *) string duration:(NSTimeInterval) duration{
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
