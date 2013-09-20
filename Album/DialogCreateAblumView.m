//
//  DialogCreateAblumView.m
//  Album
//
//  Created by fhkj on 13-9-10.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "DialogCreateAblumView.h"

@interface DialogCreateAblumView ()

@property (nonatomic,copy) NSString *selectDateString;

@end

@implementation DialogCreateAblumView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setAlpha:0];
        self.transform = CGAffineTransformMakeScale(1.4, 1.4);
        
        [self setupViews];
    }
    return self;
}

-(void)setupViews
{
    [self createOverlayView];
    
    UILabel *ablumNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 70, 30)];
    [ablumNameLabel setBackgroundColor:[UIColor clearColor]];
    [ablumNameLabel setFont:[UIFont systemFontOfSize:14.0]];
    [ablumNameLabel setText:@"相册名称:"];
    [self addSubview:ablumNameLabel];
    [ablumNameLabel release];
    
    ablumNameField = [[UITextField alloc]initWithFrame:CGRectMake(100, 20, 150, 30)];
    [ablumNameField setBorderStyle:UITextBorderStyleRoundedRect];
    [ablumNameField setFont:[UIFont systemFontOfSize:14.0]];
    [ablumNameField setPlaceholder:@"请输入相册名称"];
    [ablumNameField setDelegate:self];
    [self addSubview:ablumNameField];
    
    NSDateFormatter *dateFormatter=  [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSInteger year = [[dateFormatter stringFromDate:[NSDate date]] integerValue];
    [dateFormatter release];
    
    monthPicker = [[SRMonthPicker alloc]initWithFrame:CGRectMake(20, 80, self.bounds.size.width - 2 * 20, 80)];
    monthPicker.monthPickerDelegate = self;
    monthPicker.maximumYear = [NSNumber numberWithInt:year];
    monthPicker.minimumYear = [NSNumber numberWithInt:1990];
    monthPicker.yearFirst = YES;
    [self addSubview:monthPicker];
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [okBtn setFrame:CGRectMake(40, self.bounds.size.height - 40, 50, 30)];
    [okBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(okBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:okBtn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelBtn setFrame:CGRectMake(self.bounds.size.width - 40 - 50, self.bounds.size.height - 40, 50, 30)];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [ablumNameField resignFirstResponder];
    return YES;
}

#pragma mark -SRMonthPickerDelegate
-(void)monthPickerWillChangeDate:(SRMonthPicker *)monthPicker
{}

-(void)monthPickerDidChangeDate:(SRMonthPicker *)picker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSDate *date = picker.date;
    self.selectDateString = [dateFormatter stringFromDate:date];
    
    [dateFormatter release];
}

-(void)createOverlayView
{
    overlayView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [overlayView setAlpha:0.5];
    [overlayView setBackgroundColor:[UIColor blackColor]];
}

-(void)okBtnClicked:(id)sender
{
    if(!_selectDateString)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSDate *date = [NSDate date];
        self.selectDateString = [dateFormatter stringFromDate:date];
        
        [dateFormatter release];
    }
    [self.delegate newAblumWithName:ablumNameField.text createDateString:_selectDateString];
    [self fadeOut];
}

-(void)cancelBtnClicked:(id)sender
{
    [self fadeOut];
}

-(void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:overlayView];
    [keyWindow addSubview:self];
    
    [self setCenter:CGPointMake(keyWindow.bounds.size.width / 2, keyWindow.bounds.size.height / 2)];
    [self fadeIn];
}

-(void)fadeIn
{
    [UIView animateWithDuration:1.0 animations:^
     {
         [self setAlpha:1.0];
         self.transform = CGAffineTransformMakeScale(1.0, 1.0);
     }completion:nil];
}

-(void)fadeOut
{
    [UIView animateWithDuration:1.0 animations:^
     {
         [self setAlpha:0];
         self.transform = CGAffineTransformMakeScale(1.4, 1.4);
     }completion:^(BOOL isFinished)
     {
         if(isFinished)
         {
             [overlayView removeFromSuperview];
             [self removeFromSuperview];
         }
     }];
}

-(void)dealloc
{
    [monthPicker release];
    [ablumNameField release];
    [overlayView release];
    
    [super dealloc];
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
