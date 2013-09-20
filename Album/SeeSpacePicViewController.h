//
//  SeeSpacePicViewController.h
//  Album
//
//  Created by smq on 13-9-9.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imageModeViewController.h"
#import "CustomTableViewCell.h"
#import "MapViewController.h"
#import "DisMode.h"
#import "TheaterModeViewController.h"

@interface SeeSpacePicViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,NSXMLParserDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>{
    MapViewController *mapView;
    DisMode   *disMode;
    UINavigationBar *navBar;
    UINavigationItem *navItem;
    NSMutableArray *spacePicArr;
    NSMutableString *spacePicTitleStr;
    NSMutableDictionary *downDicPic;
    NSMutableArray          *disArr;
    NSMutableData      *receivedData;
    int                 disTag;
    int                 disCount;
}

@property (nonatomic,retain) MapViewController *mapView;
@property (nonatomic,retain) UINavigationBar *navBar;
@property (nonatomic,retain) UINavigationItem *navItem;
@property (nonatomic,retain) NSMutableArray *spacePicArr;
@property (nonatomic,retain) NSMutableArray *receivedPicArr;
@property (nonatomic,retain) UITableView *tableViewPic;
@property (nonatomic,retain) NSMutableString *spacePicTitleStr;
@property (nonatomic,retain) NSMutableString *receivedTitleStr;
@property (nonatomic,retain) NSMutableDictionary *downDicPic;
@property (nonatomic,retain) NSMutableArray          *disArr;
@property (nonatomic,retain) NSMutableData      *receivedData;
@property (nonatomic,retain) NSMutableString    *tempStr;
@property (nonatomic,retain) NSString    *disTextStr;
@property (nonatomic,copy)   NSString                *addDisPicStr;
@property (nonatomic,assign) BOOL         isLove;
@property (nonatomic,assign) BOOL                    isDis;
@property (nonatomic,assign) BOOL                    isDisUp;
@property (nonatomic,assign) BOOL                    isDisEmpty;
@property (nonatomic,assign) BOOL                    isDiscomment;
@end
