//
//  TagMode.h
//  Album
//
//  Created by smq on 13-8-28.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagMode : NSObject{
    NSString   *tagId;
    NSString   *tagName;
    NSString   *tagCount;
}

@property (nonatomic,retain) NSString   *tagId;
@property (nonatomic,retain) NSString   *tagName;
@property (nonatomic,retain)  NSString   *tagCount;
@end
