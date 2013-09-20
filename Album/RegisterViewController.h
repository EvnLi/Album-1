//
//  RegisterViewController.h
//  Album
//
//  Created by smq on 13-8-7.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABCAppDelegate.h"
@interface RegisterViewController : UIViewController<UITextFieldDelegate,UITextFieldDelegate,NSURLConnectionDelegate,NSXMLParserDelegate,NSURLConnectionDataDelegate>{
    UILabel     *UserNameLable;
    UILabel     *SecretCodeLable;
    UILabel     *SecretCodeLableAgain;
    UITextField *UserNameField;
    UITextField *SecretCodeField;
    UITextField *SecretCodeFieldAgain;
    UINavigationBar  *navBar;
    UINavigationController *NavBarController;
    UIButton          *Submit;
    int               i;
    NSString         *userName;
    
    
}

@property (nonatomic,retain) UIButton *Submit;
@property (nonatomic,retain) UINavigationBar *RegisterBar;
@property (nonatomic,retain) UITextField *UserNameField;
@property (nonatomic,retain) UITextField *SecretCodeField;
@property (nonatomic,retain) UITextField *SecretCodeFieldAgain;
@property (nonatomic,retain) UILabel     *UserNameLable;
@property (nonatomic,retain) UILabel     *SecretCodeLable;
@property (nonatomic,retain) UILabel     *SecretCodeLableAgain;



@property (nonatomic,retain) NSString  *UserNameStr;
@property (nonatomic,retain) NSString  *SecretCodeStr;
@property (nonatomic,retain)  NSMutableData *receivedData;
@property (nonatomic, retain) NSMutableString *tempStr;
@property (nonatomic, retain) NSString *userName;


@end