//
//  ABCViewController.m
//  Album
//
//  Created by smq on 13-8-7.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "ABCViewController.h"
#import <sqlite3.h>
#import "ABCAppDelegate.h"
#import "Reachability.h"
#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
@interface ABCViewController ()

@end
@implementation ABCViewController
@synthesize UserName,SecretCode,Register,Landing,CheckBtn,Dm,receivedData;
@synthesize userId, userName,userPwd,userNickName,userTag;

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
    
    Dm = [[DMViewController alloc]init];
    UserName.delegate = self;
    UserName.textAlignment = NSTextAlignmentLeft;
    [UserName setPlaceholder:@"用户名"];
    UserName.clearsOnBeginEditing = YES;
    UserName.clearButtonMode = UITextFieldViewModeAlways;
    UserName.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    SecretCode.delegate = self;
    SecretCode.textAlignment = NSTextAlignmentLeft;
    SecretCode.secureTextEntry = YES;
    [SecretCode setPlaceholder:@"密码"];
    SecretCode.clearsOnBeginEditing = YES;
    SecretCode.clearButtonMode = UITextFieldViewModeAlways;
    SecretCode.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    UserNameLable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    SecretCodeLable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    automaticLandingLable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
//    [self.navigationController.navigationItem setTitle:@"登录"];

    CheckBtn = [[UIButton alloc]initWithFrame:CGRectMake(76, 200, 34, 28)];

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:@"automaticLandingTag"]) {
        [CheckBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }
    else{
    [CheckBtn setImage:[UIImage imageNamed:@"unchecked(1).png"] forState:UIControlStateNormal];
    }
    [CheckBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    CheckBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:CheckBtn];

    CheckSelect = YES;
    
    self.receivedData = [[NSMutableData alloc] init];
    self.tempStr = [[NSMutableString alloc] init];
    //判断网络是否连接
    if ([self judgeNetWork] ) {
        //自动登陆
        if ([ud boolForKey:@"automaticLandingTag"]&&([[ud objectForKey:@"automaticLandingUserName"]isEqualToString:@""] == NO)) {
            [self LandingChange:self];
        }
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"网络" message:@"连接失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }
    
    
}
#pragma mark judgeNetWork
- (BOOL)judgeNetWork{
    BOOL isExistenceNetwork = YES;
    Reachability *r= [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
            
        default:
            break;
    }
    return isExistenceNetwork;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction )RegisterChange:(id)sender{

    RegisterViewController *RegisterView = nil;
    RegisterView = [[RegisterViewController alloc]init];
    [RegisterView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:RegisterView animated:YES completion:^{
        
    }];
    
    
}
-(IBAction)LandingChange:(id)sender{
    

   #pragma XMLParse
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:@"automaticLandingTag"]&&([[ud objectForKey:@"automaticLandingUserName"]isEqualToString:@""] == NO)) {
        
        
        [SVProgressHUD show];
            _UserNameStr =  [ud objectForKey:@"automaticLandingUserName"];
            _SecretCodeStr =[ud objectForKey:@"automaticLandingUserCode"];
           UserName.text  = _UserNameStr;
           SecretCode.text = _SecretCodeStr;
            NSString *urlString = [[NSString stringWithFormat:@"%@pusers?method=select&whereuserName=(string)%@&whereuserPwd=(string)%@",kURL, _UserNameStr,_SecretCodeStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlString]];
            NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [connection release];
    
    }
    else {
     if ([UserName.text isEqualToString:@""] == NO) {
          if ([SecretCode.text isEqualToString:@""]) {
             UserName.text = @"";
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登陆" message:@"密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" , nil];
             [alert show];
             [alert release];
             
         }
          else{
          
//              self.progressHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//              [_progressHud setMode:MBProgressHUDModeCustomView];
//              [_progressHud setLabelText:@"正在上传..."];
              
            [SVProgressHUD showWithStatus:@"努力加载..."];
              self.isLogin = YES;
           _UserNameStr = UserName.text;
          _SecretCodeStr = SecretCode.text;
         NSString *urlString = [[NSString stringWithFormat:@"%@pusers?method=select&whereuserName=(string)%@&whereuserPwd=(string)%@",kURL, _UserNameStr,_SecretCodeStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
          NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlString]];
          NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
          [connection release];
          }
          }
        else  if ([UserName.text isEqualToString:@""]){
            SecretCode.text = @"";
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登陆" message:@"用户名不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" , nil];
            [alert show];
            [alert release];
            
        }
        else if ([SecretCode.text isEqualToString:@""]) {
            UserName.text = @"";
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登陆" message:@"密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" , nil];
            [alert show];
            [alert release];
            
        }
    }
#pragma search
   
}
#pragma NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [self.receivedData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.receivedData appendData:data];
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
	NSXMLParser* parser=[[NSXMLParser alloc]initWithData:receivedData];
	parser.delegate=self;
	[parser parse];
	[parser release];
}

#pragma mark NSXMLParser

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    //图片下载
//    [imageModeTodoList removeAllObjects];
    //	[channelman removeAllChannel];
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //	[self.tableview reloadData];
    
     if ([self.userName isEqualToString:UserName.text]) {
        
        Dm.userName = self.userName;
        Dm.labelStr = self.userTag;;
        Dm.picPath  = self.userPic;
        Dm.tagPath  = self.userTag;
        Dm.userNickNameStr = self.userNickName;
        Dm.userIdPathStr = self.userId;
        Dm.userCode      = self.userPwd;
        NSString *string = [NSString stringWithString:self.userId];
        NSString *string1 = [NSString stringWithFormat:@"%@", Dm.userIdPathStr];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:string forKey:@"myKey"];
        [ud setObject:Dm.picPath forKey:@"picPath"];
        [ud setObject:Dm.tagPath forKey:@"tagPath"];
        [ud setObject:Dm.userNickNameStr forKey:@"userNickNamePath"];
        [ud setObject:string1 forKey:@"userIdPath"];
        /*这里进行自动登陆记住账号密码*/
        if ([ud boolForKey:@"automaticLandingTag"]){
            if ([Dm.userName isEqualToString:@""] == NO) {
                [ud setObject:Dm.userName forKey:@"automaticLandingUserName"];
                [ud setObject:Dm.userCode forKey:@"automaticLandingUserCode"];
            }
        }
        MainTabBarController *mainController = [[MainTabBarController alloc]init];
        [self.navigationController pushViewController:mainController animated:YES];
    }
    else{
        [UserName setText:@""];
        [SecretCode setText:@""];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登陆" message:@"用户密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
        [alert release];
    }
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{


	 if ([elementName isEqualToString:@"picId"])
	{
		[_tempStr setString:@""];
	}
	else if ([elementName isEqualToString:@"userId"]) {
		[_tempStr setString:@""];
	}
	else if ([elementName isEqualToString:@"picAddress"]) {
		[_tempStr setString:@""];
	}
    else if ([elementName isEqualToString:@"picTime"]) {
		[_tempStr setString:@""];
	}
    else if ([elementName isEqualToString:@"picFriend"]) {
		[_tempStr setString:@""];
	}
    else if ([elementName isEqualToString:@"picUrl"]) {
		[_tempStr setString:@""];
	}
    else if ([elementName isEqualToString:@"picTag"]) {
		[_tempStr setString:@""];
	}	else if ([elementName isEqualToString:@"picLove"]) {
		[_tempStr setString:@""];
	}
    else if ([elementName isEqualToString:@"picLocation"]) {
		[_tempStr setString:@""];
	}
    else if ([elementName isEqualToString:@"picAlbum"]) {
		[_tempStr setString:@""];
	}
    else if ([elementName isEqualToString:@"userName"]){
        [_tempStr setString:@""];
    }
    else if ([elementName isEqualToString:@"userPwd"]){
        [_tempStr setString:@""];
    }
    else if ([elementName isEqualToString:@"userNickName"]){
        [_tempStr setString:@""];
    }
    else if ([elementName isEqualToString:@"userTag"]){
        [_tempStr setString:@""];
    }
    else if ([elementName isEqualToString:@"userPic"]){
        [_tempStr setString:@""];
    }
	else {
		return;
	}

}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"userId"])
    {
        userId = [NSString stringWithString:_tempStr];
    }
    else if([elementName isEqualToString:@"userName"])
	{
        userName = [NSString stringWithString:_tempStr];

	}
    else if([elementName isEqualToString:@"userPwd"])
    {
        userPwd = [NSString stringWithString:_tempStr];
            
    }
    else if ([elementName isEqualToString:@"userNickName"]){
        userNickName = [NSString stringWithString:_tempStr];
    }
    else if ([elementName isEqualToString:@"userTag"]){
        userTag = [NSString stringWithString:_tempStr];
    }
    else if ([elementName isEqualToString:@"userPic"]){
        self.userPic = [NSString stringWithString:_tempStr];
    }
    //图片下载
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [_tempStr appendString:string];
}


-(void)BtnAction:(id)sender{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if([ud boolForKey:@"automaticLandingTag"]){

        [ud setBool:NO forKey:@"automaticLandingTag"];
        [CheckBtn setImage:[UIImage imageNamed:@"unchecked(1).png"] forState:UIControlStateNormal];


    }
    else{
        [ud setBool:YES forKey:@"automaticLandingTag"];
        [CheckBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        [ud setObject:@"" forKey:@"automaticLandingUserName"];
        [ud setObject:@"" forKey:@"automaticLandingUserCode"];
    }
    
}
#pragma mark 横竖屏
//- (BOOL)shouldAutorotate{
//    return NO;
//}
//- (NSInteger)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [UserName resignFirstResponder];
    [SecretCode resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (!textField.window.isKeyWindow) {
        [textField.window makeKeyAndVisible];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;

}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
}


-(void)viewWillDisappear:(BOOL)animated
{
        UserName.delegate = nil;
    NSLog(@"%@",UserName);
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    UserName.delegate = self;
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillAppear:animated];
}

-(void)dealloc{
    [super dealloc];
    [CheckBtn release];
    [Dm release];


}

@end
