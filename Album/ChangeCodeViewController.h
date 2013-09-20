//
//  ChangeCodeViewController.h
//  Album
//
//  Created by smq on 13-8-8.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChangeCodeViewController : UIViewController<NSURLConnectionDelegate,NSURLConnectionDataDelegate,NSXMLParserDelegate,UITextFieldDelegate>{

    UITextField *CurrentCode;
    UITextField *Code;
    UITextField *AgainCode;
    UILabel     *CurrentCodeLabel;
    UILabel     *CodeLabel;
    UILabel     *AgainCodeLabel;
    UINavigationBar  *navBar;
    UINavigationController *NavBarController;
    UIButton          *Submit;
}

@property (nonatomic,retain)  UITextField *CurrentCode;
@property (nonatomic,retain)  UITextField *Code;
@property (nonatomic,retain)  UITextField *AgainCode;
@property (nonatomic,retain)  UILabel     *CurrentCodeLabel;
@property (nonatomic,retain)  UILabel     *CodeLabel;
@property (nonatomic,retain)  UILabel     *AgainCodeLabel;
@property (nonatomic,retain) UIButton          *Submit;
@property (nonatomic,retain) NSMutableData     *receivedData;
@property (nonatomic,retain) NSMutableString   *tempStr;
@property (nonatomic,retain) NSString            *codePwd;
@property (nonatomic,retain) NSString            *userId;
@property (nonatomic,assign) BOOL               isChangeCode;
@end
