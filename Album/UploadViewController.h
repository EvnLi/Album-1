//
//  UploadViewController.h
//  Album
//
//  Created by fhkj on 13-8-28.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCAlbumPickerController.h"
#import "ELCImagePickerController.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import <CoreLocation/CoreLocation.h>
#import "DialogCreateAblumView.h"
#import "TagsView.h"

@interface UploadViewController : UIViewController<ELCImagePickerControllerDelegate,UIAlertViewDelegate,ASIHTTPRequestDelegate,CLLocationManagerDelegate,UITextFieldDelegate,DialogCreateAblumViewDelegate,TagsViewDelegate>

@end
