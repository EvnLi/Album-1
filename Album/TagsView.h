//
//  TagsView.h
//  Album
//
//  Created by fhkj on 13-9-12.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@protocol TagsViewDelegate <NSObject>

-(void)addTag:(NSString *)tagName;

-(void)removeTag:(NSString *)tagName;

@end

@interface TagsView : UIView<ASIHTTPRequestDelegate,NSXMLParserDelegate>
{
    NSString *currentElement;
    NSMutableDictionary *tagDic;
    
    UIScrollView *scrollView;
}

@property (nonatomic,retain) NSMutableArray *tagsArray;

@property (nonatomic,assign) id<TagsViewDelegate> delegate;

-(void)clearTags;

@end
