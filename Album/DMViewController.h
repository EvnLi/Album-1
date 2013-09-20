//
//  DMViewController.h
//  DMFilterView
//
//  Created by Thomas Ricouard on 19/04/13.
//  Copyright (c) 2013 Thomas Ricouard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpPictureViewController.h"
#import "imageModeViewController.h"
#import "TheatreViewController.h"
#import "UserInformationViewController.h"
#import "SVProgressHUD.h"

@interface DMViewController : UIViewController < UITableViewDataSource,NSURLConnectionDelegate,NSURLConnectionDataDelegate, UITableViewDelegate,NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource>{
    UILabel            *UserNameLaber;
    UILabel            *Laber;
    UILabel            *albumNum;
    UILabel            *fansNum;
    NSMutableString    *PicturePath;
    NSMutableString    *UserNameStr;
    NSMutableString    *LaberStr;
    UIImageView        *PictureImageView;
    NSString           * picPathStr;
    NSString           *userNickNameStr;
    NSString           *userIdPathStr;
    NSMutableArray     *pictureArr;
    int                conTag;
    
}


@property (nonatomic,retain)  IBOutlet UILabel   *UserNameLaber;
@property (nonatomic,retain)  IBOutlet UILabel   *Laber;
@property (nonatomic,retain)  IBOutlet UILabel   *albumNum;
@property (nonatomic,retain)  IBOutlet UILabel   *fansNum;
@property (nonatomic,copy)    NSMutableString    *PicturePath;
@property (nonatomic,copy)    NSMutableString    *UserNameStr;
@property (nonatomic,copy)    NSMutableString    *LaberStr;
@property (nonatomic,retain)  IBOutlet UIImageView *PictureImageView;

@property (nonatomic, retain) NSString* userName;
@property (nonatomic, retain) NSString* userCode;
@property (nonatomic, retain) NSString* labelStr;
@property (nonatomic, retain) NSString* numberPic;
@property (nonatomic, retain) NSString* numberfans;
@property (nonatomic, retain) NSString* picPath;
@property (nonatomic, retain) NSString* picPathStr;
@property (nonatomic, retain) NSString* userIdPathStr;
@property (nonatomic, retain) NSString* tagPath;
@property (nonatomic,retain)  NSString *userNickNameStr;



@property (nonatomic,retain)  imageModeViewController  *imageModeTodo;
//@property (nonatomic,retain)    NSMutableArray *imageModeTodoList;
@property (nonatomic,retain)  NSMutableString *tempStr;
@property (nonatomic,retain)  NSMutableData   *receivedData;
@property (nonatomic,retain)  NSMutableDictionary *picDic;
@property (nonatomic,retain)  NSMutableString     *picTimeStr;
@property (nonatomic,assign) BOOL                    isLoadPic;
@property (nonatomic,assign) BOOL                  isFans;
    

//UItableView 表格显示
@property (nonatomic,retain)  UITableView        *tableView;
@property (nonatomic,retain)  NSMutableArray     *keystableView;
@property (nonatomic,retain)  NSString* urlstr;

//图片数据保存到本地
@property (nonatomic,retain) NSMutableDictionary *picDataDic;


@end
