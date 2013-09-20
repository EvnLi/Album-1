//
//  UploadPhoto.h
//  Album
//
//  Created by fhkj on 13-9-10.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadPhoto : NSObject

@property (nonatomic,copy) UIImage *image;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *friends;
@property (nonatomic,copy) NSString *timeStampName;
@property (nonatomic,copy) NSString *photoTag;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,copy) NSString *ablumMonth;
@property (nonatomic,copy) NSString *ablumName;

@end
