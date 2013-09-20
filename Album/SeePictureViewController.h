//
//  SeePictureViewController.h
//  Album
//
//  Created by smq on 13-8-9.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeePictureViewController : UIViewController{
    UIButton *SelectPicture;
    UILabel  *AddressLab;
    UILabel  *AddressLabInput;
    UILabel  *TagLab;
    UILabel  *TagLabInput;
    UILabel  *FriendsLab;
    UILabel  *FriendsLabInput;
    UIButton *UpBtn;
}
@property (nonatomic,retain) UIButton *SelectPicture;
@property (nonatomic,retain) UILabel  *AddressLab;
@property (nonatomic,retain) UILabel  *AddressLabInput;
@property (nonatomic,retain) UILabel  *TagLab;
@property (nonatomic,retain) UILabel  *TagLabInput;
@property (nonatomic,retain) UILabel  *FriendsLab;
@property (nonatomic,retain) UILabel  *FriendsLabInput;
@property (nonatomic,retain) UIButton *UpBtn;
@end
