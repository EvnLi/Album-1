//
//  DisMode.h
//  Album
//
//  Created by smq on 13-8-27.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisMode : NSObject{
    NSString   *disId;
    NSString   *picId;
    NSString   *disName;
    NSString   *disContent;
}
@property (nonatomic,retain) NSString   *disId;
@property (nonatomic,retain) NSString   *picId;
@property (nonatomic,retain) NSString   *disName;
@property (nonatomic,retain) NSString   *disContent;
@end
