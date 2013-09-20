//
//  TheatreViewController.h
//  Album
//
//  Created by smq on 13-8-21.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imageModeViewController.h"
#import "MapViewController.h"
#import "TheaterModeViewController.h"
#import "DisMode.h"

@interface TheatreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,UITextViewDelegate>{
    NSMutableArray         *theatrePicArr;
    NSString               *theatreTitleStr;
    IBOutlet UINavigationItem       *navItem;
    //列表显示照片信息
    UITableView             *tableViewPic;
    NSString                *userNameStr;
    //评论信息
    NSString                *disName;
    NSString                *disContent;
    NSMutableData           *receivedData;
    NSString                *disId;
    DisMode                 *disMode;
    NSMutableArray          *disArr;
    UITextView              *discussLableInput;
    NSString                *disTextStr;
    int                      disCount;
    int                      disTag;
    
}
@property (nonatomic,retain) IBOutlet UINavigationController *navCon;
@property (nonatomic,retain) IBOutlet UINavigationBar        *navBar;
@property (nonatomic,retain) NSMutableArray         *theatrePicArr;
@property (nonatomic,retain) NSMutableArray         *theatrePicArrCopy;
@property (nonatomic,retain) NSString               *theatreTitleStr;
@property (nonatomic,retain) UINavigationItem       *navItem;

@property (nonatomic,retain) UITableView             *tableViewPic;
@property (nonatomic,retain) NSString                *userNameStr;
@property (nonatomic,retain) NSMutableDictionary* pictures;


@property (nonatomic,retain) NSMutableDictionary     *downDicPic;
@property (nonatomic,retain) NSMutableData           *receivedData;
@property (nonatomic,retain) NSMutableString         *tempStr;
@property (nonatomic,copy)   NSMutableString         *disTempStr;
@property (nonatomic,retain) NSString                *disName;
@property (nonatomic,retain) NSString                *disContent;
@property (nonatomic,copy)   NSString                *addDisPicStr;
@property (nonatomic,retain) NSMutableArray          *disArr;
@property (nonatomic,assign) BOOL                    isLove;
@property (nonatomic,assign) BOOL                    isDis;
@property (nonatomic,assign) BOOL                    isDisUp;
@property (nonatomic,assign) BOOL                    isDisEmpty;
@property (nonatomic,assign) BOOL                    isDiscomment;
@property (nonatomic,retain) NSString                *disTextStr;
- (IBAction)returnBack:(id)sender;
- (IBAction)theatreMode:(id)sender;
@end
