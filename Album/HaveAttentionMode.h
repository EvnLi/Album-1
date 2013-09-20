//
//  HaveAttentionMode.h
//  Album
//
//  Created by smq on 13-9-3.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HaveAttentionMode : NSObject {
    NSString *attId;
    NSString *isattuserId;
    NSString *attuserId;
}

@property (nonatomic,retain) NSString *attId;
@property (nonatomic,retain) NSString *isattuserId;
@property (nonatomic,retain) NSString *attuserId;
@end
