//
//  imageModeViewController.m
//  Album
//
//  Created by smq on 13-8-16.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "imageModeViewController.h"

@interface imageModeViewController ()

@end

@implementation imageModeViewController
@synthesize picId,userId,picAddress,picTime,picFriend,picUrl,picTag,picLocation,picLove,picAlbum,picAlbumMonth;

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
     andPicAlbumMonth:(NSString*)_picAlbumMonth{
    if(_picId == nil || _userId == nil || _picAddress == nil || _picTime == nil || _picFriend == nil || _picUrl || _picTag == nil || _picTag || _picLove == nil || _picLocation == nil || _picAlbum == nil || _picAlbumMonth == nil)
	{
		[super release];
		return nil;
	}
	if(!(self = [super init]))
	{
		return nil;
	}
	self.picId = _picId;
	self.userId = _userId;
	self.picAddress = _picAddress;
	self.picTime = _picTime;
    self.picFriend = _picFriend;
    self.picUrl    = _picUrl;
    self.picTag    = _picTag;
    self.picLove   = _picLove;
    self.picLocation = _picLocation;
    self.picAlbum = _picAlbum;
    self.picAlbumMonth = _picAlbumMonth;
	return self;
}
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [super dealloc];
    [picId release];
    [userId release];
    [picAddress release];
    [picTime release];
    [picFriend release];
    [picUrl release];
    [picTag release];
    [picLocation release];
    [picLove release];
    [picAlbum release];
}
@end
