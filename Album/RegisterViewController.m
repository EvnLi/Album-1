//
//  RegisterViewController.m
//  Album
//
//  Created by smq on 13-8-7.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "RegisterViewController.h"
#import <sqlite3.h>
CGFloat  viewHeigt;
@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize Submit,RegisterBar,UserNameField,SecretCodeField,SecretCodeFieldAgain;
@synthesize UserNameLable,SecretCodeLableAgain,SecretCodeLable,userName;
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
    viewHeigt = self.view.frame.origin.y;
//    i = self.view.frame.origin.y;
    
    self.receivedData = [[NSMutableData alloc] init];
    self.tempStr = [[NSMutableString alloc] init];
    
    UserNameLable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    SecretCodeLable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    SecretCodeLableAgain.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    UserNameField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    SecretCodeField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    SecretCodeFieldAgain.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    
    
    navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UINavigationItem *navItem = [[UINavigationItem alloc]initWithTitle:@"注册"];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(ReturnLandingView:)];
    [navItem setLeftBarButtonItem:leftBtn];
    [navBar pushNavigationItem:navItem animated:YES];
    navBar.autoresizesSubviews = UIViewAutoresizingFlexibleBottomMargin;
    [navBar setTintColor:[UIColor redColor]];
    [self.view addSubview:navBar];
    [leftBtn release];
    [navItem release];
    [navBar release];
    
    
    
    UserNameLable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    UserNameLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 60, 30)];
    [UserNameLable setText:@"用户名:"];
    UserNameLable.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:UserNameLable];
    UserNameField = [[UITextField alloc]initWithFrame:CGRectMake(90, 100, 130, 30)];
    UserNameField.delegate = self;
    [UserNameField setFont:[UIFont systemFontOfSize:14]];
    [UserNameField setPlaceholder:@"用户名"];
    UserNameField.borderStyle = UITextBorderStyleRoundedRect;
    UserNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UserNameField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    UserNameField.adjustsFontSizeToFitWidth = YES;
    UserNameField.tag = 1;
    [self.view addSubview:UserNameField];
    [UserNameField release];
    
    
    
    SecretCodeLable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    SecretCodeLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 180, 60, 30)];
    [SecretCodeLable setText:@"密码:"];
    SecretCodeLable.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:SecretCodeLable];
    SecretCodeField = [[UITextField alloc]initWithFrame:CGRectMake(90, 180, 130, 30)];
    SecretCodeField.delegate = self;
    [SecretCodeField setFont:[UIFont systemFontOfSize:14]];
    [SecretCodeField setPlaceholder:@"输入新密码"];
    SecretCodeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    SecretCodeField.borderStyle = UITextBorderStyleRoundedRect;
    SecretCodeField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    SecretCodeField.adjustsFontSizeToFitWidth = YES;
    SecretCodeField.secureTextEntry = YES;
    SecretCodeField.tag = 2;
    [self.view addSubview:SecretCodeField];
    [SecretCodeField release];
    
    
    
    
    SecretCodeLableAgain = [[UILabel alloc]initWithFrame:CGRectMake(20, 240, 60, 30)];
    [SecretCodeLableAgain setText:@"新密码:"];
    SecretCodeLableAgain.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:SecretCodeLableAgain];
    SecretCodeFieldAgain.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    SecretCodeFieldAgain = [[UITextField alloc]initWithFrame:CGRectMake(90, 240, 130, 30)];
    SecretCodeFieldAgain.delegate = self;
    [SecretCodeFieldAgain setFont:[UIFont systemFontOfSize:14]];
    [SecretCodeFieldAgain setPlaceholder:@"输入新密码"];
    SecretCodeFieldAgain.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    SecretCodeFieldAgain.borderStyle = UITextBorderStyleRoundedRect;
    SecretCodeFieldAgain.tag = 100;
    SecretCodeFieldAgain.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    SecretCodeFieldAgain.adjustsFontSizeToFitWidth = YES;
    SecretCodeFieldAgain.secureTextEntry = YES;
    [self.view addSubview:  SecretCodeFieldAgain];
    [SecretCodeFieldAgain release];
    
    
    Submit = [[UIButton alloc]initWithFrame:CGRectMake(239, 360, 66, 34)];
    [Submit setBackgroundColor:[UIColor redColor]];
    [Submit  addTarget:self action:@selector(Submit:) forControlEvents:UIControlEventTouchUpInside];
    Submit.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
    [Submit setTitle:@"提交" forState:UIControlStateNormal];
    [Submit.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:Submit];
    [Submit release];


}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    UserNameField.text = @"";
    SecretCodeField.text = @"";
    SecretCodeFieldAgain.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)ReturnLandingView:(id)sender{
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma 上传注册用户
-(IBAction)Submit:(id)sender{
    if ([UserNameField.text length] < 6) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提交失败" message:@"用户名不能少于6位" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        [UserNameField setText:@""];
        [SecretCodeField setText:@""];
        [SecretCodeFieldAgain setText:@""];
        return ;
    }
    else if ([SecretCodeField.text length] < 6){
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提交失败" message:@"密码不能少于6位" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        [UserNameField setText:@""];
        [SecretCodeField setText:@""];
        [SecretCodeFieldAgain setText:@""];
    }
    else if ([UserNameField.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提交失败" message:@"用户名不能为空" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ;
    }
    else {
        NSString *urlString = [[NSString stringWithFormat:@"%@pusers?method=select&whereuserName=(string)%@",kURL, UserNameField.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlString]];
        NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection release];
    }
}

#pragma 查询用户是否存在

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
	NSXMLParser* parser=[[NSXMLParser alloc]initWithData:self.receivedData];
	parser.delegate=self;
	[parser parse];
	[parser release];
}

#pragma mark NSXMLParser

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
    //	[channelman removeAllChannel];
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{

    if ([userName isEqualToString:UserNameField.text]!= YES) {
        if ([SecretCodeField.text isEqualToString:SecretCodeFieldAgain.text]) {
            
            NSMutableURLRequest *rq = [[NSMutableURLRequest alloc]init];
            NSString *str = [[NSString alloc]initWithFormat:@"%@pusers?method=insert&userName=(string)%@&userNickName=(string)%@&userPwd=(string)%@",kURL, UserNameField.text, UserNameField.text,SecretCodeField.text];
            [rq setURL:[NSURL URLWithString:str]];
            NSURLConnection *cn = [[NSURLConnection alloc]initWithRequest:rq delegate:self];
            [str release];
            [cn release];
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"注册" message:@"两次输入密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alertView  show];
            [alertView  release];
        }
        
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"注册" message:@"此用户已被注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView  show];
        [alertView  release];
    }
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.view.frame = CGRectMake(self.view.frame.origin.x, i, self.view.frame.size.width, self.view.frame.size.height);

    //	[self.tableview reloadData];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [_tempStr setString:@""];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
     if([elementName isEqualToString:@"userName"])
	{
        userName = [NSString stringWithString:_tempStr];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [_tempStr appendString:string];
}



#pragma UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{


    if (textField.tag == 1) {
        
        if (range.location < 20) {
            
            return YES;
        }
        else{
            return NO;
        }
    }
    else {
        if (range.location < 12) {
        
            return YES;
        }
        else{
            return NO;
        }
    }

}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 100) {
        

    self.view.frame = CGRectMake(self.view.frame.origin.x, viewHeigt - 40, self.view.frame.size.width, self.view.frame.size.height);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    

    [UserNameField resignFirstResponder];
    [SecretCodeField resignFirstResponder];
    [SecretCodeFieldAgain resignFirstResponder];
    self.view.frame = CGRectMake(self.view.frame.origin.x, viewHeigt + 40, self.view.frame.size.width, self.view.frame.size.height);
    return YES;
}
- (void)dealloc{
    [super dealloc];
    [_receivedData release];
    [_tempStr release];
}


@end
