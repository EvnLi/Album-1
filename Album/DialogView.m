//
//  DialogView.m
//  testdialog
//
//  Created by smq on 13-9-11.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "DialogView.h"
#import <QuartzCore/QuartzCore.h>
@implementation DialogView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor whiteColor]]; //设置视图背景颜色
        self.layer.cornerRadius = 10;    //设置弹出框为圆角视图
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 2;   //设置弹出框视图边框宽度
        self.layer.borderColor = [[UIColor colorWithRed:0.50 green:0.10 blue:0.10 alpha:0.5] CGColor];   //设置弹出框边框颜色
        

          }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


@end
