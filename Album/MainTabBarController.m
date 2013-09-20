//
//  MainTabBarController.m
//  Album
//
//  Created by fhkj on 13-9-13.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "MainTabBarController.h"
#import "DMViewController.h"
#import "UploadViewController.h"
#import "TagViewController.h"
#import "OthersViewController.h"
#import "ConnectViewController.h"
#import "TheatreViewController.h"
#import "TheaterModeViewController.h"

@implementation MainTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DMViewController *dmVc = [[DMViewController alloc] init];
    dmVc.title = @"首页";
    dmVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"one.png"] tag:1];
    [dmVc.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"home_checked.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"home_normal.png"]];
    UINavigationController *dmCtl = [[UINavigationController alloc]initWithRootViewController:dmVc];
    
    ConnectViewController *connectVc = [[ConnectViewController alloc]init];
    connectVc.title = @"关注";
    connectVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"关注" image:[UIImage imageNamed:@"att_normal.png"] tag:2];
    [connectVc.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"att_checked.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"att_normal.png"]];
    UINavigationController *connectCtl = [[UINavigationController alloc]initWithRootViewController:connectVc];
    
    UploadViewController *upPicVc = [[UploadViewController alloc]init];
    upPicVc.title = @"上传";
    upPicVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"上传" image:[UIImage imageNamed:@"upload_normal.png"] tag:3];
    [upPicVc.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"upload_checked.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"upload_normal.png"]];
    UINavigationController *upCtl = [[UINavigationController alloc]initWithRootViewController:upPicVc];
    
    TagViewController *tagVc = [[TagViewController alloc] init];
    tagVc.title = @"标签";
    tagVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"标签" image:[UIImage imageNamed:@"tag_normal.png"] tag:4];
    [tagVc.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tag_checked.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tag_normal.png"]];
    UINavigationController *tagCtl = [[UINavigationController alloc]initWithRootViewController:tagVc];
    
    OthersViewController *otherVc = [[OthersViewController alloc] init];
    otherVc.title = @"设置";
    otherVc.tabBarItem = [[UITabBarItem alloc]init];
    otherVc.tabBarItem.title = @"设置";
    otherVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"设置" image:[UIImage imageNamed:@"setting_normal.png"] tag:5];
    [otherVc.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"setting_checked.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"setting_normal.png"]];
    UINavigationController *otherCtl = [[UINavigationController alloc]initWithRootViewController:otherVc];
    
    self.viewControllers = [NSArray arrayWithObjects:dmCtl,connectCtl,upCtl,tagCtl,otherCtl, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
