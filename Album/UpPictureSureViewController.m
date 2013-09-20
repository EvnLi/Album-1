//
//  UpPictureSureViewController.m
//  Album
//
//  Created by smq on 13-8-17.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "UpPictureSureViewController.h"

@interface UpPictureSureViewController ()

@end

@implementation UpPictureSureViewController
@synthesize imageViewUpPicture;

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
    imageViewUpPicture = [[UIImageView alloc]initWithFrame: CGRectMake(self.view.frame.size.width - 50, 80, 100, 100)];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];

        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    //    isFullScreen = NO;
      [imageViewUpPicture setImage:savedImage];
    //
    //    self.imagView.tag = 100;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [super dealloc];
    [imageViewUpPicture release];
}

@end
