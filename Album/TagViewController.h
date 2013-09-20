//
//  TagViewController.h
//  Album
//
//  Created by smq on 13-8-8.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
@interface TagViewController : UIViewController

@end
 */
#import <UIKit/UIKit.h>

#import "OthersViewController.h"
#import "TagMode.h"

@interface TagViewController : UIViewController < UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,NSXMLParserDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>{

    TagMode                *tagModetodo;
    UILabel                *tagLab;
    UILabel                *tagInterstingLab;
    UILabel                *tagLeftLab;
    NSString               *tagNameStr;
    NSString               *tagNameStrArr;
    NSMutableArray         *tagNameArr;
    NSMutableArray         *tagNameArrAll;
}



@property (nonatomic,copy)    NSString               *tagNameStr;
@property (nonatomic,copy)    NSString               *tagNameStrArr;
@property (nonatomic,retain)  UILabel                *tagLab;
@property (nonatomic,retain)  UILabel                *tagInterstingLab;
@property (nonatomic,retain)  UILabel                *tagLeftLab;
@property (nonatomic,retain)  NSMutableData          *receivedData;
@property (nonatomic,retain)  NSMutableString        *tempStr;
@property (nonatomic,retain)  TagMode                *tagModetodo;
@property (nonatomic,retain)  NSMutableArray         *tagRecommendArr;
@property (nonatomic,retain)  NSMutableArray         *tagInterestArr;
@property (nonatomic,retain)  NSMutableArray         *leftTagArr;
@property (nonatomic,assign)  BOOL                   isAddTag;
@property (nonatomic,assign)  BOOL                   isRecommendTag;

@end
