//
//  CustomTableViewCell.m
//  Album
//
//  Created by fhkj on 13-8-30.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setTitleStr:(NSString *)titleStr
{
    if(![_titleStr isEqualToString:titleStr])
    {
        [_titleStr release];
        _titleStr = [titleStr copy];
        titleLabel.text = _titleStr;
    }
}

//-(void)setPingStr:(NSString *)pingStr
//{
//    if(![_pingStr isEqualToString:pingStr])
//    {
//        [_pingStr release];
//        _pingStr = [pingStr copy];
//        pingTextView.text = _pingStr;
//    }
//}

-(void)setTagStr:(NSString *)tagStr
{
    if(![_tagStr isEqualToString:tagStr])
    {
        [_tagStr release];
        _tagStr = [tagStr copy];
        tagLabel.text = _tagStr;
    }
}
-(void)setTagInputStr:(NSString *)tagInputStr
{
    if(![_tagInputStr isEqualToString:tagInputStr])
    {
        [_tagInputStr release];
        _tagInputStr = [tagInputStr copy];
        tagInputLabel.text = _tagInputStr;
    }
}
-(void)setLoveStr:(NSString *)loveStr
{
    if(![_loveStr isEqualToString:loveStr])
    {
        [_loveStr release];
        _loveStr = [loveStr copy];
        loveLabel.text = _loveStr;
    }
}
-(void)setLoveInputStr:(NSString *)loveInputStr
{
    if(![_titleStr isEqualToString:loveInputStr])
    {
        [_loveInputStr release];
        _loveInputStr = [loveInputStr copy];
        loveInputLabel.text = _loveInputStr;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
//    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
//    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboad)];
//    NSArray *itemArray = [NSArray arrayWithObjects:doneBtn, nil];
//    [toolBar setItems:itemArray];
//    [pingTextView setInputAccessoryView:toolBar];
//    [toolBar release];
//    [doneBtn release];
//    return YES;
//}
//
//- (void)dismissKeyboad{
//    [pingTextView resignFirstResponder];
//}

@end
