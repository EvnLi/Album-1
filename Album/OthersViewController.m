//
//  OthersViewController.m
//  Album
//
//  Created by smq on 13-8-8.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "OthersViewController.h"


@interface OthersViewController ()

@end

@implementation OthersViewController


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
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];

    
    
    UIButton *CheckBtn = [[UIButton alloc]initWithFrame:CGRectMake(19, 84, 34, 28)];
    [CheckBtn setImage:[UIImage imageNamed:@"exit.png"] forState:UIControlStateNormal];
    [CheckBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    CheckBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:CheckBtn];
    
    UIButton *CheckBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(117, 84, 34, 28)];
    [CheckBtn1 setImage:[UIImage imageNamed:@"user.png"] forState:UIControlStateNormal];
    [CheckBtn1 addTarget:self action:@selector(BtnAction1:) forControlEvents:UIControlEventTouchUpInside];
    CheckBtn1.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:CheckBtn1];
    
    UIButton *CheckBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(223, 84, 34, 28)];
    [CheckBtn2 setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
    [CheckBtn2 addTarget:self action:@selector(BtnAction2:) forControlEvents:UIControlEventTouchUpInside];
    CheckBtn2.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:CheckBtn2];
    
    UIButton *CheckBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(19, 200, 34, 28)];
    [CheckBtn3 setImage:[UIImage imageNamed:@"about.png"] forState:UIControlStateNormal];
    [CheckBtn3 addTarget:self action:@selector(BtnAction3:) forControlEvents:UIControlEventTouchUpInside];
    CheckBtn3.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:CheckBtn3];
    
    UIButton *CheckBtn4 = [[UIButton alloc]initWithFrame:CGRectMake(120,  200, 34, 28)];
    [CheckBtn4 setImage:[UIImage imageNamed:@"tuichu.png"] forState:UIControlStateNormal];
    [CheckBtn4 addTarget:self action:@selector(BtnAction4:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CheckBtn4];
    
    [CheckBtn release];
    [CheckBtn1 release];
    [CheckBtn2  release];
    [CheckBtn3  release];
    [CheckBtn4  release];
    // Do any additional setup after loading the view from its nib.
}
- (void)BtnAction:(id)sender{
    alertView3 = [[UIAlertView alloc]initWithTitle:@"注销" message:@"是否注销" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" , nil];
    alertView3.tag = 2;
    [alertView3 show];
    
}
- (void)BtnAction1:(id)sender{

    UserInformationViewController *Information = nil;
    Information = [[UserInformationViewController alloc]init];
    [Information setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:Information animated:YES completion:nil];

    
}
- (void)BtnAction2:(id)sender{
    
    ChangeCodeViewController *ChangeCode = nil;
    ChangeCode  = [[ChangeCodeViewController alloc]init];
    [ChangeCode setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:ChangeCode animated:YES completion:nil];
    

    
}

- (void)BtnAction4:(id)sender{
       
   alertView2 = [[UIAlertView alloc]initWithTitle:@"退出" message:@"是否退出" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" , nil];
    alertView2.tag = 0;
    [alertView2 show];
    [alertView2 release];
         

}
- (void)BtnAction3:(id)sender{

    alertView1 = [[UIAlertView alloc]initWithTitle:@"关于我们" message:@"相册管理工具" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alertView1.tag = 1;
    [alertView1 show];
    [alertView1 release];
   
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView tag] == 0) {
        if (buttonIndex == 0){
            exit(0);
        }
    else if (buttonIndex == 1)
    {
    }
    }
    if ([alertView3 tag] == 2) {
        if (buttonIndex == 0) {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:@"" forKey:@"automaticLandingUserName"];
            [ud setObject:@"" forKey:@"automaticLandingUserCode"];
            [ud setBool:NO forKey:@"automaticLandingTag"];
            [self.tabBarController.navigationController setNavigationBarHidden:YES];
            [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [super dealloc];

}

@end
