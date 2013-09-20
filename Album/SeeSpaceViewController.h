//
//  SeeSpaceViewController.h
//  Album
//
//  Created by smq on 13-8-30.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imageModeViewController.h"
#import "SeeSpacePicViewController.h"


@interface SeeSpaceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    UINavigationBar *navBar;
    UINavigationItem *navItem;
    NSArray *seePicArr;
    NSMutableDictionary *picDic;
    NSString *attUserNickName;
    
    
}


@property (nonatomic,retain)UINavigationBar *navBar;
@property (nonatomic,retain)NSArray *seePicArr;
@property (nonatomic,retain)NSArray *receivedPicArr;
@property (nonatomic,retain)NSMutableDictionary *picDic;
@property (nonatomic,retain)NSMutableDictionary *receivedPicDic;
@property (nonatomic,retain)NSString *attUserNickName;
@property (nonatomic,retain)NSString *receivedNickName;

//UItableView 表格显示
@property (nonatomic,retain)  UITableView        *tableView;
@property (nonatomic,retain)  NSMutableArray     *keystableView;
@end
