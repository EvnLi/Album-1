//
//  UserInformationViewController.m
//  Album
//
//  Created by smq on 13-8-14.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "UserInformationViewController.h"

@interface UserInformationViewController ()

@end

@implementation UserInformationViewController
@synthesize imageView,modifyBtn,navBar,nameLab,tagLab,nameTextField,tagTextLab,navCtrl,suremodifyBtn,imageArrStr;

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
    
    navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UINavigationItem *navItem = [[UINavigationItem alloc]initWithTitle:@"个人资料"];
    UIBarButtonItem  *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnBack:)];
    [navItem setLeftBarButtonItem:leftBtn];
    [navBar pushNavigationItem:navItem animated:NO];
    navBar.hidden = NO;
    [navBar setTintColor:[UIColor redColor]];
    [self.view addSubview:navBar];
    [navItem release];
    [navBar release];
    self.receivedData = [[NSMutableData alloc]init];
    _tempStr      = [[NSMutableString alloc]init];
    _userNickNameStr  = [[NSMutableString alloc]init];
    _userNickNamePathStr = [[NSMutableString alloc]init];
    self.imageArrStr = [[NSMutableArray alloc]init];
    self.picCopStry = [[NSString alloc]init];
//    [self initControls];
}

- (void)initControls{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(38, 64, 88, 88)];
    
    self.tagPathStr = [ud objectForKey:@"picPath"];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    NSURL   *picPath = [[NSURL alloc]initWithString:_tagPathStr];
    NSData *picDate = [NSData dataWithContentsOfURL:picPath];
    [imageView setImage:[UIImage imageWithData:picDate]];
    [self.view addSubview:imageView];
    
    modifyBtn = [[UIButton alloc]initWithFrame:CGRectMake(44, 160, 65, 28)];
    [modifyBtn setBackgroundColor:[UIColor redColor]];
    [modifyBtn  addTarget:self action:@selector(modifyBtn:) forControlEvents:UIControlEventTouchUpInside];
    modifyBtn.autoresizingMask  = UIViewAutoresizingFlexibleBottomMargin;
    [modifyBtn setTitle:@"修改头像" forState:UIControlStateNormal];
    [modifyBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:modifyBtn];
    
    nameLab   = [[UILabel alloc]initWithFrame:CGRectMake(62, 212, 60, 21)];
    [nameLab setFont:[UIFont systemFontOfSize:14]];
    nameLab.text = @"昵称：";
    nameLab.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:nameLab];
    
    
    
    nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 214, 97, 20)];
    nameTextField.backgroundColor =[UIColor redColor];
    nameTextField.textColor = [UIColor whiteColor];
    [nameTextField setFont:[UIFont systemFontOfSize:14]];
    nameTextField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    nameTextField.clearsOnBeginEditing = YES;
    nameTextField.adjustsFontSizeToFitWidth = YES;
    nameTextField.delegate = self;
    self.userNickNamePathStr = [ud objectForKey:@"userNickNamePath"];
    [nameTextField setText:self.userNickNamePathStr];
    [self.view addSubview:nameTextField];
    
    tagLab   = [[UILabel alloc]initWithFrame:CGRectMake(62, 286, 60, 30)];
    [tagLab setFont:[UIFont systemFontOfSize:14]];
    tagLab.text = @"标签：";
    tagLab.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:tagLab];
    
    NSUserDefaults *tagUserLab = [NSUserDefaults standardUserDefaults];
    _tagPathStr = [tagUserLab objectForKey:@"tagPath"];
    NSMutableArray *tagLabArr = [[NSArray arrayWithArray:[_tagPathStr componentsSeparatedByString:@","]]mutableCopy];
    if ([tagLabArr count] > 0) {
        
        if ([[tagLabArr objectAtIndex:0]isEqualToString:@""]||[[tagLabArr objectAtIndex:0]isEqualToString:@"null"]) {
            
            [tagLabArr removeObjectAtIndex:0];
        }
    }
    NSString *tagNmaeArrBtnStr = [[NSString alloc]init];
    if ([tagLabArr count]) {
        
        tagNmaeArrBtnStr = [[NSMutableString alloc]initWithFormat:@"%@",[tagLabArr objectAtIndex:0]];
    }
    for (int i = 1; i < [tagLabArr count]; i++) {
        tagNmaeArrBtnStr = [tagNmaeArrBtnStr stringByAppendingFormat:@",%@",[tagLabArr objectAtIndex:i]];
    }

    tagTextLab = [[UILabel alloc]initWithFrame:CGRectMake(120, 286, 120, 30)];
    tagTextLab.backgroundColor =[UIColor clearColor];
    [tagTextLab setFont:[UIFont systemFontOfSize:14]];
    tagTextLab.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [tagTextLab setText:tagNmaeArrBtnStr];
    [self.view addSubview:tagTextLab];
    
    
    modifyBtn = [[UIButton alloc]initWithFrame:CGRectMake(170, 340, 65, 28)];
    [modifyBtn setBackgroundColor:[UIColor redColor]];
    [modifyBtn  addTarget:self action:@selector(sureModifyBtn:) forControlEvents:UIControlEventTouchUpInside];
    modifyBtn.autoresizingMask  = UIViewAutoresizingFlexibleBottomMargin;
    [modifyBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [modifyBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:modifyBtn];

    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [nameTextField setText:@""];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    self.userNickNamePathStr = [ud objectForKey:@"userNickNamePath"];
    [nameTextField setText:self.userNickNamePathStr];
        [self initControls];
}
- (void)modifyBtn:(id)sender{

    
    dialongView = [[DialogView alloc]initWithFrame:CGRectMake(30, 200, 260, 120)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(80,50, 23, 23)];
    [button setTitle:@"close" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    //        [button setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];    //此按钮用来关闭此视图
    [button addTarget:self action:@selector(closeClickButton:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1;
    [dialongView addSubview:button];
    
    UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 130, 30)];
    [headLabel setText:@"点击图片修改头像"];
    [headLabel setFont:[UIFont systemFontOfSize:12]];
    [dialongView addSubview:headLabel];
    [headLabel release];
    
    UIScrollView *sView = [[UIScrollView alloc]initWithFrame:CGRectMake(35, 44, 50*4, 70)];
    sView.backgroundColor = [UIColor blueColor];
    sView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    sView.showsHorizontalScrollIndicator = NO;
    sView.pagingEnabled = YES;
    sView.userInteractionEnabled = YES;
    sView.delegate = self;
    sView.contentSize = CGSizeMake(9*60 ,50);
    
    for (int i=1; i<9; i++) {
        NSString *urlImg = [NSString stringWithFormat:@"%d.jpg",i];
        [self.imageArrStr addObject:urlImg];
        UIImageView *iView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:urlImg]];
        iView.userInteractionEnabled = YES;
        iView.frame = CGRectMake((i - 1)*50 + (i - 1)*5, 0, 50,70);
        iView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [iView addGestureRecognizer:tap];
        [tap release];
        [sView addSubview:iView];
        [iView release];
    }
    [dialongView addSubview:sView];
    [sView release];
    [self.view addSubview:dialongView];

}
#pragma mark 修改头像
- (void)click:(id)sender {

    int index = [[(UITapGestureRecognizer*)sender view]tag];
    NSString *picStr = [[NSString alloc]init];
    picStr = [self.imageArrStr objectAtIndex:index - 1];
    self.picCopStry = [picStr copy];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *picStrPath = [NSString stringWithFormat:@"http://www.fenghukeji.com/PhotosServer/page/tx%@",picStr];
    [ud setObject:picStrPath forKey:@"picPath"];
    [picStr release];
    dialongView.hidden = YES;
    

    [imageView setImage:[UIImage imageNamed:picStr]];

}
-(IBAction)closeClickButton:(id)sender{
 
    dialongView.hidden=YES;
}

- (void)sureModifyBtn:(id)sender{
    if ([self.userNickNamePathStr isEqualToString:nameTextField.text]) {
        self.isModifyHead = YES;
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *userPicStr = [ud objectForKey:@"picPath"];
        NSString *urlString = [[NSString stringWithFormat:@"%@pusers?method=update&whereuserNickName=(string)%@&userPic=(string)%@",kURL, nameTextField.text,userPicStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"urlString = %@",urlString);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlString]];
        NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection release];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        self.userNickNamePathStr = nameTextField.text;
        NSString *urlString = [[NSString stringWithFormat:@"%@pusers?method=select&whereuserNickName=(string)%@",kURL, nameTextField.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlString]];
        NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection release];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)returnBack:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)sendImageUrl:(NSString*)_imageStr{
    [imageView setImage:[UIImage imageNamed:_imageStr]];
    [self reloadInputViews];

}
#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [nameTextField resignFirstResponder];
    return YES;
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
    
    if (self.isModifyHead) {
    
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"个人资料" message:@"修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *picStrPath = [NSString stringWithFormat:@"http://www.fenghukeji.com/PhotosServer/page/tx%@",self.picCopStry];
        [ud setObject:picStrPath forKey:@"picPath"];
    }
    
	NSXMLParser* parser=[[NSXMLParser alloc]initWithData:self.receivedData];
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
    if ([_userNickNameStr isEqualToString:nameTextField.text]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"修改个人信息" message:@"该昵称已经被注册了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }
    else{
        
    self.isModifyHead = YES;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *userIdStr  = [ud objectForKey:@"userIdPath"];
    NSString *userPicStr = [ud objectForKey:@"picPath"];
    [ud setObject:nameTextField.text forKey:@"userNickNamePath"];
    NSString *urlString = [[NSString stringWithFormat:@"%@pusers?method=update&userNickName=(string)%@&userPic=(string)%@&whereuserId=(int)%d",kURL, nameTextField.text,userPicStr,[userIdStr intValue]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlString]];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection release];
    [self dismissViewControllerAnimated:YES completion:nil];
    }
    //	[self.tableview reloadData];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"userId"])
    {
        [_tempStr setString:@""];
    }
    if([elementName isEqualToString:@"userName"])
    {
        [_tempStr setString:@""];
    }
    if([elementName isEqualToString:@"userPwd"])
    {
        [_tempStr setString:@""];
    }
    if([elementName isEqualToString:@"userNickName"])
    {
        [_tempStr setString:@""];
    }
    if([elementName isEqualToString:@"userTag"])
    {
        [_tempStr setString:@""];
    }
    if([elementName isEqualToString:@"userPic"])
    {
        [_tempStr setString:@""];
    }
    else{
		return;
    }
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"userNickName"])
    {
            _userNickNameStr = [NSString stringWithString:_tempStr];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if ([string isEqualToString:@"\n"] == NO) {
    [_tempStr appendString:string];
    }
}
- (void)dealloc{
    [super dealloc];
    [self.picCopStry release];
    [imageView release];
    [modifyBtn release];
    [nameLab   release];
    [nameTextField release];
    [tagLab release];
    [tagTextLab release];
    [_receivedData   release];
    [_tempStr        release];
    [_userNickNamePathStr release];
    [_userNickNameStr release];
}

@end
