//
//  ConnectNameMessageViewController.m
//  Album
//
//  Created by smq on 13-8-25.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "ConnectNameMessageViewController.h"

@interface ConnectNameMessageViewController ()

@end

@implementation ConnectNameMessageViewController
@synthesize navBar,navItem,connectLabel,nickNameLabel,nickName,connectNumber,tag,fansLabel,albumLabel,userHeadPic;
@synthesize fansNumber,tagLabel,reciveUserId,UserId,tempStr,receivedData;
@synthesize userName,userNickName,userPic,userTag,userPwd;

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
//    seeSpaceView = [[SeeSpaceViewController alloc]init];
    tempStr      = [[NSMutableString alloc]init];
    self.tempStrCopy = [[NSString alloc]init];
    receivedData = [[NSMutableData alloc]init];
    self.reciveUserNickName = [[NSString alloc]init];
    self.reciveUserTag = [[NSString alloc]init];
    self.reciveUserHeadPic = [[NSString alloc]init];
    reciveUserId = [[NSString alloc]init];
    self.imageModeTodo = [[imageModeViewController alloc]init];
    self.picDic = [[NSMutableDictionary alloc]init];
    self.keyPicArr = [[NSMutableArray alloc]init];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    fans = 0;
    attentions   = 0;
    self.isFans = NO;
    self.isAttantion = NO;
    self.isUser = NO;
    self.reciveUserNickName = userNickName;
    self.reciveUserTag = userTag;
    self.reciveUserHeadPic = self.userHeadPicStr;
    [self.picDic removeAllObjects];
    [self.keyPicArr removeAllObjects];
    [self initWithAllSubViews];
}

- (void)initWithAllSubViews{
    
    reciveUserId = UserId;
     if ([reciveUserId isEqualToString:@""] == NO) {
    self.isFans = YES;
       NSString *urlConString = [[NSString stringWithFormat:@"%@attention?method=select&whereisattuserId=(int)%d",kURL,[reciveUserId intValue]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];



    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    // 設置URL
    [request setURL:[NSURL URLWithString:urlConString]];
    // 設置HTTP方法
    [request setHTTPMethod:@"GET"];
    // 發送同步請求, 這裡得returnData就是返回得數據楽
    NSData *returnData =[NSURLConnection sendSynchronousRequest:request
                                              returningResponse:nil error:nil];
    // 釋放對象
    [request release];
    
    NSXMLParser* parser=[[NSXMLParser alloc]initWithData:returnData];
    parser.delegate=self;
    [parser parse];
    [parser release];
    
    //关注
    self.isAttantion = YES;
    self.isFans = NO;
      NSString *urlConStringStr = [[NSString stringWithFormat:@"%@attention?method=select&whereattuserId=(int)%d",kURL,[reciveUserId intValue]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *requestCon = [[NSMutableURLRequest alloc] init];
    // 設置URL
    [requestCon setURL:[NSURL URLWithString:urlConStringStr]];
    // 設置HTTP方法
    [requestCon setHTTPMethod:@"GET"];
    // 發送同步請求, 這裡得returnData就是返回得數據楽
    NSData *returnDataCon =[NSURLConnection sendSynchronousRequest:requestCon
                                              returningResponse:nil error:nil];
    // 釋放對象
    [requestCon release];
    
    NSXMLParser* parserCon =[[NSXMLParser alloc]initWithData:returnDataCon];
    parserCon.delegate=self;
    [parserCon parse];
    [parserCon release];
     }
    
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"数据下载" message:@"下载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    
    
    self.isAttantion = NO;
    if ([reciveUserId isEqualToString:@""] == NO) {
        
        self.isUser = YES;

        
        NSString *urlPicString = [[NSString stringWithFormat:@"%@photos?method=select&whereuserId=(int)%@",kURL, reciveUserId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *requestPic = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlPicString]];
        NSURLConnection* connectionPic = [[NSURLConnection alloc] initWithRequest:requestPic delegate:self];
        [connectionPic release];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"图片下载" message:@"下载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    
    navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    navItem = [[UINavigationItem alloc]initWithTitle:@"个人资料"];
    UIBarButtonItem  *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnBack:)];
    [navItem setLeftBarButtonItem:leftBtn];
    [navBar pushNavigationItem:navItem animated:NO];
    navBar.hidden = NO;
    [navBar setTintColor:[UIColor redColor]];
    [self.view addSubview:navBar];
    [navItem release];
    [navBar release];
    
    userHeadPic = [[UIImageView alloc]initWithFrame:CGRectMake(38, 64, 60, 60)];
    userHeadPic.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    NSURL   *picPath = [[NSURL alloc]initWithString:self.reciveUserHeadPic];
    NSData *picDate = [NSData dataWithContentsOfURL:picPath];
    [userHeadPic setImage:[UIImage imageWithData:picDate]];
    [self.view addSubview:userHeadPic];
    [userHeadPic release];
    
    
    nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 130, 80, 21)];
    [nickNameLabel setFont:[UIFont systemFontOfSize:14]];
    nickNameLabel.text = @"昵称：";
    nickNameLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:nickNameLabel];
    [nickNameLabel release];
    
    nickName = [[UILabel alloc]initWithFrame:CGRectMake(140, 130, 80, 21)];
    [nickName setFont:[UIFont systemFontOfSize:14]];
    [nickName setText:self.reciveUserNickName];
    nickName.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:nickName];
    [nickName release];
    
    tagLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 180, 80, 21)];
    [tagLabel setFont:[UIFont systemFontOfSize:14]];
    tagLabel.text = @"标签：";
    tagLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:tagLabel];
    [tagLabel release];
    
    
    tag = [[UILabel alloc]initWithFrame:CGRectMake(140, 180, 110, 80)];
    [tag setFont:[UIFont systemFontOfSize:14]];
    [tag setText:self.reciveUserTag];
    tag.numberOfLines = 3;
    tag.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:tag];
    [tag   release];
    
    fansLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 280, 60, 21)];
    [fansLabel setFont:[UIFont systemFontOfSize:14]];
    fansLabel.text = @"粉丝：";
    fansLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:fansLabel];
    [fansLabel release];
    
    
    fansNumber = [[UILabel alloc]initWithFrame:CGRectMake(70, 280, 60, 21)];
    [fansNumber setFont:[UIFont systemFontOfSize:14]];
    fansNumber.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:fansNumber];
    [fansNumber release];
    
    
    connectLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 280, 60, 21)];
    [connectLabel setFont:[UIFont systemFontOfSize:14]];
    connectLabel.text = @"关注：";
    connectLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:connectLabel];
    [connectLabel release];
    
    
    connectNumber = [[UILabel alloc]initWithFrame:CGRectMake(180, 280, 80, 21)];
    [connectNumber setFont:[UIFont systemFontOfSize:14]];
    connectNumber.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:connectNumber];
    [connectNumber release];
    
    
    albumLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 310, 60, 21)];
    [albumLabel setFont:[UIFont systemFontOfSize:14]];
    albumLabel.text = @"相册：";
    albumLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:albumLabel];
    [albumLabel release];
    
    albumLabelStr = [[UILabel alloc]initWithFrame:CGRectMake(110, 310, 100, 21)];
    [albumLabelStr setFont:[UIFont systemFontOfSize:14]];
    albumLabelStr.text = @"";
    albumLabelStr.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:albumLabelStr];
    [albumLabelStr release];

    
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
//    self.picDic = [[NSMutableDictionary alloc]init];
    
//    [self.picDic removeAllObjects];
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{



           [fansNumber setText:[NSString stringWithFormat:@"%d",fans]];
            [connectNumber setText:[NSString stringWithFormat:@"%d",attentions]];
    if (self.isUser) {
        
        self.isUser = NO;
        [self initPicImage];
        
    }

}

- (void)initPicImage{
    

    self.keyPicArr = [[self.picDic allKeys]mutableCopy];
    UIScrollView *sView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 340, 320, 568)];
    sView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    sView.userInteractionEnabled = YES;
    sView.scrollEnabled = YES;
    sView.showsVerticalScrollIndicator = YES;
    if ([self.keyPicArr count] == 0) {
        
        [albumLabelStr setText:@"暂无照片"];
    }
    else{
   
        for (int i = 0; i < [self.keyPicArr count]; i++) {
        
        imageModeViewController *userPic1 = [[self.picDic objectForKey:[self.keyPicArr objectAtIndex:i]]objectAtIndex:0];
            NSString* picUrlStr =  [userPic1 picUrl];
            NSURL  *imageUrl = [NSURL URLWithString:picUrlStr];
            NSData *imageDate = [[NSData alloc]initWithContentsOfURL:imageUrl];
            UIImage * imageCon = [UIImage imageWithData:imageDate];
            UIImageView *imageView;
            if (i > 3 && i < 7) {
                imageView = [[UIImageView alloc]initWithFrame:CGRectMake((i - 4) * 50 + 5*((i - 4)%4+1) , 60, 50, 50)];
            }
            else{
                imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * 50 + 5*(i%4+1) , 0, 50, 50)];
            }
            imageView.userInteractionEnabled = YES;
            [imageView setImage:imageCon];
            imageView.tag = i;
            UITapGestureRecognizer *tg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchPic:)];
            [tg setNumberOfTapsRequired:1];
        [imageView addGestureRecognizer:tg];
        [tg release];
        [sView addSubview:imageView];
        [imageView release];
    }
    [self.view addSubview:sView];
    [sView     release];
    }
}

- (void)touchPic:(id)sender{
    
    SeeSpaceViewController *seeSpaceView = nil;
    seeSpaceView = [[SeeSpaceViewController alloc]init];
    [seeSpaceView.picDic removeAllObjects];
    seeSpaceView.picDic = self.picDic;
    seeSpaceView.attUserNickName = self.userNickName;
    seeSpaceView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:seeSpaceView animated:YES completion:nil];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"photos"])
    {
        self.imageModeTodo = [[imageModeViewController alloc]init];
    }
    else if ([elementName isEqualToString:@"picId"]) {
        [tempStr setString:@""];
    }
    else if ([elementName isEqualToString:@"userId"]){
        [tempStr setString:@""];
    }
    else if ([elementName isEqualToString:@"picAddress"]){
        [tempStr setString:@""];
    }
    else if ([elementName isEqualToString:@"picTime"]){
        [tempStr setString:@""];
    }
    else if ([elementName isEqualToString:@"picFriend"]){
        [tempStr setString:@""];
    }
    else if ([elementName isEqualToString:@"picUrl"]){
        [tempStr setString:@""];
    }
    else if ([elementName isEqualToString:@"picTag"]){
        [tempStr setString:@""];
    }
    else if ([elementName isEqualToString:@"picLove"]){
        [tempStr setString:@""];
    }
    else if ([elementName isEqualToString:@"picLocation"]){
        [tempStr setString:@""];
    }
    else if ([elementName isEqualToString:@"picAlbum"]){
        [tempStr setString:@""];
    }
	else if ([elementName isEqualToString:@"userName"]) {
		[tempStr setString:@""];
	}
    else if ([elementName isEqualToString:@"userPwd"]) {
		[tempStr setString:@""];
	}
    else if ([elementName isEqualToString:@"userNickName"]) {
		[tempStr setString:@""];
	}
    else if ([elementName isEqualToString:@"userTag"]) {
		[tempStr setString:@""];
	}
    else if ([elementName isEqualToString:@"userPic"]) {
		[tempStr setString:@""];
	}
    else if ([elementName isEqualToString:@"picAlbumMonth"]){
      [tempStr setString:@""];
    }
    else if ([elementName isEqualToString:@"attId"]) {
		[tempStr setString:@""];
	}
    else if ([elementName isEqualToString:@"isattuserId"]) {
		[tempStr setString:@""];
	}
    else if ([elementName isEqualToString:@"attuserId"]){
        [tempStr setString:@""];
    }
 
  	else {
		return;
	}
    

}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{

   if([elementName isEqualToString:@"userName"])
	{
        userName = [NSString stringWithString:tempStr];
        
	}
    else if([elementName isEqualToString:@"userPwd"])
    {
        userPwd = [NSString stringWithString:tempStr];
        
    }
    else if ([elementName isEqualToString:@"userNickName"]){
        userNickName = [NSString stringWithString:tempStr];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:userNickName forKey:@"userNickNameConnect"];
        
    }
    else if ([elementName isEqualToString:@"userTag"]){
        userTag = [NSString stringWithString:tempStr];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:userTag forKey:@"userTagConnect"];
    }
    else if ([elementName isEqualToString:@"userPic"]){
        userPic = [NSString stringWithString:tempStr];
    }
    else if ([elementName isEqualToString:@"attuserId"]){
        if (self.isAttantion) {
            
            attentions++;
        }

    }
    
    else if ([elementName isEqualToString:@"isattuserId"]){
        

        if (self.isFans) {
            
            fans++;
        }
    }

    //图片下载
   else if ([elementName isEqualToString:@"photos"]){
        
        NSMutableArray *picArr;
       if ([self.picDic objectForKey:[self.imageModeTodo picAlbumMonth]] == nil) {
           picArr = [[NSMutableArray alloc]init];
           [picArr addObject:self.imageModeTodo];
       }
       else{
           picArr = [self.picDic objectForKey:[self.imageModeTodo picAlbumMonth]];
           [picArr addObject:self.imageModeTodo];
       }
       [self.picDic setObject:picArr forKey:[self.imageModeTodo picAlbumMonth]];
        [self.imageModeTodo release];
    }
    else if ([elementName isEqualToString:@"picId"]){
        self.imageModeTodo.picId =[NSString stringWithString: tempStr];
    }
    else if ([elementName isEqualToString:@"userId"]){
        self.imageModeTodo.userId =[NSString stringWithString: tempStr];
    }
    else if ([elementName isEqualToString:@"picAddress"]){
        self.imageModeTodo.picAddress =[NSString stringWithString: tempStr];
    }
    else if ([elementName isEqualToString:@"picTime"]){
        self.imageModeTodo.picTime = [NSString stringWithString: tempStr];
    }
    else if ([elementName isEqualToString:@"picFriend"]){
        self.imageModeTodo.picFriend = [NSString stringWithString: tempStr];
    }
    else if ([elementName isEqualToString:@"picUrl"]){
        NSCharacterSet* whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        self.imageModeTodo.picUrl = [[NSString stringWithFormat:@"%@",tempStr] stringByTrimmingCharactersInSet:whiteSpace];
    }
    else if ([elementName isEqualToString:@"picTag"]){
        self.imageModeTodo.picTag = [NSString stringWithString: tempStr];
    }
    else if ([elementName isEqualToString:@"picLove"]){
        self.imageModeTodo.picLove = [NSString stringWithString: tempStr];
    }
    else if ([elementName isEqualToString:@"picLocation"]){
        self.imageModeTodo.picLocation = [NSString stringWithString: tempStr];
    }
    else if ([elementName isEqualToString:@"picAlbum"]){
        self.imageModeTodo.picAlbum = [NSString stringWithString: tempStr];
    }
    else if ([elementName isEqualToString:@"picAlbumMonth"]){
        self.imageModeTodo.picAlbumMonth = [NSString stringWithString: tempStr];
    }

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [tempStr appendString:string];
    self.tempStrCopy = string;
}

-(void)returnBack:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [super dealloc];
    [receivedData release];
    [self.tempStrCopy release];
    [self.imageModeTodo release];
    [self.picDic release];
    [self.reciveUserNickName release];
    [self.reciveUserTag release];
    [self.reciveUserHeadPic release];

}

@end
