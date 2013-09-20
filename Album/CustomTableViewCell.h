//
//  CustomTableViewCell.h
//  Album
//
//  Created by fhkj on 13-8-30.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell: UITableViewCell<UITextViewDelegate>
{
    IBOutlet UILabel *tagLabel;
    IBOutlet UILabel *tagInputLabel;
    IBOutlet UILabel *titleLabel;
//    IBOutlet UITextView *pingTextView;
    IBOutlet UILabel *loveLabel;
    IBOutlet UILabel *loveInputLabel;
}

//@property (nonatomic,retain) UITextView *pingTextView;
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) NSString *pingStr;
@property (nonatomic,copy) NSString *tagStr;
@property (nonatomic,copy) NSString *tagInputStr;
@property (nonatomic,copy) NSString *loveStr;
@property (nonatomic,copy) NSString *loveInputStr;

@end
