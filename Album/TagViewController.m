//
//  TagViewController.m
//  Album
//
//  Created by smq on 13-8-8.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "TagViewController.h"
int  location;
int  judgeLab;
@interface TagViewController ()

@end

@implementation TagViewController
@synthesize tagLab,tagInterstingLab,tagNameStr,tagNameStrArr;
@synthesize tagLeftLab,receivedData,tagModetodo,tagRecommendArr,tagInterestArr,leftTagArr;

//- (id) init{
//    self = [super init];
//    if (self) {
//        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -8);
//        [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:25.f] forKey:UITextAttributeFont] forState:UIControlStateNormal];
//        self.tabBarItem.title = @"标签";
//    }
//    return self;
//}

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
    self.isRecommendTag = NO;
    tagRecommendArr = [[NSMutableArray alloc]init];
    tagModetodo = [[TagMode alloc]init];
    receivedData = [[NSMutableData alloc]init];
    _tempStr      = [[NSMutableString alloc]init];
    tagInterestArr = [[NSMutableArray alloc]init];
    leftTagArr     = [[NSMutableArray alloc]init];
    tagNameArr = [[NSMutableArray alloc]init];

    
    tagNameArrAll = [[NSMutableArray alloc]init];
    [self initRecommendTag];
}
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)initAllTag{
  
    
    
    tagLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 16, 80, 21)];
    [tagLab setFont:[UIFont systemFontOfSize:14]];
    tagLab.text = @"您的标签：";
    tagLab.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:tagLab];
    
    UILabel *tagLabShow = [[UILabel alloc]initWithFrame:CGRectMake(120, 16, 80, 21)];
    [tagLabShow  setFont:[UIFont systemFontOfSize:14]];
//    tagLab.text = @"您的标签：";
    tagLabShow .autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:tagLabShow ];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    tagNameStr = [ud objectForKey:@"tagPath"];
//    tagNameArr = [[NSMutableArray alloc]init];
    tagNameArr = [[tagNameStr componentsSeparatedByString:@","]mutableCopy];
    if ([tagNameStr isEqualToString:@"null"] || [tagNameStr isEqualToString:@""]) {
        
        [tagNameArr removeAllObjects];
        [tagLabShow setText:@"暂无标签"];
    }
    else if([tagNameArr count] > 1){
        
        if ([[tagNameArr objectAtIndex:0]isEqualToString:@"null"] || [[tagNameArr objectAtIndex:0]isEqualToString:@""]) {
            
            [tagNameArr removeObjectAtIndex:0];
        }
    }
    for (int i = 0; i < [tagNameArr count]; i++) {
        NSString *tagNameStrBtn;
        tagNameStrBtn = [tagNameArr objectAtIndex:i];
        if (i % 3 == 0) {
            UIButton *tagBtnStr = [[UIButton alloc]initWithFrame:CGRectMake(30, 38 + (i +1)*10, 80, 20)];
            [tagBtnStr setBackgroundColor:[UIColor blueColor]];
            [tagBtnStr  addTarget:self action:@selector(deleteTagBtn:) forControlEvents:UIControlEventTouchUpInside];
            tagBtnStr.autoresizingMask  = UIViewAutoresizingFlexibleBottomMargin;
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_normal"] forState:UIControlStateNormal];
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_checked"] forState:UIControlStateSelected];
            [tagBtnStr setTitle:tagNameStrBtn forState:UIControlStateNormal];
            [tagBtnStr.titleLabel setFont:[UIFont systemFontOfSize:12]];
            location = 80 + (i +1)*10;
            tagBtnStr.tag = i;
            [self.view addSubview:tagBtnStr];
            [tagBtnStr release];
        }
        else if (i % 3 == 1) {
            UIButton *tagBtnStr = [[UIButton alloc]initWithFrame:CGRectMake(30 + 100, 38 + i*10, 80, 20)];
            [tagBtnStr setBackgroundColor:[UIColor blueColor]];
            [tagBtnStr  addTarget:self action:@selector(deleteTagBtn:) forControlEvents:UIControlEventTouchUpInside];
            tagBtnStr.autoresizingMask  = UIViewAutoresizingFlexibleBottomMargin;
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_normal"] forState:UIControlStateNormal];
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_checked"] forState:UIControlStateSelected];
            [tagBtnStr setTitle:tagNameStrBtn forState:UIControlStateNormal];
            [tagBtnStr.titleLabel setFont:[UIFont systemFontOfSize:12]];
            location = 80 + i*10;
            tagBtnStr.tag = i;
            [self.view addSubview:tagBtnStr];
            [tagBtnStr release];
        }
        else if (i % 3 == 2) {
            UIButton *tagBtnStr = [[UIButton alloc]initWithFrame:CGRectMake(30 + 100 + 100, 38 + (i - 1)*10, 80, 20)];
            [tagBtnStr setBackgroundColor:[UIColor blueColor]];
            [tagBtnStr  addTarget:self action:@selector(deleteTagBtn:) forControlEvents:UIControlEventTouchUpInside];
            tagBtnStr.autoresizingMask  = UIViewAutoresizingFlexibleBottomMargin;
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_normal"] forState:UIControlStateNormal];
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_checked"] forState:UIControlStateSelected];
            [tagBtnStr setTitle:tagNameStrBtn forState:UIControlStateNormal];
            [tagBtnStr.titleLabel setFont:[UIFont systemFontOfSize:12]];
            location = 80 + (i - 1)*10;
            tagBtnStr.tag = i;
            [self.view addSubview:tagBtnStr];
            [tagBtnStr release];
        }
    }
    location = location - 10;
    if ([tagNameArr count] == 0) {
        
        location = 60;
    }
    //系统推荐的标签
    for (int i = 0; i < [tagRecommendArr count]; i++) {
        NSString *str = [NSString stringWithFormat:@"%@",[[tagRecommendArr objectAtIndex:i]tagName]];
        [tagNameArrAll addObject:[str substringToIndex:([str length] - 1)]];
    }
    tagInterstingLab = [[UILabel alloc]initWithFrame:CGRectMake(30, location , 160, 21)];
    [tagInterstingLab setFont:[UIFont systemFontOfSize:14]];
    tagInterstingLab.text = @"系统推荐的标签：";
    tagInterstingLab.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:tagInterstingLab];
    for (int j = 0; j < [tagNameArr count]; j++)
        for (int k = 0; k < [tagNameArrAll count]; k++) {
            NSString *tagNameArrStr = [NSString stringWithFormat:@"%@",[tagNameArr objectAtIndex:j]];
            NSString *tagNameArrAllStr = [NSString stringWithFormat:@"%@",[tagNameArrAll objectAtIndex:k]];
            if ([tagNameArrStr isEqualToString:tagNameArrAllStr] ) {
                [tagNameArrAll removeObjectAtIndex:k];
            }
        }
    
    for (int i = 0; i < 9; i++) {
        [tagInterestArr addObject:[tagNameArrAll objectAtIndex:i]];
    }
    if ([tagNameArrAll count] >= 9) {
        for (int i = 9; i < [tagNameArrAll count]; i++) {
            [leftTagArr addObject:[tagNameArrAll objectAtIndex:i]];
        }
    }

    location = location + 10;
        int location1 = location;
    for (int i = 0; i < [tagInterestArr count]; i++) {
        tagNameStrArr = [tagInterestArr objectAtIndex:i];
        if (i % 3 == 0) {
            UIButton *tagBtnStr = [[UIButton alloc]initWithFrame:CGRectMake(30, location1 + (i +1)*10, 80, 20)];
            [tagBtnStr setBackgroundColor:[UIColor blueColor]];
            [tagBtnStr  addTarget:self action:@selector(addTagBtn:) forControlEvents:UIControlEventTouchUpInside];
            tagBtnStr.autoresizingMask  = UIViewAutoresizingFlexibleBottomMargin;
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_normal"] forState:UIControlStateNormal];
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_checked"] forState:UIControlStateSelected];
            [tagBtnStr setTitle:tagNameStrArr forState:UIControlStateNormal];
            [tagBtnStr.titleLabel setFont:[UIFont systemFontOfSize:12]];
            location = location1 + i*10;
            tagBtnStr.tag = i;
            [self.view addSubview:tagBtnStr];
            [tagBtnStr release];
        }
        else if (i % 3 == 1) {
            UIButton *tagBtnStr = [[UIButton alloc]initWithFrame:CGRectMake(30 + 100, location1 + i*10, 80, 20)];
            [tagBtnStr setBackgroundColor:[UIColor blueColor]];
            [tagBtnStr  addTarget:self action:@selector(addTagBtn:) forControlEvents:UIControlEventTouchUpInside];
            tagBtnStr.autoresizingMask  = UIViewAutoresizingFlexibleBottomMargin;
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_normal"] forState:UIControlStateNormal];
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_checked"] forState:UIControlStateSelected];
            [tagBtnStr setTitle:tagNameStrArr forState:UIControlStateNormal];
            [tagBtnStr.titleLabel setFont:[UIFont systemFontOfSize:12]];
            location = location1 + i*10;
            tagBtnStr.tag = i;
            [self.view addSubview:tagBtnStr];
            [tagBtnStr release];
        }
        else if (i % 3 == 2) {
            UIButton *tagBtnStr = [[UIButton alloc]initWithFrame:CGRectMake(30 + 100 + 100, location1 + (i - 1) *10, 80, 20)];
            [tagBtnStr setBackgroundColor:[UIColor blueColor]];
            [tagBtnStr  addTarget:self action:@selector(addTagBtn:) forControlEvents:UIControlEventTouchUpInside];
            tagBtnStr.autoresizingMask  = UIViewAutoresizingFlexibleBottomMargin;
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_normal"] forState:UIControlStateNormal];
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_checked"] forState:UIControlStateSelected];
            [tagBtnStr setTitle:tagNameStrArr forState:UIControlStateNormal];
            [tagBtnStr.titleLabel setFont:[UIFont systemFontOfSize:12]];
            location = location1 + (i - 1)*10;
            tagBtnStr.tag = i;
            [self.view addSubview:tagBtnStr];
            [tagBtnStr release];
        }
    }
    //系统推荐剩余的标签
        location = location + 30;
    tagLeftLab = [[UILabel alloc]initWithFrame:CGRectMake(30, location , 160, 21)];
    [tagLeftLab setFont:[UIFont systemFontOfSize:14]];
    tagLeftLab.text = @"可选的标签：";
    tagLeftLab.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:tagLeftLab];
    
    location = location + 10;
    for (int i = 0; i < [leftTagArr count]; i++) {
        tagNameStrArr = [leftTagArr objectAtIndex:i];
        if (i % 3 == 0) {
            
            UIButton *tagBtnStr = [[UIButton alloc]initWithFrame:CGRectMake(30, location + (i +1)*10, 80, 20)];
            [tagBtnStr setBackgroundColor:[UIColor blueColor]];
            [tagBtnStr  addTarget:self action:@selector(addLeftTagBtn:) forControlEvents:UIControlEventTouchUpInside];
            tagBtnStr.autoresizingMask  = UIViewAutoresizingFlexibleBottomMargin;
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_normal"] forState:UIControlStateNormal];
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_checked"] forState:UIControlStateSelected];
            [tagBtnStr setTitle:tagNameStrArr forState:UIControlStateNormal];
            [tagBtnStr.titleLabel setFont:[UIFont systemFontOfSize:12]];
            tagBtnStr.tag = i;
            [self.view addSubview:tagBtnStr];
            [tagBtnStr release];
        }
        else if (i % 3 == 1) {
            UIButton *tagBtnStr = [[UIButton alloc]initWithFrame:CGRectMake(30 + 100, location + i*10, 80, 20)];
            [tagBtnStr setBackgroundColor:[UIColor blueColor]];
            [tagBtnStr  addTarget:self action:@selector(addLeftTagBtn:) forControlEvents:UIControlEventTouchUpInside];
            tagBtnStr.autoresizingMask  = UIViewAutoresizingFlexibleBottomMargin;
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_normal"] forState:UIControlStateNormal];
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_checked"] forState:UIControlStateSelected];
            [tagBtnStr setTitle:tagNameStrArr forState:UIControlStateNormal];
            [tagBtnStr.titleLabel setFont:[UIFont systemFontOfSize:12]];
            tagBtnStr.tag = i;
            [self.view addSubview:tagBtnStr];
            [tagBtnStr release];
        }
        else if (i % 3 == 2) {
            UIButton *tagBtnStr = [[UIButton alloc]initWithFrame:CGRectMake(30 + 100 + 100, location + (i - 1) *10, 80, 20)];
            [tagBtnStr setBackgroundColor:[UIColor blueColor]];
            [tagBtnStr  addTarget:self action:@selector(addLeftTagBtn:) forControlEvents:UIControlEventTouchUpInside];
            tagBtnStr.autoresizingMask  = UIViewAutoresizingFlexibleBottomMargin;
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_normal"] forState:UIControlStateNormal];
            [tagBtnStr setBackgroundImage:[UIImage imageNamed:@"bg_tag_checked"] forState:UIControlStateSelected];
            [tagBtnStr setTitle:tagNameStrArr forState:UIControlStateNormal];
            [tagBtnStr.titleLabel setFont:[UIFont systemFontOfSize:12]];
            tagBtnStr.tag = i;
            [self.view addSubview:tagBtnStr];
            [tagBtnStr release];
        }
    }
}

- (void)initRecommendTag{
    
    self.isRecommendTag = YES;
    if (self.isAddTag) {
        self.isAddTag = NO;
    }
    else{
        self.isAddTag = YES;
    }
    NSString *urlString = [[NSString stringWithFormat:@"%@tag?method=select&orderby=tagCount&order=desc",kURL]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlString]];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection release];
}
//网上获得推荐和自选标签
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
    if (self.isRecommendTag) {
    self.isRecommendTag = NO;
	NSXMLParser* parser=[[NSXMLParser alloc]initWithData:receivedData];
	parser.delegate=self;
	[parser parse];
	[parser release];
    }
    else if (self.isAddTag) {
        for (UIView *view in self.view.subviews) {
            [view removeFromSuperview];
        }
        [tagRecommendArr removeAllObjects];
        [tagNameArr      removeAllObjects];
        [tagInterestArr  removeAllObjects];
        [leftTagArr      removeAllObjects];
        [tagNameArrAll   removeAllObjects];
    [self initRecommendTag];
    }
}

#pragma mark NSXMLParser

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //	[self.tableview reloadData];
    [self initAllTag];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"tag"])
	{
		tagModetodo = [[TagMode alloc]init];
	}
    else if ([elementName isEqualToString:@"tagId"])
	{
		[_tempStr setString:@""];
	}
	else if ([elementName isEqualToString:@"tagName"]) {
		[_tempStr setString:@""];
	}
	else if ([elementName isEqualToString:@"tagCount"]) {
		[_tempStr setString:@""];
	}
 	else {
		return;
	}
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"tag"])
    {
       [tagRecommendArr addObject:tagModetodo];
        [tagModetodo release];
    }
    else  if([elementName isEqualToString:@"tagId"])
    {
        tagModetodo.tagId = [NSString stringWithString:_tempStr];
    }
    else if([elementName isEqualToString:@"tagName"])
	{
        tagModetodo.tagName = [NSString stringWithString:_tempStr];
        
	}
    else if([elementName isEqualToString:@"tagCount"])
    {
        tagModetodo.tagCount = [NSString stringWithString:_tempStr];
        
    }
    //图片下载
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [_tempStr appendString:string];
}

- (void)deleteTagBtn:(id)sender{
    
    judgeLab = [(UIButton*)sender tag];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"移除标签" message:@"是否移除标签" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 0;
    [alert show]; 
    [alert release];
}

- (void)addTagBtn:(id)sender{
    judgeLab = [(UIButton*)sender tag];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"增添标签" message:@"是否增添标签" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 1;
    [alert show];
    [alert release];
}

- (void)addLeftTagBtn:(id)sender{
    judgeLab = [(UIButton*)sender tag];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"增添标签" message:@"是否增添标签" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 2;
    [alert show];
    [alert release];
    
}
#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *tagNmaeArrBtn = [[NSMutableArray alloc]init];
     tagNmaeArrBtn =[[tagNameStr componentsSeparatedByString:@","] mutableCopy];
    if (buttonIndex == 0) {
        if (alertView.tag == 0) {
            
            if ([tagNmaeArrBtn count] == 2) {
                
                if ([[tagNmaeArrBtn objectAtIndex:0]isEqualToString:@""]) {
                    
                    [tagNmaeArrBtn removeObjectAtIndex:1];
                }
            }
            else{
                 [tagNmaeArrBtn removeObjectAtIndex:judgeLab];
            }
        }
        else if (alertView.tag == 1)
        {
            [tagNmaeArrBtn addObject:[tagInterestArr objectAtIndex:judgeLab]];
        }
        else if (alertView.tag == 2){
            [tagNmaeArrBtn addObject:[leftTagArr objectAtIndex:judgeLab]];
        }
    NSString *tagNmaeArrBtnStr = [[NSString alloc]init];
    if ([tagNmaeArrBtn count]) {
  
      tagNmaeArrBtnStr = [[NSMutableString alloc]initWithFormat:@"%@",[tagNmaeArrBtn objectAtIndex:0]];
    }
        for (int i = 0; i < [tagNmaeArrBtn count]; i++) {
            NSLog(@"objectAtIndex:i:%@",[tagNmaeArrBtn objectAtIndex:i]);
        }

    for (int i = 1; i < [tagNmaeArrBtn count]; i++) {
        tagNmaeArrBtnStr = [tagNmaeArrBtnStr stringByAppendingFormat:@",%@",[tagNmaeArrBtn objectAtIndex:i]];
    }
    [ud setObject:tagNmaeArrBtnStr forKey:@"tagPath"];

        self.isAddTag = YES;
    NSString *str = [[NSString stringWithFormat: @"%@pusers?method=update&whereuserId=(int)%d&userTag=(string)%@",kURL, [[ud objectForKey:@"userIdPath"]intValue],tagNmaeArrBtnStr ] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: str]];
        NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection release];

    }
}

- (BOOL)shouldAutorotate{
    return NO;
}
//- (NSUInteger)supportedInterfaceOrientations{
//    return ;
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [super dealloc];
//    [navBar  release];
    [tagLab release];
    [tagInterstingLab release];
    [tagInterstingLab release];
    [tagNameArrAll release];
    [tagNameArr release];
    [_tempStr   release];
    [receivedData release];
    [tagModetodo  release];
    [tagRecommendArr release];
    [tagInterestArr  release];
    [leftTagArr      release];
}

@end
