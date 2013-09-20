//
//  ChangeCodeViewController.m
//  Album
//
//  Created by smq on 13-8-8.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "ChangeCodeViewController.h"
 NSString* globalUserId;
@interface ChangeCodeViewController ()

@end

@implementation ChangeCodeViewController
@synthesize CurrentCode,Code,AgainCode,Submit,AgainCodeLabel,CodeLabel,CurrentCodeLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)Submit:(id)sender{
    self.isChangeCode = YES;
    NSString *urlString = [[NSString stringWithFormat:@"%@pusers?method=select&whereuserPwd=(string)%@",kURL, CurrentCode.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlString]];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UINavigationItem *navItem = [[UINavigationItem alloc]initWithTitle:@"密码修改"];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnBack:)];
    [navItem setLeftBarButtonItem:leftBtn];
    [navBar pushNavigationItem:navItem animated:YES];
    navBar.autoresizesSubviews = UIViewAutoresizingFlexibleBottomMargin;
    [navBar setTintColor:[UIColor redColor]];
    [self.view addSubview:navBar];
    [leftBtn release];
    [navItem release];
    [navBar release];
    
    
    
    CurrentCodeLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    CurrentCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 80, 30)];
    [CurrentCodeLabel setText:@"当前密码:"];
    CurrentCodeLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:CurrentCodeLabel];
    CurrentCode = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 130, 30)];
    CurrentCode.delegate = self;
    [CurrentCode setFont:[UIFont systemFontOfSize:14]];
    [CurrentCode setPlaceholder:@"输入密码"];
    CurrentCode.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    CurrentCode.borderStyle = UITextBorderStyleRoundedRect;
    CurrentCode.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    CurrentCode.adjustsFontSizeToFitWidth = YES;
    CurrentCode.secureTextEntry = YES;
    [self.view addSubview:CurrentCode];
    [CurrentCode release];
    
    
    
    CodeLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    CodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 180, 70, 30)];
    [CodeLabel setText:@"密码:"];
    CodeLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:CodeLabel];
    Code = [[UITextField alloc]initWithFrame:CGRectMake(100, 180, 130, 30)];
    Code.delegate = self;
    [Code setFont:[UIFont systemFontOfSize:14]];
    [Code setPlaceholder:@"输入新密码"];
    Code.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    Code.borderStyle = UITextBorderStyleRoundedRect;
    Code.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    Code.adjustsFontSizeToFitWidth = YES;
    Code.secureTextEntry = YES;
    [self.view addSubview:Code];
    [Code release];
    
    
    
    
    AgainCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 240, 70, 30)];
    [AgainCodeLabel setText:@"新密码:"];
    AgainCodeLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:AgainCodeLabel];
    AgainCodeLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    AgainCode = [[UITextField alloc]initWithFrame:CGRectMake(100, 240, 130, 30)];
    AgainCode.delegate = self;
    [AgainCode setFont:[UIFont systemFontOfSize:14]];
    [AgainCode setPlaceholder:@"输入新密码"];
    AgainCode.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    AgainCode.borderStyle = UITextBorderStyleRoundedRect;
    AgainCode.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    AgainCode.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:  AgainCode];
    [ AgainCode release];
    AgainCode.tag = 2;
    
    
    Submit = [[UIButton alloc]initWithFrame:CGRectMake(239, 360, 66, 34)];
    [Submit setBackgroundColor:[UIColor redColor]];
    [Submit  addTarget:self action:@selector(Submit:) forControlEvents:UIControlEventTouchUpInside];
    Submit.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
    [Submit setTitle:@"提交" forState:UIControlStateNormal];
    [Submit.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:Submit];
    [Submit release];
    
    CurrentCode.delegate = self;
    Code.delegate = self;
    AgainCode.delegate = self;
    _receivedData = [[NSMutableData alloc]init];
    _tempStr      = [[NSMutableString alloc]init];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _userId = [ud objectForKey:@"myKey"];}
- (void)returnBack:(id)sender{
      [self dismissViewControllerAnimated:YES completion:nil];
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
	NSXMLParser* parser=[[NSXMLParser alloc]initWithData:_receivedData];
	parser.delegate=self;
	[parser parse];
	[parser release];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (self.isChangeCode) {
        self.isChangeCode = NO;
        [ud setBool:NO forKey:@"automaticLandingTag"];
        [ud setObject:@"" forKey:@"automaticLandingUserName"];
        [ud setObject:@"" forKey:@"automaticLandingUserCode"];
    }
}

#pragma mark NSXMLParser

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    //	[channelman removeAllChannel];
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{

    if ([CurrentCode.text isEqualToString:_codePwd] == YES) {
        
        if ([Code.text isEqualToString:AgainCode.text]&& [Code.text isEqualToString:@""]!=YES) {
            
            
            NSMutableURLRequest *rq = [[NSMutableURLRequest alloc]init];
            NSString *str = [[NSString alloc]initWithFormat:@"%@pusers?method=update&whereuserId=(int)%d&userPwd=(string)%@",kURL,[self.userId intValue], Code.text];
            [rq setURL:[NSURL URLWithString:str]];
            NSURLConnection *cn = [[NSURLConnection alloc]initWithRequest:rq delegate:self];
            [str release];
            [cn release];
        }
        else if ([Code.text isEqualToString:AgainCode.text]&& [Code.text isEqualToString:@""]==YES){
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"修改密码" message:@"修改密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alertView  show];
            [alertView  release];
            CurrentCode.text = @"";
            
        }
        
        else {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"修改密码" message:@"两次输入修改密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alertView  show];
            [alertView  release];
            CurrentCode.text = @"";
            Code.text        = @"";
            AgainCode.text   = @"";
        }
        
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"修改密码" message:@"原始密码输入有误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView  show];
        [alertView  release];
        CurrentCode.text = @"";
        Code.text        = @"";
        AgainCode.text   = @"";
    }
    

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [_tempStr setString:@""];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{

     if([elementName isEqualToString:@"userPwd"])
       {
          _codePwd = [NSString stringWithString:_tempStr];
  
     }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [_tempStr appendString:string];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 2) {
        self.view.frame = CGRectMake(0, 20, self.view.frame.size.width,self.view.frame.size.height );
    }
    [CurrentCode resignFirstResponder];
    [Code        resignFirstResponder];
    [AgainCode   resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 2) {
        self.view.frame = CGRectMake(0, -20, self.view.frame.size.width,self.view.frame.size.height );
    }
}

- (void)dealloc{
    [super dealloc];
    [_receivedData release];
    [_tempStr release];
}
@end
