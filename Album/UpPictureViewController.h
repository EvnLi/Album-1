//
//  UpPictureViewController.h
//  Album
//
//  Created by smq on 13-8-9.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface UpPictureViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
//    UINavigationBar   *NavBar;
//    UINavigationController *NavBarController;
    UIImageView       *pictureImag;
    UIButton *SelectPicture;
    UILabel  *AddressLab;
    UITextField  *AddressLabInput;
    UILabel  *TagLab;
    UITextField  *TagLabInput;
    UILabel  *FriendsLab;
    UITextField  *FriendsLabInput;
    UIButton *UpBtn;
    NSString    *userId;
    NSString    *receiveUserId;
    
    CLLocationManager    *locManager;
}
@property (nonatomic,retain) UIButton *SelectPicture;
@property (nonatomic,retain) IBOutlet UILabel  *AddressLab;
@property (nonatomic,retain) IBOutlet UITextField  *AddressLabInput;
@property (nonatomic,retain) IBOutlet UILabel  *TagLab;
@property (nonatomic,retain) IBOutlet UITextField  *TagLabInput;
@property (nonatomic,retain) IBOutlet UILabel  *FriendsLab;
@property (nonatomic,retain) IBOutlet UITextField  *FriendsLabInput;
@property (nonatomic,retain) UIButton *UpBtn;
//@property (nonatomic,retain) IBOutlet UINavigationBar   *NavBar;
//@property (nonatomic,retain) IBOutlet UINavigationController *NavBarController;
@property (nonatomic,retain) CLLocationManager    *locManager;
@property (nonatomic,retain) NSMutableString      *locCoordinateStr;
@property (nonatomic,retain) NSString    *userId;
@property (nonatomic,retain) NSString    *receiveUserId;

- (IBAction)Return:(id)sender;
@end
