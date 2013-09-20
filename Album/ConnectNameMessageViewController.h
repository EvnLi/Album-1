//
//  ConnectNameMessageViewController.h
//  Album
//
//  Created by smq on 13-8-25.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imageModeViewController.h"
#import "SeeSpaceViewController.h"


@interface ConnectNameMessageViewController : UIViewController<NSURLConnectionDelegate,NSXMLParserDelegate,NSURLConnectionDataDelegate>{
    UINavigationBar  *navBar;
    UINavigationItem *navItem;
    UIImageView      *userHeadPic;
    UILabel          *nickNameLabel;
    UILabel          *nickName;
    UILabel          *tagLabel;
    UILabel          *tag;
    UILabel          *fansLabel;
    UILabel          *fansNumber;
    UILabel          *connectLabel;
    UILabel          *connectNumber;
    UILabel          *albumLabel;
    UILabel          *albumLabelStr;
    NSString         *UserId;
    NSString         *reciveUserId;
    //用户数据下载
    NSMutableData    *receivedData;
    NSString         *userName;
    NSString         *userNickName;
    NSString         *userTag;
    NSString         *userPic;
    NSString         *userPwd;
    int              fans;
    int              attentions;
}

@property (nonatomic,retain) UINavigationBar  *navBar;
@property (nonatomic,retain) UINavigationItem *navItem;
@property (nonatomic,retain) UIImageView      *userHeadPic;
@property (nonatomic,retain) UILabel          *nickNameLabel;
@property (nonatomic,retain) UILabel          *nickName;
@property (nonatomic,retain) UILabel          *tagLabel;
@property (nonatomic,retain) UILabel          *tag;
@property (nonatomic,retain) UILabel          *fansLabel;
@property (nonatomic,retain) UILabel          *fansNumber;
@property (nonatomic,retain) UILabel          *connectLabel;
@property (nonatomic,retain) UILabel          *connectNumber;
@property (nonatomic,retain) UILabel          *albumLabel;
@property (nonatomic,retain) UILabel          *albumLabelStr;
@property (nonatomic,retain) NSString         *reciveUserId;
@property (nonatomic,retain) NSString         *UserId;
//用户数据下载
@property (nonatomic,retain) NSMutableString  *tempStr;
@property (nonatomic,retain) NSString         *tempStrCopy;
@property (nonatomic,retain) NSMutableData    *receivedData;
@property (nonatomic,retain) NSString         *userName;
@property (nonatomic,retain) NSString         *userNickName;
@property (nonatomic,retain) NSString         *userTag;
@property (nonatomic,retain) NSString         *userPic;
@property (nonatomic,retain) NSString         *userPwd;
@property (nonatomic,retain) imageModeViewController  *imageModeTodo;
@property (nonatomic,retain)  NSMutableDictionary  *picDic;
@property (nonatomic,retain)  NSMutableArray         *keyPicArr;
@property (nonatomic,assign)  BOOL              isFans;
@property (nonatomic,assign)  BOOL              isAttantion;
@property (nonatomic,assign)  BOOL              isUser;
@property (nonatomic,assign)  BOOL              isPhotos;

@property (nonatomic,retain)  NSString         *reciveUserNickName;
@property (nonatomic,retain)  NSString         *reciveUserTag;
@property (nonatomic,retain)  NSString         *userHeadPicStr;
@property (nonatomic,retain)  NSString         *reciveUserHeadPic;


@end
