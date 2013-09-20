//
//  ConnectSearchMode.h
//  Album
//
//  Created by smq on 13-8-16.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectSearchMode : NSObject{
    NSString     *userNameSearch;
    NSString     *userTagSearch;
    NSString     *userPicSearch;
    NSString     *userNickNameSearch;
    //关注Id
    NSString     *userIdSearch;
}
@property (nonatomic,retain) NSString     *userNameSearch;
@property (nonatomic,retain) NSString     *userTagSearch;
@property (nonatomic,retain) NSString     *userPicSearch;
@property (nonatomic,retain) NSString     *userIdSearch;
@property (nonatomic,retain) NSString     *userNickNameSearch;
@property (nonatomic, assign) BOOL isAttd; 
/*
-(id)initWithuserNameSearch:(NSString*) _userNameSearch
         anduserTagSearch:(NSString*) _userTagSearch
     anduserPicSearch:(NSString*) _userPicSearch;

*/
@end
