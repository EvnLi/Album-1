//
//  TheaterModeViewController.h
//  Album
//
//  Created by smq on 13-8-22.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imageModeViewController.h"
#import <QuartzCore/QuartzCore.h>

typedef enum
{
    Floating = 1,//飘纸片
    WeatherBalloon = 2,//气球
    ShineStar = 3,//光芒
    Drift = 4,//漂移
    AddText = 5 //添加文字
}AnimationEffects; //动画特效


@interface TheaterModeViewController : UIViewController<UIScrollViewDelegate>{
    NSMutableArray   *picShowArr;
    NSMutableArray   *recievepicShowArr;
    UINavigationBar  *navBar;
    UIScrollView     *sView;
}
@property (nonatomic,retain) NSMutableArray   *picShowArr;
@property (nonatomic,retain) NSMutableArray   *recievepicShowArr;
@property (nonatomic,retain) UINavigationBar  *navBar;
@end
