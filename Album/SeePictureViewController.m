//
//  SeePictureViewController.m
//  Album
//
//  Created by smq on 13-8-9.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "SeePictureViewController.h"

@interface SeePictureViewController ()

@end

@implementation SeePictureViewController

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
    SelectPicture = [[UIButton alloc]initWithFrame:CGRectMake(2, 160, 60, 40)];
    SelectPicture.titleLabel.text = @"选择图片";
    SelectPicture.backgroundColor = [UIColor blueColor];
    [SelectPicture addTarget:self action:@selector(SearchPicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SelectPicture];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)SearchPicture:(id)sender{
}

- (void)dealloc{
    [super dealloc];
    [SelectPicture release];
}
@end
