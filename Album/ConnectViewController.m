

//
//  ConnectViewController.m
//  Album
//
//  Created by smq on 13-8-9.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "ConnectViewController.h"

@interface ConnectViewController ()

@end

@implementation ConnectViewController
@synthesize searchText,searchBtn,receivedData,userAllSearchArr,userSearchHaveConcernArr,userHaveAttentionIdArr,userAttAllSearchArr;
@synthesize searchTodo, userPicCon, userTagCon, userNameCon, tableViewCon, attIdCon,haveAttentionTodo,attTempStr,userHaveAttentionIdArrCopy;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    receivedData = [[NSMutableData alloc]init];
    userAllSearchArr = [[NSMutableArray alloc]init];
    userSearchHaveConcernArr = [[NSMutableArray alloc]init];
    userHaveAttentionIdArr = [[NSMutableArray alloc]init];

    self.removeArr = [[NSMutableArray alloc]init];
    searchTodo = [[ConnectSearchMode alloc]init];
    haveAttentionTodo = [[HaveAttentionMode alloc]init];
    userAttAllSearchArr = [[NSMutableArray alloc]init];
    _tempStr = [[NSMutableString alloc]init];
    self.attTempStr = [[NSString alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    ud = [NSUserDefaults standardUserDefaults];
    

    
    searchText = [[UITextField alloc]initWithFrame:CGRectMake(20, 16, 140, 30)];
    searchText.delegate = self;
    [searchText setBackground:[UIImage imageNamed:@"search"]];
    [searchText setFont:[UIFont systemFontOfSize:14]];
    [searchText setPlaceholder:@"搜索用户名"];
    searchText.adjustsFontSizeToFitWidth = YES;
    searchText.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:searchText];
    [searchText release];
    
    
 
    searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(200, 16, 44, 44)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"btn_search"] forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"btn_search_checked"] forState:UIControlStateHighlighted];
    [searchBtn  addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.autoresizingMask  = UIViewAutoresizingFlexibleBottomMargin;
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:searchBtn];
    [searchBtn release];
    
    //表格视图
    self.isConcern = YES;
    tableViewCon = [[UITableView alloc]initWithFrame:CGRectMake(0, self.searchBtn.frame.origin.y +self.searchBtn.frame.size.height  , 320, 380)];
    tableViewCon.delegate = self;
    tableViewCon.dataSource = self;
    tableViewCon.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:tableViewCon];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [searchText setText:@""];
    
    userHaveAttentionIdArrCopy = [[NSMutableArray alloc]init];
    [userAttAllSearchArr removeAllObjects];
    [userAllSearchArr removeAllObjects];
    [userHaveAttentionIdArr removeAllObjects];
    [userSearchHaveConcernArr removeAllObjects];
    [userHaveAttentionIdArrCopy removeAllObjects];
    [self initHaveConcernTableViewDate];
    [tableViewCon reloadData];
}
- (void)initHaveConcernTableViewDate{
    
    self.isHaveConcernId = YES;
    [searchText setText:@""];
    if ([[ud objectForKey:@"userIdPath"]isEqualToString:@""] == NO) {

    NSString *urlString = [[NSString stringWithFormat:@"%@attention?method=select&whereattuserId=(int)%d",kURL, [[ud objectForKey:@"userIdPath"] intValue]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlString]];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection release];
    }
}

- (void)searchBtn:(id)sender{
    if ([self.searchText.text isEqualToString:@""] == NO ) {
        self.isSearch = YES;
        self.isHaveConcern = NO;
        NSString *urlString = [[NSString stringWithFormat:@"%@pusers?method=select&likeuserNickName=%@",kURL, self.searchText.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlString]];
        NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection release];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"关注" message:@"搜索不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
        [alert release];
    }
//    [tableViewCon reloadData];
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
    
    if (self.isAddAtt){
        if ([userAllSearchArr count] > 0) {
            [userAttAllSearchArr removeAllObjects];
            [userAllSearchArr removeAllObjects];
        }
        self.isAddAtt = NO;
        [self viewWillAppear:YES];
    }
    else if (self.isCancelAtt){
        if ([userAllSearchArr count] > 0) {
            [userAttAllSearchArr removeAllObjects];
            [userAllSearchArr removeAllObjects];
        }
        self.isCancelAtt = NO;
        [self viewWillAppear:YES];
    }
    else if (self.isSearch || self.isHaveConcernId || self.isHaveConcern ){
        NSXMLParser* parser=[[NSXMLParser alloc]initWithData:receivedData];
        parser.delegate=self;
        [parser parse];
        [parser release];
    }
}
#pragma mark NSXMLParser
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    if (self.isSearch) {
        [userAllSearchArr removeAllObjects];
    }
    else if (self.isHaveConcernId){
        [userHaveAttentionIdArr removeAllObjects];
    }
    else if (self.isHaveConcern){
        haveAttCount++;
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (self.isSearch) {

    for (int i = 0; i < [userAllSearchArr count]; i++) {
    }
    if (self.isSearch) {
        self.isSearch = NO;
//        dispatch_async(dispatch_get_main_queue(), ^{
        userAttAllSearchArr = [userAllSearchArr mutableCopy];
        [self.removeArr removeAllObjects];
        if ([userSearchHaveConcernArr count] > 0) {
            for (int i = 0; i < [userAllSearchArr count]; i++)
                for (int j = 0; j < [userSearchHaveConcernArr count]; j++) {
                    if ([[[userAllSearchArr objectAtIndex:i]userNameSearch] isEqualToString: [[userSearchHaveConcernArr objectAtIndex:j]userNameSearch]]) {
                            
                        [self.removeArr addObject:[userAllSearchArr objectAtIndex:i]];
//                        [userAttAllSearchArr removeObjectAtIndex:i];
                    }
            }
            
            for (int i = 0; i < [self.removeArr count]; i++) {
                [userAttAllSearchArr removeObject:[self.removeArr objectAtIndex:i]];
            }
            
        }
        else{

        }
            [tableViewCon reloadData];
    
    }
   }
    else if (self.isHaveConcernId) {
        self.isHaveConcernId = NO;
        self.isHaveConcern = YES;
        haveAttCount = -1;
        userHaveAttentionIdArrCopy = [userHaveAttentionIdArr mutableCopy];
        if ([userHaveAttentionIdArr count] == 1) {
            if ([[[userHaveAttentionIdArr objectAtIndex:0]isattuserId]isEqualToString:@"\n0"]) {
                [userHaveAttentionIdArr removeObjectAtIndex:0];
            }
        }
        
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < [userHaveAttentionIdArr count]; i++) {
            ConnectSearchMode *newConnectSearch = nil;
            newConnectSearch = [[ConnectSearchMode alloc]init];
            [userSearchHaveConcernArr addObject:newConnectSearch];
            NSString *isattuserIdStr = [NSString stringWithString:[[[userHaveAttentionIdArrCopy objectAtIndex:i]isattuserId] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];

        NSString *urlString = [[NSString stringWithFormat:@"%@pusers?method=select&whereuserId=(int)%d",kURL, [isattuserIdStr intValue]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            // 設置URL
            [request setURL:[NSURL URLWithString:urlString]];
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
    
        
        }
//        });
    }
    else if (self.isHaveConcern){
        if (haveAttCount == ([userHaveAttentionIdArr count] - 1)){
            self.isHaveConcern = NO;
//            dispatch_async(dispatch_get_main_queue(), ^{
                [tableViewCon reloadData];
//            });
//            [tableViewCon reloadData];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{

    if ([elementName isEqualToString:@"pUsers"])
	{
        if (self.isSearch) {
            self.searchTodo = [[ConnectSearchMode alloc]init];
        }
        else if (self.isHaveConcern){
            self.haveAttentionTodo = nil;
//            self.haveConcernTodo = [[ConnectSearchMode alloc]init];
        }
	}
    else if ([elementName isEqualToString:@"userId"]) {
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
    else if ([elementName isEqualToString:@"attention"]){
        if (self.isHaveConcernId) {
        haveAttentionTodo = [[HaveAttentionMode alloc]init];
        }
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
	else {
		[_tempStr setString:@""];
	}

    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{

    if ([elementName isEqualToString:@"pUsers"]) {
        if (self.isSearch) {
            [userAllSearchArr addObject:searchTodo];
            [searchTodo release];
        }
        else if (self.isHaveConcern){
        }
    }
    else if ([elementName isEqualToString:@"userId"]) {
        if (self.isSearch) {
            searchTodo.userIdSearch =[NSString stringWithString:_tempStr];
        }
        else if (self.isHaveConcern){
            ((ConnectSearchMode*)[userSearchHaveConcernArr objectAtIndex:haveAttCount]).userIdSearch = [NSString stringWithString:self.attTempStr];

        }
	}
    else if ([elementName isEqualToString:@"userName"]){
        if (self.isSearch) {
            

            searchTodo.userNameSearch =[NSString stringWithString:_tempStr];
        }
        else if (self.isHaveConcern){
                       ((ConnectSearchMode*)[userSearchHaveConcernArr objectAtIndex:haveAttCount]).userNameSearch = [NSString stringWithString:self.attTempStr];
        }
    }
    else if ([elementName isEqualToString:@"userPwd"]){
    }
    else if ([elementName isEqualToString:@"userNickName"]){
        if (self.isSearch) {
            searchTodo.userNickNameSearch = [NSString stringWithString:_tempStr];
        }
        else if (self.isHaveConcern){
           ((ConnectSearchMode*)[userSearchHaveConcernArr objectAtIndex:haveAttCount]).userNickNameSearch = self.attTempStr;

        }
    }
    else if ([elementName isEqualToString:@"userTag"]){
        if (self.isSearch) {
            searchTodo.userTagSearch =[NSString stringWithString:_tempStr];
        }
        else if (self.isHaveConcern){
            ((ConnectSearchMode*)[userSearchHaveConcernArr objectAtIndex:haveAttCount]).userTagSearch = self.attTempStr;
//            haveConcernTodo.userTagSearch = [NSString stringWithString:self.attTempStr];
        }
    }
    else if ([elementName isEqualToString:@"userPic"]){
        if (self.isSearch) {

            searchTodo.userPicSearch = [NSString stringWithString:_tempStr];
        }
        else if (self.isHaveConcern){
            

            ((ConnectSearchMode*)[userSearchHaveConcernArr objectAtIndex:haveAttCount]).userPicSearch = self.attTempStr;
//            haveConcernTodo.userPicSearch = [NSString stringWithString:self.attTempStr];
        }
    }
    else if ([elementName isEqualToString:@"attention"]){
        if (self.isHaveConcernId) {
        }
    }
    else if ([elementName isEqualToString:@"attId"]){
        if (self.isHaveConcernId) {

            [userHaveAttentionIdArr addObject:haveAttentionTodo];
            [haveAttentionTodo release];
            haveAttentionTodo.attId = [NSString stringWithString:_tempStr];
        }
    }
    else if ([elementName isEqualToString:@"isattuserId"]){
        if (self.isHaveConcernId) {
            haveAttentionTodo.isattuserId = [NSString stringWithString:_tempStr];
        }
    }
    else if ([elementName isEqualToString:@"attuserId"]){
        if (self.isHaveConcernId) {
            haveAttentionTodo.attuserId = [NSString stringWithString:_tempStr];
        }
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

    if (self.isHaveConcern) {
        
        self.attTempStr = string;
    }
    else{
            [_tempStr appendString:string];

    }
}
#pragma UITableViewDataSource,UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdetify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdetify] autorelease];
    }
    if (indexPath.section == 0) {
        if ([userAttAllSearchArr count] > 0) {
    ConnectSearchMode *newSearchTodo = nil;
    newSearchTodo = [userAttAllSearchArr objectAtIndex:indexPath.row];
    NSURL  *imageUrl = [[NSURL alloc]initWithString:[newSearchTodo userPicSearch]];
    NSData *imageDate = [[NSData alloc]initWithContentsOfURL:imageUrl];
    UIImage * imageCon = [UIImage imageWithData:imageDate];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, cell.frame.size.height - 4, cell.frame.size.height - 4)];
    imageView.userInteractionEnabled = YES;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [imageView setImage:imageCon];
    imageView.tag = indexPath.row;
    UITapGestureRecognizer *tg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browseSearchData:)];
    [tg setNumberOfTapsRequired:1];
    [imageView addGestureRecognizer:tg];
    [tg release];
    [cell.contentView addSubview:imageView];
    [imageView release];
    
    UILabel *conLable = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.height, 2, 60, 20)];
    conLable.text = [newSearchTodo userNickNameSearch];
    conLable.tag = indexPath.row;
    conLable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [conLable setFont:[UIFont systemFontOfSize:12]];
    [cell.contentView addSubview:conLable];
    [conLable release];
    
    UILabel *conTagLable = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.height, 24, 150, 20)];
    conTagLable.text = [newSearchTodo userTagSearch];
    conTagLable.tag = indexPath.row;
    conTagLable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [conTagLable setFont:[UIFont systemFontOfSize:12]];
    [cell.contentView addSubview:conTagLable];
    [conTagLable release];
    
   


    UIButton *BtnCon = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width - 100, cell.frame.size.height/2 - 15  , 80, 30)];
//    [BtnCon setTitle:@"关注" forState:UIControlStateNormal];
//    [BtnCon setBackgroundColor:[UIColor blueColor]];
    [BtnCon setImage:[UIImage imageNamed:@"attention_normal"] forState:UIControlStateNormal];
    [BtnCon setImage:[UIImage imageNamed:@"attention_pressed"] forState:UIControlStateHighlighted];
    [BtnCon addTarget:self action:@selector(AddAttBtn:) forControlEvents:UIControlEventTouchUpInside];
    BtnCon.tag = indexPath.row + 10;
    BtnCon.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [cell.contentView addSubview:BtnCon];
    [BtnCon release];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    }
}
   else {
        if ([userSearchHaveConcernArr count] > 0) {
            ConnectSearchMode *newSearchTodo = nil;
            newSearchTodo = [userSearchHaveConcernArr objectAtIndex:indexPath.row];
            if ([[newSearchTodo userPicSearch]isEqualToString:@"null"] ==NO) {
            NSURL  *imageUrl = [[NSURL alloc]initWithString:[newSearchTodo userPicSearch]];
            NSData *imageDate = [[NSData alloc]initWithContentsOfURL:imageUrl];
            UIImage * imageCon = [UIImage imageWithData:imageDate];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, cell.frame.size.height - 4, cell.frame.size.height - 4)];
            imageView.userInteractionEnabled = YES;
            imageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
            [imageView setImage:imageCon];
            imageView.tag = indexPath.row;
            UITapGestureRecognizer *tg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browseHaveConcernData:)];
            [tg setNumberOfTapsRequired:1];
            [imageView addGestureRecognizer:tg];
            [tg release];
            [cell.contentView addSubview:imageView];
            [imageView release];
            }
            UILabel *conLable = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.height, 2, 60, 20)];
            conLable.text = [newSearchTodo userNickNameSearch];
            conLable.tag = indexPath.row;
            conLable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
            [conLable setFont:[UIFont systemFontOfSize:12]];
            [cell.contentView addSubview:conLable];
            [conLable release];
            
            UILabel *conTagLable = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.height, 24, 150, 20)];
            conTagLable.text = [newSearchTodo userTagSearch];
            conTagLable.tag = indexPath.row;
            conTagLable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
            [conTagLable setFont:[UIFont systemFontOfSize:12]];
            [cell.contentView addSubview:conTagLable];
            [conTagLable release];
            
            
            
            
            UIButton *BtnCon = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width - 100, cell.frame.size.height/2 - 15  , 80, 30)];
//            [BtnCon setTitle:@"取消关注" forState:UIControlStateNormal];
            [BtnCon setImage:[UIImage imageNamed:@"cancle_att_normal"] forState:UIControlStateNormal];
            [BtnCon setImage:[UIImage imageNamed:@"cancle_att_checked"] forState:UIControlStateHighlighted];
            [BtnCon setBackgroundColor:[UIColor blueColor]];
            [BtnCon addTarget:self action:@selector(CancelAttBtn:) forControlEvents:UIControlEventTouchUpInside];
            BtnCon.tag = indexPath.row + 10;
            BtnCon.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
            [cell.contentView addSubview:BtnCon];
            [BtnCon release];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
 
        }
    }
          return cell;                   

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
    if ([userAllSearchArr count] == 0) {
        UIView * headView = [[[UIView alloc]init]autorelease];
        return headView;
    }
    UIView *headView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,40)]autorelease];
    UILabel *addConcernLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,  -2, 80, 20)];
    addConcernLabel.autoresizingMask  = UIViewAutoresizingFlexibleBottomMargin;
    [addConcernLabel setText:@"增加关注"];
    [addConcernLabel setFont:[UIFont systemFontOfSize:14]];
    [headView addSubview:addConcernLabel];
    [addConcernLabel release];
    return headView;
        
  }
    else {
        if ([userSearchHaveConcernArr count] == 0) {
            UIView * headView = [[[UIView alloc]init]autorelease];
            return headView;
        }
        UIView *headView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)]autorelease];
        UILabel *cancelConcernLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,  -2, 80, 20)];
        cancelConcernLabel.autoresizingMask  = UIViewAutoresizingFlexibleBottomMargin;
        [cancelConcernLabel setText:@"你的关注"];
        [cancelConcernLabel setFont:[UIFont systemFontOfSize:14]];
        [headView addSubview:cancelConcernLabel];
        [cancelConcernLabel release];
        return headView;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return  [userAttAllSearchArr count];
    }
    else {

        return [userSearchHaveConcernArr count];
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}

#pragma mark 处理按钮点击事件
- (void)browseSearchData:(id)sender{

    ConnectSearchMode *newSearchTodo = nil;
    newSearchTodo = [userAttAllSearchArr objectAtIndex:[[(UITapGestureRecognizer*)sender view] tag]];
    ConnectNameMessageViewController   *connectNameMessageView = nil;
    connectNameMessageView = [[ConnectNameMessageViewController alloc]init];
    connectNameMessageView.UserId = [newSearchTodo userIdSearch];
    connectNameMessageView.userNickName = [newSearchTodo userNickNameSearch];
    connectNameMessageView.userTag = [newSearchTodo userTagSearch];
    connectNameMessageView.userHeadPicStr = [newSearchTodo userPicSearch];
    connectNameMessageView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:connectNameMessageView animated:YES completion:nil];
}
- (void)browseHaveConcernData:(id)sender{

    ConnectSearchMode *newSearchTodo = nil;
    newSearchTodo = [userSearchHaveConcernArr objectAtIndex:[[(UITapGestureRecognizer*)sender view] tag]];
    ConnectNameMessageViewController   *connectNameMessageView = nil;
    connectNameMessageView = [[ConnectNameMessageViewController alloc]init];
    connectNameMessageView.UserId = [newSearchTodo userIdSearch];
    connectNameMessageView.userNickName = [newSearchTodo userNickNameSearch];
    connectNameMessageView.userTag = [newSearchTodo userTagSearch];
    connectNameMessageView.userHeadPicStr = [newSearchTodo userPicSearch];
    connectNameMessageView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:connectNameMessageView animated:YES completion:nil];
    
}

- (void)AddAttBtn:(id)sender{
    
    self.isAddAtt = YES;
    self.judgeTag = [(UIButton*)sender tag];
    ConnectSearchMode *newSearchTodo = nil;
    newSearchTodo = [userAttAllSearchArr  objectAtIndex:([(UIButton*)sender tag] - 10)];
    [ud setObject:[newSearchTodo userIdSearch] forKey:@"userIdSearchPath"];
    NSMutableURLRequest *rq = [[NSMutableURLRequest alloc]init];
    NSString *str = [NSString stringWithFormat:@"%@attention?method=insert&isattuserId=(int)%d&attuserId=(int)%d",kURL,[[newSearchTodo userIdSearch]intValue],[[ud objectForKey:@"userIdPath"]intValue]];
    [rq setURL:[NSURL URLWithString:str]];
    NSURLConnection *cn = [[NSURLConnection alloc]initWithRequest:rq delegate:self];
    [cn release];
    
}



- (void)CancelAttBtn:(id)sender{

            self.judgeTag = [(UIButton*)sender tag];
            self.isCancelAtt = YES;
            ConnectSearchMode *newSearchTodo = nil;
            newSearchTodo = [userSearchHaveConcernArr objectAtIndex:([(UIButton*)sender tag] - 10)];
            NSMutableURLRequest *rq = [[NSMutableURLRequest alloc]init];
            NSString *str = [NSString stringWithFormat: @"%@attention?method=delete&whereisattuserId=(int)%d&whereattuserId=(int)%d",kURL,[[newSearchTodo userIdSearch]intValue],[[ud objectForKey:@"userIdPath"]intValue]];
            [rq setURL:[NSURL URLWithString:str]];
            NSURLConnection *cn = [[NSURLConnection alloc]initWithRequest:rq delegate:self];
            [cn release];
}


#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [searchText resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [super dealloc];
    [tableViewCon release];
    [receivedData release];
    [userAllSearchArr release];
    [userSearchHaveConcernArr release];
    [userHaveAttentionIdArr release];
    [userHaveAttentionIdArrCopy release];
    [userAttAllSearchArr release];
    [searchTodo release];
    [self.removeArr release];
//    [haveConcernTodo release];
    [haveAttentionTodo release];
    [self.attTempStr release];
    [_tempStr   release];
//    [connectNameMessageView release];
}

@end
