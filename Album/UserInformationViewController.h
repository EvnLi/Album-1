//
//  UserInformationViewController.h
//  Album
//
//  Created by smq on 13-8-14.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DialogView.h"

@interface UserInformationViewController : UIViewController<UITextFieldDelegate,NSXMLParserDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,UIScrollViewDelegate>{
    DialogView *dialongView;
    UIImageView     *imageView;
    UIButton        *modifyBtn;
    UILabel         *nameLab;
    UITextField     *nameTextField;
    UILabel         *tagLab;
    UILabel         *tagTextLab;
    UINavigationController *navCtrl;
    UINavigationBar  *navBar;
    UIButton        *suremodifyBtn;
    NSMutableArray  *imageArrStr;
    
}
@property (nonatomic,retain) UIImageView     *imageView;
@property (nonatomic,retain) UIButton        *modifyBtn;
@property (nonatomic,retain) UILabel         *nameLab;
@property (nonatomic,retain) UITextField     *nameTextField;
@property (nonatomic,retain) UILabel         *tagLab;
@property (nonatomic,retain) UILabel         *tagTextLab;
@property (nonatomic,retain) UIButton        *suremodifyBtn;
@property (nonatomic,retain) NSString        *tagPathStr;
@property (nonatomic,retain) NSString        *userNickNamePathStr;
@property (nonatomic,retain) IBOutlet UINavigationController *navCtrl;
@property (nonatomic,retain) IBOutlet UINavigationBar  *navBar;
@property (nonatomic,retain) NSMutableData     *receivedData;
@property (nonatomic,copy)   NSMutableString   *tempStr;
@property (nonatomic,copy)   NSMutableString   *userNickNameStr;
@property (nonatomic,retain) NSMutableArray    *imageArrStr;
@property (nonatomic,assign) BOOL              isModifyHead;
@property (nonatomic,copy) NSString           *picCopStry;



- (IBAction)returnBack:(id)sender;
@end
