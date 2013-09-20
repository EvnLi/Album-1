//
//  imageModeViewController.h
//  Album
//
//  Created by smq on 13-8-16.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imageModeViewController : UIViewController{
    NSString   *picId;
    NSString   *userId;
    NSString   *picAddress;
    NSString   *picTime;
    NSString   *picFriend;
    NSString   *picUrl;
    NSString   *picTag;
    NSString   *picLove;
    NSString   *picLocation;
    NSString   *picAlbum;
    NSString   *picAlbumMonth;
}
@property (nonatomic,retain) NSString   *picId;
@property (nonatomic,retain) NSString   *userId;
@property (nonatomic,retain) NSString   *picAddress;
@property (nonatomic,retain) NSString    *picTime;
@property (nonatomic,retain) NSString   *picFriend;
@property (nonatomic,retain) NSString   *picUrl;
@property (nonatomic,retain) NSString   *picTag;
@property (nonatomic,retain) NSString   *picLove;
@property (nonatomic,retain) NSString   *picLocation;
@property (nonatomic,retain)NSString   *picAlbum;
@property (nonatomic,retain)NSString   *picAlbumMonth;
-(id)initWithpicId:(NSString*) _picId
	  anduserId:(NSString*) _userId
		 andpicAddress:(NSString*) _picAddress
			 andpicTime:(NSString*) _picTime
                andpicFriend:(NSString*) _picFriend
                   andpicUrl:(NSString*) _picUrl
                      andpicTag:(NSString*) _picTag
                         andpicLove:(NSString*) _picLove
                            andpicLocation:(NSString*) _picLocation
                               andpicAlbum:(NSString*) _picAlbum
andPicAlbumMonth:(NSString*)_picAlbumMonth;

@end
