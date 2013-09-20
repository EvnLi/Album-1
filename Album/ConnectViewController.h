//
//  ConnectViewController.h
//  Album
//
//  Created by smq on 13-8-9.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HaveAttentionMode.h"
#import "ConnectSearchMode.h"
#import "ConnectNameMessageViewController.h"

@interface ConnectViewController : UIViewController<NSURLConnectionDelegate,NSXMLParserDelegate,NSURLConnectionDataDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{

    UITextField *searchText;
    UIButton    *searchBtn;
    NSMutableData *receivedData;
    NSString      *userNameCon;
    NSString      *userTagCon;
    NSString      *userPicCon;
    NSMutableArray  *userAllSearchArr;
    ConnectSearchMode *searchTodo;
    HaveAttentionMode *haveAttentionTodo;
    //表格视图
    UITableView     *tableViewCon;
    NSUserDefaults  *ud;
    int             ConTags;
    int             haveAttCount;
}

@property (nonatomic,retain) UITextField *searchText;
@property (nonatomic,retain) UIButton    *searchBtn;
@property (nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic,retain) NSMutableString *tempStr;
@property (nonatomic,copy)   NSString      *attTempStr;
@property (nonatomic,retain) NSString      *userNameCon;
@property (nonatomic,retain) NSString      *userTagCon;
@property (nonatomic,retain) NSString      *userPicCon;
@property (nonatomic,retain) NSMutableArray *userAllSearchArr;
@property (nonatomic,retain) ConnectSearchMode *searchTodo;
@property (nonatomic,retain) HaveAttentionMode *haveAttentionTodo;

//表格视图
@property (nonatomic,retain) UITableView    *tableViewCon;
@property (nonatomic,retain) NSString       *attIdCon;
@property (nonatomic,assign) BOOL           isConcern;
@property (nonatomic,assign) BOOL           isHaveConcern;
@property (nonatomic,assign) BOOL           isHaveConcernId;
@property (nonatomic,retain) NSMutableArray *userSearchHaveConcernArr;
@property (nonatomic,retain) NSMutableArray *userHaveAttentionIdArr;
@property (nonatomic,retain) NSMutableArray  *userAttAllSearchArr;
@property (nonatomic,retain) NSMutableArray  *userHaveAttentionIdArrCopy;
@property (nonatomic,retain) NSMutableArray   *removeArr;

@property (nonatomic, assign) BOOL isSearch;
@property (nonatomic, assign) BOOL isCancelAtt;
@property (nonatomic, assign) BOOL isAddAtt;
@property (nonatomic, assign) int  judgeTag;

@end


