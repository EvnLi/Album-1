//
//  ABCViewController.h
//  Album
//
//  Created by smq on 13-8-7.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterViewController.h"
#import "DMViewController.h"
#import "imageModeViewController.h"
#import "MainTabBarController.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"

@interface ABCViewController : UIViewController<UITextFieldDelegate,NSURLConnectionDelegate,NSXMLParserDelegate,NSURLConnectionDataDelegate,UIAlertViewDelegate>{
    DMViewController       *Dm;
    UILabel     *UserNameLable;
    UILabel     *SecretCodeLable;
    UILabel     *automaticLandingLable;
    UITextField *UserName;
    UITextField *SecretCode;
    UIButton    *Register;
    UIButton    *Landing;
    UIButton    *CheckBtn;
    BOOL        CheckSelect;
    NSMutableData *receivedData;
    NSString    *userId;
    NSString    *userName;
    NSString    *userPwd;
    NSString    *userNickName;
    NSString    *userTag;


}
@property (nonatomic,retain) DMViewController       *Dm;
@property (nonatomic,retain) IBOutlet UITextField *UserName;
@property (nonatomic,retain) IBOutlet UITextField *SecretCode;
@property (nonatomic,retain)  UIButton  *Register;
@property (nonatomic,retain)  UIButton *Landing;
@property (nonatomic,retain)  UIButton *CheckBtn;
@property (nonatomic,retain)  NSMutableData *receivedData;
@property (nonatomic,retain)  NSString    *userId,*userPwd,*userNickName,*userTag,*userPic, *userName;
@property (nonatomic, retain) NSMutableString *tempStr;
@property (nonatomic,retain)  NSString *UserNameStr;
@property (nonatomic,retain)  NSString *SecretCodeStr;
@property (nonatomic,assign)  BOOL      isLogin;
@property (nonatomic,retain)  MBProgressHUD *progressHud;


-(IBAction )RegisterChange:(id)sender;
-(IBAction)LandingChange:(id)sender;
-(IBAction)CheckSelect:(id)sender;

@end
