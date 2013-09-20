//
//  TheaterModeViewController.m
//  Album
//
//  Created by smq on 13-8-22.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "TheaterModeViewController.h"

@interface TheaterModeViewController ()

@end

@implementation TheaterModeViewController
@synthesize picShowArr,recievepicShowArr,navBar;
//- (id) init{
//    self = [super init];
//    if (self) {
//        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -8);
//        [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:25.f] forKey:UITextAttributeFont] forState:UIControlStateNormal];
//        self.tabBarItem.title = @"剧场";
//    }
//    return self;
//}


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

    recievepicShowArr = [[NSMutableArray alloc]init];
    recievepicShowArr = picShowArr;
    
    navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UINavigationItem *navItem = [[UINavigationItem alloc]initWithTitle:@"剧场"];
    UIBarButtonItem  *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnBack:)];
    [navItem setLeftBarButtonItem:leftBtn];
    [navBar pushNavigationItem:navItem animated:NO];
    navBar.hidden = NO;
    [navBar setTintColor:[UIColor redColor]];
    [self.view addSubview:navBar];
    [navItem release];
    [navBar release];
    
    sView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, 320, self.view.frame.size.height)];
    sView.backgroundColor = [UIColor blueColor];
    sView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    sView.showsHorizontalScrollIndicator = NO;
    sView.pagingEnabled = YES;
    sView.userInteractionEnabled = YES;
    sView.delegate = self;
    int count = [recievepicShowArr count];
    sView.contentSize = CGSizeMake(count*320 ,self.view.frame.size.height);
    
    for (int i=0; i<count; i++) {
        imageModeViewController *newImageTodo = nil;
        newImageTodo = [recievepicShowArr objectAtIndex:i];
        NSString *urlImg = [NSString stringWithFormat:@"%@",[newImageTodo picUrl]];
        NSURL   *url = [[NSURL alloc]initWithString:urlImg];
        NSData  *dateImg = [[NSData alloc]initWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:dateImg];
        UIImageView *iView = [[UIImageView alloc]initWithImage:image];
        iView.userInteractionEnabled = YES;
        iView.frame = CGRectMake(i*320 , 0, 320,self.view.frame.size.height);
        iView.tag = i;
//        [sView addSubview:iView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [iView addGestureRecognizer:tap];
        [tap release];
//        [iView release];
  
        //动画效果
        if (i % 2 == 0) {
        UIImageView *imageView;
            int effectCount = arc4random()%6;
       imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiaolian.png"]];
       imageView.frame = CGRectMake(effectCount * 10, 10, 40, 40);
//        [iView addSubview:imageView];
    
//        UIBezierPath *movePath = [UIBezierPath bezierPath];
//        [movePath moveToPoint:CGPointMake(20, 20)];
//        CGPoint toPoint = CGPointMake(200, 400);
//        [movePath addQuadCurveToPoint:toPoint
//                         controlPoint:CGPointMake(300,0)];
//        
//        CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//        moveAnim.path = movePath.CGPath;
//        moveAnim.removedOnCompletion = YES;
//        moveAnim.duration = 3;
//        [imageView.layer addAnimation:moveAnim forKey:nil];
            
            [UIView animateWithDuration:4.0 animations:^{
                [imageView setCenter:CGPointMake(200,  600)];
            }
                             completion:^(BOOL finished){
                                 if(finished)
                                 {
                                     if(imageView.center.y > 500)
                                     {
                                         [imageView removeFromSuperview];
                                     }
                                 }
                             }];
            
            [iView addSubview:imageView];
        }
//        else if (i % 2 == 1){
//            UIImageView *imageView1;
//            imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiaolian.png"]];
//            imageView1.frame = CGRectMake(10, 10, 40, 40);
//            
//            
//            UIBezierPath *movePath1 = [UIBezierPath bezierPath];
//            [movePath1 moveToPoint:CGPointMake(20, 20)];
//            CGPoint toPoint1 = CGPointMake(200, 400);
//            [movePath1 addQuadCurveToPoint:toPoint1
//                             controlPoint:CGPointMake(300,0)];
//            CAKeyframeAnimation *moveAnim1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//            moveAnim1.path = movePath1.CGPath;
//            moveAnim1.removedOnCompletion = YES;
//            moveAnim1.duration = 3;
//            [imageView1.layer addAnimation:moveAnim1 forKey:nil];
//                    [iView addSubview:imageView1];
//        }
     [sView addSubview:iView];
    [iView release];
    [self.view addSubview:sView];
    }
//    }
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)getAnimationEffectsWithEffectsId:(AnimationEffects)effects
{
    switch (effects) {
        case Floating:
            [self getFloating];
            break;
        case WeatherBalloon:
            [self getWeatherBalloon];
            break;
        case ShineStar:
            [self getShineStar];
            break;
        case Drift:
            [self getDrift];
            break;
        case AddText:
            [self getAddText];
            break;
        default:
//            NSAssert(NO, @"找不到特效");
            break;
    }
}

//飘纸片
-(void)getFloating
{
    
}

//气球
-(void)getWeatherBalloon
{
    UIImage *balloonImage = [UIImage imageNamed:@"ball"];
    UIImageView *balloonView = [[UIImageView alloc]initWithImage:balloonImage];
    [balloonView.layer setMasksToBounds:YES];
    
    int random_x = arc4random() % (int)self.view.bounds.size.width;
    if (random_x > self.view.bounds.size.width - balloonView.bounds.size.width) {
        random_x = self.view.bounds.size.width - balloonView.bounds.size.width;
    }
    
    [balloonView setFrame:CGRectMake(random_x, self.view.bounds.size.height, balloonView.bounds.size.width, balloonView.bounds.size.height)];
    [self.view addSubview:balloonView];
    [balloonView release];
    
    [UIView animateWithDuration:2.0 animations:^{
        [balloonView setCenter:CGPointMake(random_x, -balloonView.bounds.size.height)];
    }
                     completion:^(BOOL finished){
                         if(finished)
                         {
                             if(balloonView.center.y < 0)
                             {
                                 [balloonView removeFromSuperview];
                             }
                         }
                     }];
}

//光芒
-(void)getShineStar
{
    UIImage *image = [UIImage imageNamed:@"shine"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [imageView setAlpha:0];
    [self.view addSubview:imageView];
    [imageView release];
    
    int random_x = arc4random() % (int)self.view.bounds.size.width;
    int random_y = arc4random() % (int)self.view.bounds.size.height;
    if (random_x > self.view.bounds.size.width - imageView.bounds.size.width) {
        random_x = self.view.bounds.size.width - imageView.bounds.size.width;
    }
    if (random_y > self.view.bounds.size.height - imageView.bounds.size.height) {
        random_y = self.view.bounds.size.height - imageView.bounds.size.height;
    }
    [imageView setFrame:CGRectMake(random_x, random_y, imageView.bounds.size.width, imageView.bounds.size.height)];
    
    [UIView animateWithDuration:1.0 animations:^{
        [imageView setAlpha:1.0];
    } completion:^(BOOL finished)
     {
         if(finished)
         {
             [imageView removeFromSuperview];
         }
     }];
}

//漂移
-(void)getDrift
{
    UIGraphicsBeginImageContext(CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height));
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    self.view.layer.contents = nil;
    UIImage *currentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:currentImage];
    [self.view addSubview:imageView];
    [imageView release];
    
    int fromDirection = arc4random() % 4 + 1;
    switch (fromDirection) {
        case 1:
            //top
            [imageView setCenter:CGPointMake(imageView.bounds.size.width / 2, -imageView.bounds.size.height / 2)];
            break;
        case 2:
            //right
            [imageView setCenter:CGPointMake(imageView.bounds.size.width / 2 * 3, imageView.bounds.size.height / 2)];
            break;
        case 3:
            //bottom
            [imageView setCenter:CGPointMake(imageView.bounds.size.width / 2, imageView.bounds.size.height / 2 * 3)];
            break;
        case 4:
            //left
            [imageView setCenter:CGPointMake(-imageView.bounds.size.width / 2, imageView.bounds.size.height / 2)];
            break;
        default:
            NSAssert(NO, @"随机数不在正确的方向上");
            break;
    }
    [UIView animateWithDuration:4.0 animations:^{
        [imageView setCenter:CGPointMake(imageView.bounds.size.width / 2, imageView.bounds.size.height / 2)];
    } completion:^(BOOL finished)
     {
         if(finished)
         {
             [imageView removeFromSuperview];
         }
     }];
}

//添加文字
-(void)getAddText
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 100, self.view.bounds.size.height - 50, 100, 50)];
    [label setText:@"百年好合"];
    [label setTextColor:[UIColor redColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setAlpha:0.0];
    label.transform = CGAffineTransformMakeScale(1.5, 1.5);
    [self.view addSubview:label];
    [label release];
    
    [UIView animateWithDuration:2.0 animations:^{
        [label setAlpha:1.0];
        label.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished)
     {
         if(finished)
         {
             [label removeFromSuperview];
         }
     }];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int effectsId = arc4random() % 5 + 1;
    [self getAnimationEffectsWithEffectsId:effectsId];
    
    
//    [self.view viewWithTag:fabs(scrollView.contentOffset.x)/scrollView.frame.size.width];
//    CGPoint point = scrollView.contentOffset;
    int i = arc4random() % 5;
    //    for (int i = 0; i < 10; i++) {
    if (i % 2 == 0){
        UIImageView *imageView1;
        imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiaolian.png"]];
        imageView1.frame = CGRectMake(effectsId * 10, 50, 40, 40);
        
        [UIView animateWithDuration:4.0 animations:^{
            [imageView1 setCenter:CGPointMake(200,  600)];
        }
                         completion:^(BOOL finished){
                             if(finished)
                             {
                                 if(imageView1.center.y > 500)
                                 {
                                     [imageView1 removeFromSuperview];
                                 }
                             }
                         }];
        [self.view addSubview:imageView1];
        
    }
    
    else if (i % 2 == 1){
        UIImageView *imageView2;
        imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xingxing.png"]];
        imageView2.frame = CGRectMake(effectsId * 30, 50, 40, 40);
        [UIView animateWithDuration:4.0 animations:^{
            [imageView2 setCenter:CGPointMake(200,  600)];
        }
                         completion:^(BOOL finished){
                             if(finished)
                             {
                                 if(imageView2.center.y > 500)
                                 {
                                     [imageView2 removeFromSuperview];
                                 }
                             }
                         }];
        [self.view  addSubview:imageView2];
        
    }
//    else if (i % 3 == 2){
//        UIImageView *imageView2;
//        imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xingxing.png"]];
//        imageView2.frame = CGRectMake(10, 50, 40, 40);
//        
//        
//        UIBezierPath *movePath2 = [UIBezierPath bezierPath];
//        [movePath2 moveToPoint:CGPointMake(20, 90)];
//        CGPoint toPoint2 = CGPointMake(150, 400);
//        [movePath2 addQuadCurveToPoint:toPoint2
//                          controlPoint:CGPointMake(300,0)];
//        
//        CAKeyframeAnimation *moveAnim2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//        moveAnim2.path = movePath2.CGPath;
//        moveAnim2.removedOnCompletion = YES;
//        moveAnim2.duration = 3;
//        [imageView2.layer addAnimation:moveAnim2 forKey:nil];
//        [self.view  addSubview:imageView2];
//        
//    }
    

}

- (void)click:(id)sender{
 
}
- (void)returnBack:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [super dealloc];
    [picShowArr release];
    [recievepicShowArr release];
}

@end
