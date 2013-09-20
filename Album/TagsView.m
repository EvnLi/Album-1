//
//  TagsView.m
//  Album
//
//  Created by fhkj on 13-9-12.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "TagsView.h"

#define kTagButtonSize CGSizeMake(60,25)
#define kMagin 10
#define kNumberPerLine 4

@implementation TagsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        [self setupViews];
        scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        [self addSubview:scrollView];
        [self loadData];
    }
    return self;
}

-(void)loadData
{
    ASIHTTPRequest *httpRequest = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@tag?method=select",kURL]]];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];

    [httpRequest release];
}

#pragma mark -ASIHTTPRequestDelegate
-(void)requestFailed:(ASIHTTPRequest *)request
{

}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc]initWithData:responseData];
    [xmlParser setDelegate:self];
    [xmlParser parse];
    
    [xmlParser release];
    
    [self setupViews];
}

#pragma mark -NSXMLParserDelegate
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.tagsArray = [[NSMutableArray alloc]init];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    currentElement = elementName;
    if([currentElement isEqualToString:@"tag"])
    {
        tagDic = [[NSMutableDictionary alloc]init];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"tag"])
    {
        [_tagsArray addObject:tagDic];
        [tagDic release];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if([currentElement isEqualToString:@"tagId"])
    {
        [tagDic setObject:string forKey:@"tagId"];
    }
    else if([currentElement isEqualToString:@"tagName"])
    {
        if([tagDic objectForKey:@"tagName"])
        {
            NSRange range = [string rangeOfString:@"\n"];
            string = [string substringWithRange:NSMakeRange(0, string.length - range.length)];
            
            NSString *str = [tagDic objectForKey:@"tagName"];
            [tagDic setObject:[str stringByAppendingString:string] forKey:@"tagName"];
        }
        else
        {
            [tagDic setObject:string forKey:@"tagName"];
        }
    }
    else if([currentElement isEqualToString:@"tagCount"])
    {
        if([tagDic objectForKey:@"tagCount"])
        {
            NSRange range = [string rangeOfString:@"\n"];
            string = [string substringWithRange:NSMakeRange(0, string.length - range.length)];
            
            NSString *str = [tagDic objectForKey:@"tagCount"];
            [tagDic setObject:[str stringByAppendingString:string] forKey:@"tagCount"];
        }
        else
        {
            [tagDic setObject:string forKey:@"tagCount"];
        }
    }
}

-(void)setupViews
{    
    if(_tagsArray)
    {
        float padding = (self.bounds.size.width - 2 * kMagin - kNumberPerLine * kTagButtonSize.width) / (kNumberPerLine - 1);
        int lines = 0;
        
        int temp = 0;
        float contentHeight = 0;
        
        for (int i = 0; i < _tagsArray.count; i++) {
            temp = i % kNumberPerLine;
            
            if(i > 0 && i % kNumberPerLine == 0)
            {
                lines++;
            }
            
            NSDictionary *dic = [_tagsArray objectAtIndex:i];
//            NSString *tagName = [dic objectForKey:@"tagName"];
//            NSRange range = [tagName rangeOfString:@"\n"];
//            tagName = [tagName substringWithRange:NSMakeRange(0, tagName.length - range.length)];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(kMagin + temp * (kTagButtonSize.width + padding), kMagin + lines * (kTagButtonSize.height + padding), kTagButtonSize.width, kTagButtonSize.height)];
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_tag_normal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_tag_checked"] forState:UIControlStateSelected];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//            [btn setTitle:tagName forState:UIControlStateNormal];
            [btn setTitle:[dic objectForKey:@"tagName"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(addOrRemoveTag:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:btn];
            
            contentHeight = btn.frame.origin.y + kTagButtonSize.height + kMagin;
        }
        [scrollView setContentSize:CGSizeMake(self.bounds.size.width, contentHeight)];
    }
}

-(void)addOrRemoveTag:(id)sender
{
    UIButton *btn = sender;
    if(btn.isSelected)
    {
        [self.delegate removeTag:btn.titleLabel.text];
        [btn setSelected:NO];
    }
    else
    {
        [self.delegate addTag:btn.titleLabel.text];
        [btn setSelected:YES];
    }
}

-(void)clearTags
{
    for (UIView *view in scrollView.subviews) {
        if([view isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)view;
            [btn setSelected:NO];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
