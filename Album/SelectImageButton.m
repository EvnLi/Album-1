//
//  SelectImageButton.m
//  Album
//
//  Created by fhkj on 13-9-5.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "SelectImageButton.h"

#define kDefaultImage [UIImage imageNamed:@"add_img_pressed"]

@implementation SelectImageButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:kDefaultImage forState:UIControlStateNormal];
    }
    return self;
}

-(BOOL)isSelectedImage
{
    if(![self.imageView.image isEqual:kDefaultImage])
    {
        return YES;
    }
    else
    {
        return NO;
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
