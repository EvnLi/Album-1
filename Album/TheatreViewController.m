//
//  TheatreViewController.m
//  Album
//
//  Created by smq on 13-8-21.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "TheatreViewController.h"
#import "ASIFormDataRequest.h"
#import "CustomTableViewCell.h"
CGFloat keyboardHeight;
CGFloat point_view_y;
@interface TheatreViewController ()

@end

@implementation TheatreViewController
@synthesize navCon,navBar,navItem,tableViewPic,userNameStr;
@synthesize theatrePicArr,theatrePicArrCopy,theatreTitleStr,downDicPic;
@synthesize receivedData,disName,disContent,disArr,disTextStr;
/*
- (id) init{
    self = [super init];
    if (self) {
        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -8);
        [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:25.f] forKey:UITextAttributeFont] forState:UIControlStateNormal];
        self.tabBarItem.title = @"剧场";
    }
    return self;
}
*/
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
    disArr      = [[NSMutableArray alloc]init];
    disMode     = [[DisMode alloc]init];
    receivedData = [[NSMutableData alloc]init];
    _tempStr     = [[NSMutableString alloc]init];
    self.addDisPicStr = [[NSString alloc]init];
    self.disTempStr = [[NSMutableString alloc]init];
    theatrePicArrCopy = [[NSMutableArray alloc]init];
    self.disTextStr = [[NSString alloc]init];
    
    
    //处理键盘事件
    [self registerForKeyboardNotifications];
    

 

    downDicPic = [[NSMutableDictionary alloc]init];
    
    _pictures = [[NSMutableDictionary alloc] init];
    
    tableViewPic = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 44 - 61)];
    tableViewPic.delegate = self;
    tableViewPic.dataSource = self;
    tableViewPic.backgroundColor = [UIColor grayColor];
    tableViewPic.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableViewPic];
//    [self performSelector:@selector(downloadImage:) withObject:nil];
    
    

    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_pictures removeAllObjects];
//    [theatrePicArrCopy removeAllObjects];
    theatrePicArrCopy = theatrePicArr;
    [disArr removeAllObjects];
    disCount = -1;
    for (int i = 0; i < [theatrePicArrCopy count]; i++) {
        NSMutableDictionary *initDicDown = [[NSMutableDictionary alloc]init];
        [initDicDown setObject:[NSNumber numberWithBool:NO] forKey:@"isSelect"];
        [initDicDown setObject:[NSNumber numberWithInt:-1] forKey:@"selectSection"];
        [downDicPic setObject:initDicDown forKey:[NSString stringWithFormat:@"%d",i]];
    }
    [navItem setTitle:theatreTitleStr];
    [self performSelector:@selector(downloadImage:) withObject:nil];
}

- (void)registerForKeyboardNotifications{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) downloadImage:(id) sender{
    for (imageModeViewController* mode in theatrePicArrCopy){
        NSURL* url = [[NSURL alloc]initWithString:[mode picUrl]];
        NSData *imageDate = [[NSData alloc]initWithContentsOfURL:url];
        UIImage * imageCon = [UIImage imageWithData:imageDate];
        [_pictures setObject:imageCon forKey:[mode picUrl]];
    }
    [tableViewPic reloadData];
}
#pragma mark 处理键盘事件

- (void)keyboardWillShown:(NSNotification*)aNotification{
    NSDictionary *info = [aNotification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    keyboardHeight = keyboardSize.height;
    
    self.tableViewPic.frame = CGRectMake(0.0, 0, 320.0,[[UIScreen mainScreen]bounds].size.height -44-20);
       double y = [[UIScreen mainScreen]bounds].size.height - keyboardHeight - point_view_y + 57;
        self.tableViewPic.contentOffset = CGPointMake(0.0, self.tableViewPic.contentOffset.y - y);
}

- (void)keyboardWillHidden:(NSNotification*)aNotification{
    
    NSDictionary *info = [aNotification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    keyboardHeight = keyboardSize.height;
    
    self.tableViewPic.frame = CGRectMake(0.0, 0, 320.0,[[UIScreen mainScreen]bounds].size.height -44-20);
    double y = [[UIScreen mainScreen]bounds].size.height - keyboardHeight - point_view_y + 57;
    self.tableViewPic.contentOffset = CGPointMake(0.0, self.tableViewPic.contentOffset.y + y);

}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    UITableViewCell *tableCell = (UITableViewCell*)[textView superview].superview;
                                
    CGPoint point_ = [ [tableCell  viewWithTag:[textView tag]] convertPoint:textView.center toView:self.view];
    point_view_y = point_.y;
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    self.disTextStr = @"";
    self.disTextStr = textView.text;
    disTag = [textView tag];

}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 160;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ([theatrePicArrCopy count] == 0) {
        UIView * headView = [[[UIView alloc]init]autorelease];
        return headView;
    }
    UIView *headView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 110)]autorelease];
     imageModeViewController *newImageTodo = nil;
     newImageTodo = [theatrePicArrCopy objectAtIndex:section];
     UIImage * imageCon = [_pictures objectForKey:[newImageTodo picUrl]];//[UIImage imageWithData:imageDate];
     UIImageView *imageView;
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100, 15, 200, 110)];
       imageView.contentMode = UIViewContentModeScaleAspectFit;
         [imageView setImage:imageCon];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchPic:)];
    [tg setNumberOfTapsRequired:1];
    [imageView addGestureRecognizer:tg];
    [tg release];
          [headView addSubview:imageView];
         [imageView release];


   UIButton *mapBtnStr = [[UIButton alloc]initWithFrame:CGRectMake(15,headView.frame.size.height - 20, 20, 20)];
    [mapBtnStr setBackgroundImage:[UIImage imageNamed:@"map.png"] forState:UIControlStateNormal];
    [mapBtnStr  addTarget:self action:@selector(mapBtn:) forControlEvents:UIControlEventTouchUpInside];
       mapBtnStr.autoresizingMask  = UIViewAutoresizingFlexibleTopMargin;
       mapBtnStr.tag = section;
   [headView addSubview:mapBtnStr];
     [mapBtnStr release];
    UILabel *informationLable = [[UILabel alloc]initWithFrame:CGRectMake(15 + 30,  headView.frame.size.height - 26, 180, 20)];
    informationLable.backgroundColor = [UIColor grayColor];
       informationLable.autoresizingMask  = UIViewAutoresizingFlexibleTopMargin;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
     NSString *informationStr = [NSString stringWithFormat:@"%@ %@ By %@",[newImageTodo picAddress],theatreTitleStr,[ud objectForKey: @"userNickNamePath"]];
   [informationLable setText:informationStr];
      [informationLable setFont:[UIFont systemFontOfSize:12]];
      [headView addSubview:informationLable];
      [informationLable release];
   
       UIButton *loveBtnStr = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, headView.frame.size.height - 20, 20, 20)];
     [loveBtnStr setBackgroundImage:[UIImage imageNamed:@"love.png"] forState:UIControlStateNormal];
      [loveBtnStr  addTarget:self action:@selector(loveBtn:) forControlEvents:UIControlEventTouchUpInside];
       loveBtnStr.autoresizingMask  = UIViewAutoresizingFlexibleTopMargin;
      loveBtnStr.tag = section;
      [headView addSubview:loveBtnStr];
        [loveBtnStr release];
  
 
     UIButton *discusBtnStr = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 30, headView.frame.size.height- 20  , 20, 20)];
     [discusBtnStr setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
       [discusBtnStr  addTarget:self action:@selector(discusBtn:) forControlEvents:UIControlEventTouchUpInside];
     discusBtnStr.autoresizingMask  = UIViewAutoresizingFlexibleTopMargin;
    discusBtnStr.tag = section;
      [headView addSubview:discusBtnStr ];
      [discusBtnStr  release];
    
    NSDictionary *dic = [downDicPic objectForKey:[NSString stringWithFormat:@"%d" ,section]];
    //如果是下拉状态  让button选中
    if([[dic objectForKey:@"isSelect"] boolValue] == YES)
    {
//        [disArr removeAllObjects];
        [discusBtnStr setSelected:YES]; //设置btn的状态  因为在tableview reloadData的时候  isSelected又变为了NO
    }

    return headView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *DicCurrent = [downDicPic objectForKey:[NSString stringWithFormat:@"%d",section]];
    BOOL isClickDown = [[DicCurrent objectForKey:@"isSelect"]boolValue];
    NSInteger clickSection = [[DicCurrent objectForKey:@"selectSection"]intValue];
    if (clickSection == -1) {
        return 0;
    }
    else if (!isClickDown && clickSection ==section ) {
        return 0;
    }
    else{
        
//        [disArr removeAllObjects];
            return 1;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_pictures count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200.0;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CustomCell";
    
    [tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    imageModeViewController *newImageTodo = [theatrePicArrCopy objectAtIndex:indexPath.row];
    cell.tagInputStr = [newImageTodo picTag];
    UITextView *disText = [[UITextView alloc]initWithFrame:CGRectMake(20, 70, 200, 60)];
    disText.delegate = self;
    disText.tag = indexPath.row + 10;
    disText.editable = NO;
    
    UITextView *disTextInput = [[UITextView alloc]initWithFrame:CGRectMake(20, 135, 200, 25)];
    disTextInput.delegate = self;
    disTextInput.tag = indexPath.row + 10;
    [disTextInput sizeToFit];
    [cell.contentView addSubview:disTextInput];
    [disTextInput release];
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame =CGRectMake(230, 135, 70, 25);
    [commentBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [commentBtn setTitle:@"发表" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
    [commentBtn setBackgroundColor:[UIColor whiteColor]];
    commentBtn.tag = indexPath.row + 10;
    [cell.contentView addSubview:commentBtn];
//    [commentBtn release];
    
    [cell.contentView addSubview:disText];
    [disText release];
    
//    imageModeViewController *newImageTodo = nil;
//    newImageTodo = [theatrePicArrCopy objectAtIndex:i];
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    self.isDisUp = YES;

    NSString *urlString = [[NSString stringWithFormat:@"%@discuss?method=select&wherepicId=(int)%d&orderby=disId&order=desc",kURL, [[[theatrePicArrCopy objectAtIndex:indexPath.section] picId]intValue]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlString]];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection release];
//            });
    
//                dispatch_async(dispatch_get_main_queue(), ^{
    if ([disArr count] == 0&& self.isDisEmpty == NO) {
       disText.text = [NSString stringWithFormat:@"\n暂无评论"]; 
    }
    else if ([disArr count] == 0&& self.isDisEmpty == YES){
    
        disText.text = [NSString stringWithFormat:@"\n暂无评论"];
        self.isDisUp = NO;
    }
        
    else{
        NSString *appendStr = nil;
        appendStr = [[NSString alloc]init];
        for (int i = 0; i < [disArr count]; i++) {
            self.isDisUp = NO;
            NSString *disNameStr = [NSString stringWithString:[[disArr objectAtIndex:i]disName]];
            NSString *disContentStr = [NSString stringWithString:[[disArr objectAtIndex:i]disContent]];
            disContentStr = [disContentStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            disContentStr = [disContentStr stringByAppendingString:@"\n"];
            NSString *disStr = [NSString stringWithFormat:@"%@: %@",[disNameStr stringByReplacingOccurrencesOfString:@"\n" withString:@""],disContentStr];
            appendStr = [appendStr stringByAppendingString:disStr];
        }
        disText.text = appendStr;
        [disArr removeAllObjects];
        
    
    }
//                });
    cell.loveInputStr = [newImageTodo picLove];
    return cell;

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

    if (self.isLove) {
        
        self.isLove = NO;
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"图片" message:@"添加喜欢成功" delegate:self cancelButtonTitle:@"确定"otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        [tableViewPic reloadData];
    }

    else if (self.isDiscomment){
        self.isDiscomment = NO;
        [self viewWillAppear:YES];
    }
    else{
	NSXMLParser* parser=[[NSXMLParser alloc]initWithData:receivedData];
	parser.delegate=self;
	[parser parse];
	[parser release];
    }
 }

#pragma mark NSXMLParser

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    if (self.isDisUp) {
        self.isDisEmpty = NO;
        [disArr removeAllObjects];
        disCount = -1;
    }

//    if (self.isDis) {
//        disCount++;
//    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //	[self.tableview reloadData];
    if (self.isDisUp) {
//    dispatch_async(dispatch_get_main_queue(), ^{
        self.isDisUp = NO;
        if ([disArr count] == 0) {
            self.isDisEmpty = YES;
        }
        [tableViewPic reloadData];
//    });
    }
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"discuss"])
	{
        
//		disMode = [[DisMode alloc]init];
	}
    
    else if ([elementName isEqualToString:@"disId"])
	{
//        [self.disTempStr setString:@""];
		[_tempStr setString:@""];
	}
	else if ([elementName isEqualToString:@"picId"]) {
//         [self.disTempStr setString:@""];
		[_tempStr setString:@""];
	}
	else if ([elementName isEqualToString:@"disName"]) {
//         [self.disTempStr setString:@""];
		[_tempStr setString:@""];
	}
    else if ([elementName isEqualToString:@"disContent"]) {
//         [self.disTempStr setString:@""];
		[_tempStr setString:@""];
	}
  	else {
		return;
	}
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"discuss"])
    {
//        [[disArr objectAtIndex:disCount]addObject:disMode];
//        [disArr addObject:disMode];
//        [disMode release];
        //        userId = [NSString stringWithString:_tempStr];
    }
    else if([elementName isEqualToString:@"disId"])
    {
        if (self.isDisUp) {

        DisMode *newDisMode = nil;
        newDisMode = [[DisMode alloc]init];
        [disArr addObject:newDisMode];
        disCount++;
        ((DisMode*)[disArr objectAtIndex:disCount]).disId = [NSString stringWithString:_tempStr];
                    }
//         disMode.disId = [NSString stringWithString:_tempStr];
    }
    else if([elementName isEqualToString:@"picId"])
	{
//        disMode.picId = [NSString stringWithString:_tempStr];
        if (self.isDisUp) {
        ((DisMode*)[disArr objectAtIndex:disCount]).picId = [NSString stringWithString:_tempStr];
                }
	}
    else if([elementName isEqualToString:@"disName"])
    {
//       disMode.disName = [NSString stringWithString:_tempStr];
        if (self.isDisUp) {
        ((DisMode*)[disArr objectAtIndex:disCount]).disName = [NSString stringWithString:_tempStr];
                    }
        
    }
    else if ([elementName isEqualToString:@"disContent"]){
        if (self.isDisUp) {

           ((DisMode*)[disArr objectAtIndex:disCount]).disContent = [NSString stringWithString:_tempStr];

                    }
    }
    else {
        
    }
    //图片下载
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (self.isDisUp) {

        if ([string isEqualToString:@""] == NO && [string isEqualToString:@"\n"] == NO){
        [_tempStr appendString:string];
        }
    }
    
}


#pragma mark 图片下面处理按钮响应事件
- (void)mapBtn:(id)sender{
    
    MapViewController *mapView = nil;
    mapView = [[MapViewController alloc]init];
    imageModeViewController *newImageTodo = nil;
    newImageTodo = [theatrePicArrCopy objectAtIndex:[(UIButton*)sender tag]];
    mapView.locationStr = [newImageTodo picLocation];
    mapView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self  presentViewController:mapView animated:YES completion:nil];
    
}

#pragma mark 按钮响应事件

- (void)comment:(id)sender{

    if ([self.disTextStr isEqualToString:@""] == NO) {
    
    self.isDiscomment = YES;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *disNameStr = [NSString stringWithString:[ud objectForKey:@"userNickNamePath"]];
    NSString *picIdStr = [NSString stringWithString:[[theatrePicArrCopy objectAtIndex:(disTag - 10)]picId]];
        self.addDisPicStr = picIdStr;
    NSString *str = [[NSString stringWithFormat: @"%@discuss?method=insert&picId=(int)%d&disName=(string)%@&disContent=(string)%@\n",kURL, [picIdStr intValue],disNameStr,self.disTextStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: str]];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection release];
            }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"评论" message:@"评论不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

- (void)touchPic:(id)sender{

    TheaterModeViewController *theaterModeController = [[TheaterModeViewController alloc]init];
    theaterModeController.picShowArr = theatrePicArr;
    [self presentViewController:theaterModeController animated:YES completion:nil];
    [theaterModeController release];
}
- (void)loveBtn:(id)sender{
    imageModeViewController *newImageTodo = nil;
    newImageTodo = [theatrePicArrCopy objectAtIndex:[(UIButton*)sender tag]];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *userNickName = [ud objectForKey:@"userNickNamePath"];
    NSRange rang = [[newImageTodo picLove] rangeOfString:userNickName];
    NSString *picLoveStr = [NSString stringWithString:[newImageTodo picLove]];
    picLoveStr = [picLoveStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (rang.location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"图片喜爱" message:@"你已经喜欢过了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else{
        
        self.isLove = YES;
        
        if ([picLoveStr length] == 0 || [picLoveStr isEqualToString:@"\n"] ) {
            picLoveStr = userNickName;
        }
        else{
            picLoveStr = [picLoveStr stringByAppendingString:[NSString stringWithFormat:@",%@",userNickName]];
        }
        
       ((imageModeViewController*)[theatrePicArrCopy objectAtIndex:[(UIButton*)sender tag]]).picLove = picLoveStr;
        NSString *picId = [newImageTodo picId];
        NSString *str = [[NSString stringWithFormat: @"%@photos?method=update&wherepicId=(int)%d&picLove=(string)%@",kURL, [picId intValue],picLoveStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: str]];
        NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection release];
    }
}
- (void)discusBtn:(id)sender{
    UIButton *btn = (UIButton*)sender;

    if(btn.isSelected)
    {
        [btn setSelected:NO];
    }
    else
    {
        [btn setSelected:YES];
    }
    NSMutableDictionary *selectDic = [downDicPic objectForKey:[NSString stringWithFormat:@"%d",btn.tag]];
    if (btn.isSelected) {
        [selectDic setObject:[NSNumber numberWithBool:YES] forKey:@"isSelect"];
    }
    else{
        [selectDic setObject:[NSNumber numberWithBool:NO] forKey:@"isSelect"];
    }
    [selectDic setObject:[NSNumber numberWithInt:[btn tag]] forKey:@"selectSection"];
    [downDicPic setObject:selectDic forKey:[NSString stringWithFormat:@"%d",[btn tag]]];
    [tableViewPic reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissKeyboad{
    [self resignFirstResponder];
}


- (IBAction)theatreMode:(id)sender{
    
    TheaterModeViewController *theatreMode = nil;
    theatreMode = [[TheaterModeViewController alloc]init];
    theatreMode.picShowArr = theatrePicArrCopy;
    theatreMode.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self  presentViewController:theatreMode animated:YES completion:nil];
}
- (IBAction)returnBack:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc{
    [super dealloc];
    [self.disTextStr release];
    [downDicPic    release];
    [theatrePicArr release];
    [receivedData release];
    [_tempStr     release];
    [self.addDisPicStr release];
    [self.disTempStr release];
    [disMode      release];
    [disArr       release];
}


@end
