//
//  DMViewController.m
//  DMFilterView
//
//  Created by Thomas Ricouard on 19/04/13.
//  Copyright (c) 2013 Thomas Ricouard. All rights reserved.
//

#import "DMViewController.h"

@interface DMViewController ()
@end

@implementation DMViewController
//@synthesize theatreView;
@synthesize UserNameLaber,Laber,PicturePath,PictureImageView,UserNameStr,LaberStr,userNickNameStr,userIdPathStr,albumNum,fansNum;
//UItableView 表格显示
@synthesize tableView,keystableView;
//UItableView 表格显示end
@synthesize picPathStr=_picPathStr;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    picPathStr = [[NSString alloc]init];
    pictureArr = [[NSMutableArray alloc]init];

    [SVProgressHUD dismiss];
    self.receivedData = [[NSMutableData alloc]init];
    self.tempStr = [[NSMutableString alloc] init];
    self.imageModeTodo = [[imageModeViewController alloc]init];
//    self.imageModeTodoList = [[NSMutableArray alloc]init];
    self.picDic = [[NSMutableDictionary alloc]init];
    self.picDataDic = [[NSMutableDictionary alloc]init];
    self.picTimeStr = [[NSMutableString alloc]init];
//设置iphone4 与iphone5
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-18)];
//点击头像进入个人资料界面
    PictureImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeUserInfor:)];
    [tg setNumberOfTapsRequired:1];
    [PictureImageView addGestureRecognizer:tg];
    [tg release];
    

    
    //UItableView 表格显示
    keystableView = [[NSMutableArray alloc]init];
    //UItableView 表格显示end
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        
            tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, 320, 278)];
    }
    else{
            tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, 320, 366)];
    }
         fansNum.text = @"暂无粉丝";
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor grayColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
#pragma mark 从服务器下载图片在视图上显示
    self.isLoadPic = YES;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *userIdStr = [ud objectForKey:@"userIdPath"];
    NSString *urlPicString = [[NSString stringWithFormat:@"%@photos?method=select&whereuserId=(int)%@",kURL, userIdStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *requestPic = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlPicString]];
    NSURLConnection* connectionPic = [[NSURLConnection alloc] initWithRequest:requestPic delegate:self];
    [connectionPic release];
#pragma  mark从服务器下载图片在视图上显示结束
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
//    [self.imageModeTodoList removeAllObjects];
//    [self.picDic removeAllObjects];
//    [self.keystableView removeAllObjects];
//    [self.picDataDic removeAllObjects];
    

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    self.picPathStr = [ud objectForKey:@"picPath"];
    UserNameLaber.text = [ud objectForKey:@"userNickNamePath"];
    NSString *tagStr = [NSString stringWithString:[ud objectForKey:@"tagPath"]];
    if ([tagStr isEqualToString:@"null"]||[tagStr isEqualToString:@""]) {
        
        Laber.text = @"暂无标签";
    }
    else{
        
        NSString *tagPathStr = [NSString stringWithString:[ud objectForKey: @"tagPath"]];
        NSMutableArray *tagLabArr = [[NSArray arrayWithArray:[tagPathStr componentsSeparatedByString:@","]]mutableCopy];
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
        Laber.text = tagNmaeArrBtnStr;
    }
    NSURL *picUrl = [[NSURL alloc]initWithString:self.picPathStr];
    NSData *picDate = [NSData dataWithContentsOfURL:picUrl];
    [PictureImageView setImage:[UIImage imageWithData:picDate]];
//#pragma mark 从服务器下载图片在视图上显示
//    self.isLoadPic = YES;
//    NSString *userIdStr = [ud objectForKey:@"userIdPath"];
//    NSString *urlPicString = [[NSString stringWithFormat:@"%@photos?method=select&whereuserId=(int)%@",kURL, userIdStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSMutableURLRequest *requestPic = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlPicString]];
//    NSURLConnection* connectionPic = [[NSURLConnection alloc] initWithRequest:requestPic delegate:self];
//    [connectionPic release];
//#pragma  mark从服务器下载图片在视图上显示结束
    
}

#pragma mark NSURLConnectionDelegate

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
     
     if (self.isLoadPic) {
     [self.picDic removeAllObjects];
     [self.keystableView removeAllObjects];
     [self.picDataDic removeAllObjects];
              }
 //图片下载
 
 }
 - (void)parserDidEndDocument:(NSXMLParser *)parser
 {
     if (self.isLoadPic == YES) {
         
         self.isLoadPic = NO;
      NSArray *keyArr = [[NSArray alloc]initWithArray:[self.picDic allKeys]];
     for (int i = 0; i < [keyArr count]; i++) {
         NSLog(@"key=%@",[keyArr objectAtIndex:i]);
     }
     [keystableView addObjectsFromArray:[self.picDic allKeys]];
//     dispatch_async(dispatch_get_main_queue(), ^{
         if ([[self.picDic allKeys]count] == 0 ) {
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"图片" message:@"加载失败或者还未添加" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
             [alert show];
             [alert release];
             
            albumNum.text = [NSString stringWithFormat:@"%d",[keystableView count]];
             return ;
         }
         
         NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *userIdStr = [ud objectForKey:@"userIdPath"];
         conTag = 0;
         self.isFans = YES;
         NSString *urlConString = [[NSString stringWithFormat:@"%@attention?method=select&whereisattuserId=(int)%@",kURL, userIdStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
         NSMutableURLRequest *requestCon = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlConString]];
         NSURLConnection* connectionCon = [[NSURLConnection alloc] initWithRequest:requestCon delegate:self];
         [connectionCon release];
         
         //下载网络图片数据保存到数组中
//         for (int i = 0; i < [keyArr count] ; i++)
//         {
//             NSArray *picArr = nil;
//             picArr = [NSArray arrayWithArray:[self.picDic objectForKey:[keyArr objectAtIndex:i]]];
//             NSMutableArray *picDataArr = nil;
//             picDataArr = [[NSMutableArray alloc]init];
//             for (int j = 0; j < [picArr count]; j++) {
//                 
//                 imageModeViewController *newImageTodo = nil;
//                 newImageTodo = [picArr objectAtIndex:j];
//                 NSString* picUrlStr =  [newImageTodo picUrl];
////                 NSLog(@"picUrlStr = %@",picUrlStr);
//                 NSURL  *imageUrl = [NSURL URLWithString:picUrlStr];
//                 NSData *imageDate = [[NSData alloc]initWithContentsOfURL:imageUrl];
//                 [picDataArr addObject:imageDate];
//             }
//             [self.picDataDic setObject:picDataArr forKey:[keyArr objectAtIndex:i]];
//         }
         
      [tableView reloadData];
//     });
     albumNum.text = [NSString stringWithFormat:@"%d",[keystableView count]];
     
     }
     else if (self.isFans) {
         
      fansNum.text = [NSString stringWithFormat:@"%d",conTag];
     }
 }

 - (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
 {
 if ([elementName isEqualToString:@"photos"])
 {
 self.imageModeTodo = [[imageModeViewController alloc]init];
 }
 else if ([elementName isEqualToString:@"picId"]) {
 [_tempStr setString:@""];
 }
 else if ([elementName isEqualToString:@"userId"]){
 [_tempStr setString:@""];
 }
 else if ([elementName isEqualToString:@"picAddress"]){
 [_tempStr setString:@""];
 }
 else if ([elementName isEqualToString:@"picTime"]){
 [_tempStr setString:@""];
 }
 else if ([elementName isEqualToString:@"picFriend"]){
 [_tempStr setString:@""];
 }
 else if ([elementName isEqualToString:@"picUrl"]){
 [_tempStr setString:@""];
 }
 else if ([elementName isEqualToString:@"picTag"]){
 [_tempStr setString:@""];
 }
 else if ([elementName isEqualToString:@"picLove"]){
 [_tempStr setString:@""];
 }
 else if ([elementName isEqualToString:@"picLocation"]){
 [_tempStr setString:@""];
 }
 else if ([elementName isEqualToString:@"picAlbum"]){
 [_tempStr setString:@""];
 }
 else if ([elementName isEqualToString:@"attId"]){
     [_tempStr setString:@""];
 }
 else if ([elementName isEqualToString:@"isattuserId"]){
     [_tempStr setString:@""];
 }
 else if ([elementName isEqualToString:@"attuserId"]){
     [_tempStr setString:@""];
 }
 else if ([elementName isEqualToString:@"picAlbumMonth"]){
   [_tempStr setString:@""];
 }
 else {
 return;
 }
 
 }
 - (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
 {
 //图片下载
 if ([elementName isEqualToString:@"photos"]){
 
     if (self.isLoadPic == YES) {
    
     NSMutableArray *picArr = nil;
     NSMutableArray *picDataArr = nil;
     if ([self.picDic objectForKey:[self.imageModeTodo picAlbumMonth]] == nil) {
         picArr = [[NSMutableArray alloc]init];
         [picArr addObject:self.imageModeTodo];
         if ([self.picDataDic objectForKey:[self.imageModeTodo picAlbumMonth]] == nil) {
             
            picDataArr = [[NSMutableArray alloc]init];
             NSURL  *imageUrl = [NSURL URLWithString:[self.imageModeTodo picUrl]];
             NSData *imageDate = [[NSData alloc]initWithContentsOfURL:imageUrl];
            [picDataArr addObject:imageDate];
         }
     }
     else{
         
         picArr = [self.picDic objectForKey:[self.imageModeTodo picAlbumMonth]];
         [picArr addObject:self.imageModeTodo];
         if ([self.picDataDic objectForKey:[self.imageModeTodo picAlbumMonth]] != nil) {
             
             picDataArr = [self.picDataDic objectForKey:[self.imageModeTodo picAlbumMonth]];
             NSURL  *imageUrl = [NSURL URLWithString:[self.imageModeTodo picUrl]];
             NSData *imageDate = [[NSData alloc]initWithContentsOfURL:imageUrl];
             if ([picDataArr count] < 4) {
                 
                 [picDataArr addObject:imageDate];
             }
         }
         
     }
     [self.picDic setObject:picArr forKey:[self.imageModeTodo picAlbumMonth]];
         if ([picDataArr count] < 4) {
             
                [self.picDataDic setObject:picDataArr forKey:[self.imageModeTodo picAlbumMonth]];
         }

          [self.imageModeTodo release];
        }
 }
else if ([elementName isEqualToString:@"picId"]){
 self.imageModeTodo.picId =[NSString stringWithString: _tempStr];
 }
 else if ([elementName isEqualToString:@"userId"]){
 self.imageModeTodo.userId =[NSString stringWithString: _tempStr];
 }
 else if ([elementName isEqualToString:@"picAddress"]){
 self.imageModeTodo.picAddress =[NSString stringWithString: _tempStr];
 }
 else if ([elementName isEqualToString:@"picTime"]){
 self.imageModeTodo.picTime = [NSString stringWithString: _tempStr];
 }
 else if ([elementName isEqualToString:@"picFriend"]){
 self.imageModeTodo.picFriend = [NSString stringWithString: _tempStr];
 }
 else if ([elementName isEqualToString:@"picUrl"]){
     
     
     NSCharacterSet* whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
     self.imageModeTodo.picUrl = [[NSString stringWithFormat:@"%@",_tempStr] stringByTrimmingCharactersInSet:whiteSpace];
 }
 else if ([elementName isEqualToString:@"picTag"]){
 self.imageModeTodo.picTag = [NSString stringWithString: _tempStr];
 }
 else if ([elementName isEqualToString:@"picLove"]){
 self.imageModeTodo.picLove = [NSString stringWithString: _tempStr];
 }
 else if ([elementName isEqualToString:@"picLocation"]){
 self.imageModeTodo.picLocation = [NSString stringWithString: _tempStr];
 }
 else if ([elementName isEqualToString:@"picAlbum"]){
 self.imageModeTodo.picAlbum = [NSString stringWithString: _tempStr];
 }
 else if ([elementName isEqualToString:@"picAlbumMonth"]){
     self.imageModeTodo.picAlbumMonth = [NSString stringWithString: _tempStr];
 }
 else if ([elementName isEqualToString:@"attention"]){
     if (self.isFans) {
         
         conTag++;
     }

 }

}


 - (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
 [_tempStr appendString:string];
     self.urlstr = [string retain];
 }
 


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//UItableView 表格显示begin
#pragma mark UITableViewDataSource,UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdetify = @"cellIdentify";
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:reuseIdetify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdetify] autorelease];
    }

    NSArray *allPicArr = nil;
    allPicArr = [self.picDic objectForKey:[keystableView objectAtIndex:indexPath.row]];
    
    NSArray *picDateArr = nil;
//    NSLog(@"%@",[[self.picDataDic objectForKey:[keystableView objectAtIndex:indexPath.row]]objectAtIndex:0]);
    picDateArr = [self.picDataDic objectForKey:[keystableView objectAtIndex:indexPath.row]];
     UIView *imagesBack = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 220, 150)];
    imagesBack.backgroundColor = [UIColor whiteColor];
    int counts;
    if ([picDateArr count] > 4) {
        counts = 4;
    }
    else{
        counts = [picDateArr count];
    }
    if (counts == 1) {
        UIImageView *imageView;
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20 , 20, 130, 100)];
        //图片排列
        imageView.userInteractionEnabled = YES;
        imageView.tag = indexPath.row;
        [imageView setImage:[UIImage imageNamed:@"bg_logo"]];
        [imagesBack addSubview:imageView];
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            imageModeViewController *newImageTodo = nil;
            newImageTodo = [allPicArr objectAtIndex:0];
//            NSString* picUrlStr =  [newImageTodo picUrl];
//            NSURL  *imageUrl = [NSURL URLWithString:picUrlStr];
//            NSData *imageDate = [[NSData alloc]initWithContentsOfURL:imageUrl];
            NSData *imageData = [NSData dataWithData:[picDateArr objectAtIndex:0]];
            UIImage * imageCon = [UIImage imageWithData:imageData];
//            NSLog(@"imageData = %@",imageData);
            [imageView setImage:imageCon];
            UITapGestureRecognizer *tp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchPic:)];
            [tp setNumberOfTapsRequired:1];
            [imageView addGestureRecognizer:tp];
//            dispatch_async(dispatch_get_main_queue(), ^{
                [imageView release];
                UILabel *conLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 10, 100, 20)];
                conLable.text = [keystableView objectAtIndex:indexPath.row] ;
                [conLable setFont:[UIFont systemFontOfSize:12]];
                conLable.backgroundColor = [UIColor grayColor];
                [cell.contentView addSubview:conLable];
                [conLable release];
                UILabel *friendLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 35, 100, 20)];
                [friendLable setFont:[UIFont systemFontOfSize:12]];
                [friendLable setBackgroundColor:[UIColor grayColor]];
                [friendLable setText:@"朋友："];
                [cell.contentView addSubview:friendLable];
                [friendLable release];
                UILabel *showFriendLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 60, 100, 60)];
                [showFriendLable setFont:[UIFont systemFontOfSize:12]];
                [showFriendLable setBackgroundColor:[UIColor grayColor]];
                showFriendLable.numberOfLines = 0;
                NSMutableString *friendStr = [[NSMutableString alloc]init];
                for (int i = 0; i < [allPicArr count]; i++) {
                    
                    imageModeViewController *newImageTodo = nil;
                    newImageTodo = [allPicArr objectAtIndex:i];
                    [friendStr appendString:[newImageTodo picFriend]];
                }
                showFriendLable.text = friendStr ;
                [cell.contentView addSubview:showFriendLable];
                [showFriendLable release];
//            });
//        });
    }
    
    
    
    else if (counts == 2){
        for (int i = 0; i < counts; i++) {//下载图片用多线程
            UIImageView *imageView;
            if (i == 0) {
                imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20 , 15, 80, 120)];
            }
            else{
                imageView = [[UIImageView alloc]initWithFrame:CGRectMake(110 , 15, 80, 120)];
            }
            //图片排列
            imageView.userInteractionEnabled = YES;
            imageView.tag = indexPath.row;
            [imageView setImage:[UIImage imageNamed:@"bg_logo"]];
            [imagesBack addSubview:imageView];
            
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                imageModeViewController *newImageTodo = nil;
                newImageTodo = [allPicArr objectAtIndex:i];
//                NSString* picUrlStr =  [newImageTodo picUrl];
//                NSURL  *imageUrl = [NSURL URLWithString:picUrlStr];
//                NSData *imageDate = [[NSData alloc]initWithContentsOfURL:imageUrl];
                NSData *imageData = [NSData dataWithData:[picDateArr objectAtIndex:i]];
//                NSLog(@"imageData = %@",imageData);
                UIImage * imageCon = [UIImage imageWithData:imageData];
                [imageView setImage:imageCon];
                UITapGestureRecognizer *tp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchPic:)];
                [tp setNumberOfTapsRequired:1];
                [imageView addGestureRecognizer:tp];
//                dispatch_async(dispatch_get_main_queue(), ^{
                    [imageView release];
                    UILabel *conLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 10, 100, 20)];
                    conLable.text = [keystableView objectAtIndex:indexPath.row] ;
                    [conLable setFont:[UIFont systemFontOfSize:12]];
                    conLable.backgroundColor = [UIColor grayColor];
                    [cell.contentView addSubview:conLable];
                    [conLable release];
                    UILabel *friendLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 35, 100, 20)];
                    [friendLable setFont:[UIFont systemFontOfSize:12]];
                    [friendLable setBackgroundColor:[UIColor grayColor]];
                    [friendLable setText:@"朋友："];
                    [cell.contentView addSubview:friendLable];
                    [friendLable release];
                    UILabel *showFriendLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 60, 100, 60)];
                    [showFriendLable setFont:[UIFont systemFontOfSize:12]];
                    [showFriendLable setBackgroundColor:[UIColor grayColor]];
                    showFriendLable.numberOfLines = 0;
                    NSString *friendStr = [[NSString alloc]init];
                     friendStr = [[allPicArr objectAtIndex:0]picFriend];
                    for (int i = 0; i < [allPicArr count]; i++) {
                        
                        imageModeViewController *newImageTodo = nil;
                        newImageTodo = [allPicArr objectAtIndex:i];
                        NSRange rang = [friendStr rangeOfString:[newImageTodo picFriend]] ;
                        if (rang.length == 0 ){
                            
                            [friendStr stringByAppendingString:[newImageTodo picFriend]];
                        }
                    }
                     showFriendLable.text = friendStr ;
                    [cell.contentView addSubview:showFriendLable];
                    [showFriendLable release];
//                });
//            });
            [cell.contentView addSubview:imagesBack];
            
        }
    }

    
    
    
    
    else{
    for (int i = 0; i < counts; i++) {//下载图片用多线程
        UIImageView *imageView;
        if (i > 2) {
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake((i - 3) * 50 + 15*(i%3+1) , 79, 57, 62)];
        }
        else{
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * 50 + 15*(i%3+1) , 7, 57, 62)];
        }
        //图片排列
        imageView.userInteractionEnabled = YES;
        imageView.tag = indexPath.row;
        [imageView setImage:[UIImage imageNamed:@"bg_logo"]];
        [imagesBack addSubview:imageView];
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            imageModeViewController *newImageTodo = nil;
            newImageTodo = [allPicArr objectAtIndex:i];
//            NSString* picUrlStr =  [newImageTodo picUrl];
//            NSURL  *imageUrl = [NSURL URLWithString:picUrlStr];
//            NSData *imageDate = [[NSData alloc]initWithContentsOfURL:imageUrl];
            NSData *imageData = [NSData dataWithData:[picDateArr objectAtIndex:i]];
            UIImage * imageCon = [UIImage imageWithData:imageData];
           [imageView setImage:imageCon];
            UITapGestureRecognizer *tp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchPic:)];
            [tp setNumberOfTapsRequired:1];
            [imageView addGestureRecognizer:tp];
//            dispatch_async(dispatch_get_main_queue(), ^{
                [imageView release];
                UILabel *conLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 10, 100, 20)];
                conLable.text = [keystableView objectAtIndex:indexPath.row] ;
                [conLable setFont:[UIFont systemFontOfSize:12]];
                conLable.backgroundColor = [UIColor grayColor];
                [cell.contentView addSubview:conLable];
                [conLable release];
                UILabel *friendLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 35, 100, 20)];
                [friendLable setFont:[UIFont systemFontOfSize:12]];
                [friendLable setBackgroundColor:[UIColor grayColor]];
                [friendLable setText:@"朋友："];
                [cell.contentView addSubview:friendLable];
                [friendLable release];
                UILabel *showFriendLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 60, 100, 60)];
                [showFriendLable setFont:[UIFont systemFontOfSize:12]];
                [showFriendLable setBackgroundColor:[UIColor grayColor]];
                showFriendLable.numberOfLines = 0;
                NSString *friendStr = [[NSString alloc]init];
                friendStr = [[allPicArr objectAtIndex:0]picFriend];
                for (int i = 0; i < [allPicArr count]; i++) {
                    
                    imageModeViewController *newImageTodo = nil;
                    newImageTodo = [allPicArr objectAtIndex:i];
                    NSRange rang = [friendStr rangeOfString:[newImageTodo picFriend]] ;
                    if (rang.length == 0 ){
                        
                        [friendStr stringByAppendingString:[newImageTodo picFriend]];
                    }
                }
                showFriendLable.text = friendStr ;

                [cell.contentView addSubview:showFriendLable];
                [showFriendLable release];
//            });
//        });
        [cell.contentView addSubview:imagesBack];

    }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)changeUserInfor:(id)sender{
    
    UserInformationViewController *userInfor = nil;
    userInfor = [[UserInformationViewController alloc]init];
    userInfor.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:userInfor animated:YES completion:nil];
    
}
#pragma mark 这里跳转到图片浏览模式
- (void)touchPic:(id)sender{
    
    TheatreViewController *theatreView = nil;
    theatreView = [[TheatreViewController alloc]init];
    [theatreView.theatrePicArr removeAllObjects];
    NSLog(@"keystableView.count = %d",keystableView.count);
    theatreView.theatrePicArr =[self.picDic objectForKey:[keystableView objectAtIndex:[[(UITapGestureRecognizer*)sender view] tag]]];
    theatreView.theatreTitleStr = [keystableView objectAtIndex:[[(UITapGestureRecognizer*)sender view] tag]];
    theatreView.userNameStr = _userName;
    theatreView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:theatreView animated:YES];
}
//这里跳转到剧场模式end
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [keystableView count];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

- (void)dealloc{
    [super dealloc];
    [self.tempStr release];
    [self.picDataDic release];
    [self.picDic  release];
    [self.receivedData release];
    [keystableView release];
    [UserNameLaber release];
    [Laber release];
    [pictureArr release];
}


@end

