//
//  ABCAppDelegate.h
//  Album
//
//  Created by smq on 13-8-7.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMViewController.h"
#import "UpPictureViewController.h"
#import "TagViewController.h"
#import "OthersViewController.h"
#import "ConnectViewController.h"
#import "TheatreViewController.h"
#import "TheaterModeViewController.h"
@class ABCViewController;

@interface ABCAppDelegate : UIResponder <UIApplicationDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,NSXMLParserDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ABCViewController *viewController;

@property (nonatomic, retain) UITabBarController* tabBarCtr;
@property (nonatomic, retain) DMViewController* dmVc;
@property (nonatomic, retain) UpPictureViewController* upPicVc;
@property (nonatomic, retain) TagViewController* tagVc;
@property (nonatomic, retain) OthersViewController* otherVc;
@property (nonatomic, retain) ConnectViewController* connectVc;
@property (nonatomic, retain) TheatreViewController* theatreVc;
@property (nonatomic, retain) TheaterModeViewController* theatreModeVc;
//加载图片
@property (nonatomic,retain)  imageModeViewController  *imageModeTodo;
@property (nonatomic,copy)    NSMutableArray *imageModeTodoList;
@property (nonatomic,retain)  NSMutableString *tempStr;
@property (nonatomic,retain)  NSMutableData   *receivedData;
@property (nonatomic,retain)  NSMutableDictionary *picDic;

@property (nonatomic,retain)   UINavigationController *navCtl;

+ (void) showStatusWithText:(NSString *) string duration:(NSTimeInterval) duration;
- (void) loginSuccess:(DMViewController*) dm;


@end
