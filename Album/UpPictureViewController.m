//
//  UpPictureViewController.m
//  Album
//
//  Created by smq on 13-8-9.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "UpPictureViewController.h"
#import "ASIFormDataRequest.h"

@interface UpPictureViewController ()

@end

@implementation UpPictureViewController

//- (id) init{
//    self = [super init];
//    if (self) {
//        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -8);
//        [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:25.f] forKey:UITextAttributeFont] forState:UIControlStateNormal];
//        self.tabBarItem.title = @"上传";
//    }
//    return self;
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-18)];

    AddressLab.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    AddressLabInput.delegate = self;
    AddressLabInput.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    TagLab.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    TagLabInput.delegate = self;
    TagLabInput.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    FriendsLab.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    FriendsLabInput.delegate = self;
    FriendsLabInput.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;

    CGRect rect;
    rect = [[UIApplication sharedApplication] statusBarFrame];
    SelectPicture = [[UIButton alloc]initWithFrame:CGRectMake(rect.size.width/4 - 30, 80, 60, 40)];
    SelectPicture.backgroundColor = [UIColor grayColor];
    [SelectPicture setTitle:@"选择图片" forState:UIControlStateNormal];
    [SelectPicture setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    SelectPicture.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    SelectPicture.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [SelectPicture addTarget:self action:@selector(SearchPicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SelectPicture];
    
    
    
    UpBtn = [[UIButton alloc]initWithFrame:CGRectMake(3*rect.size.width/4 - 30, 80, 60, 40)];
    UpBtn.backgroundColor = [UIColor grayColor];
    [UpBtn setTitle:@"上传" forState:UIControlStateNormal];
    [UpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UpBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    UpBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [UpBtn addTarget:self action:@selector(SureUpPicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:UpBtn];
//    AddressLab      = [[UILabel alloc]initWithFrame:CGRectMake(20, 130, 40, 40)];
//    AddressLab.text = @"地点:";
//    [AddressLab setFont:[UIFont systemFontOfSize:4.0f]];
//    [self.view addSubview:AddressLab];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [AddressLabInput resignFirstResponder];
    [TagLabInput resignFirstResponder];
    [FriendsLabInput resignFirstResponder];
    return YES;
}

#pragma 查找手机本地相册
- (void)SearchPicture:(id)sender{
    UIImagePickerController   *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    [self presentModalViewController:imagePicker animated:YES];

}
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:^{}];
}



- (void)SureUpPicture:(id)sender{
    
    self.locManager = [[CLLocationManager alloc] init];
    self.locManager.delegate = self;
    self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locManager.distanceFilter = 5.0;
    [self.locManager startUpdatingLocation];
    receiveUserId  = [[NSString alloc]init];
    receiveUserId = self.userId;

    //确定上传链接服务器代码
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    //    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    NSData *imageData = [NSData dataWithContentsOfFile:fullPath];
    NSURL *url = [[NSURL alloc]initWithString:@"http://192.168.1.108:8080/PhotosServer/servlet/uploadios"];
    ASIFormDataRequest *formRq = [[ASIFormDataRequest alloc] initWithURL:url];
    //    [formRq setPostValue:@"lifeng" forKey:@"token"];
    //    [formRq setPostValue:@"jj" forKey:@"appType"];
    [formRq   setPostValue:receiveUserId forKey:@"userId"];
    [formRq   setPostValue:@"asdas.png" forKey:@"url"];
    [formRq   setPostValue:imageData forKey:@"filecontent"];
    [formRq   setDelegate:self];
    [formRq   setTimeOutSeconds:10.0f];
    [formRq   setDidFinishSelector:@selector(finishPicUpload:)];
    [formRq   setDidFailSelector:@selector(faiPicUpload:)];
    [formRq   start];
}

//确定上传链接服务器代码
- (void) finishPicUpload:(id)sender{
    NSMutableURLRequest *rq = [[NSMutableURLRequest alloc]init];
    NSString *str = [[NSString alloc]initWithFormat:@"%@Photos?method=insert&wherepicAddress=(string)%@&wherepicTag=(string)%@&wherepicFriend=(string)%@",kURL,AddressLabInput.text,TagLabInput.text,FriendsLabInput];
    [rq setURL:[NSURL URLWithString:str]];
    NSURLConnection *cn = [[NSURLConnection alloc]initWithRequest:rq delegate:self];
    [str release];
    [cn release];

}

- (void) faiPicUpload:(id)sender{
    
}

#pragma CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
   _locCoordinateStr = [[NSMutableString alloc]initWithFormat:@"%f,%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
}
- (IBAction)Return:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc{
    [super dealloc];
    [SelectPicture release];
}

@end
