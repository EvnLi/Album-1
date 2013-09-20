//
//  DialogCreateAblumView.h
//  Album
//
//  Created by fhkj on 13-9-10.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRMonthPicker.h"

@protocol DialogCreateAblumViewDelegate <NSObject>

-(void)newAblumWithName:(NSString *)ablumName createDateString:(NSString *)dateString;

@end

@interface DialogCreateAblumView : UIView<UITextFieldDelegate,SRMonthPickerDelegate>
{
    SRMonthPicker *monthPicker;
    UITextField *ablumNameField;
    
    UIView *overlayView;
}

@property (nonatomic,assign) id<DialogCreateAblumViewDelegate> delegate;

-(void)show;

@end
