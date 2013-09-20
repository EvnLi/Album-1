//
//  UploadViewController.m
//  Album
//
//  Created by fhkj on 13-8-28.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "UploadViewController.h"
#import "SelectImageButton.h"
#import "MBProgressHUD.h"
#import "UploadPhoto.h"
#import "DialogCreateAblumView.h"
#import "CheckNetWork.h"

#define kNumberOfPicturesPerLine 4
#define kButtonMargin 10
#define kButtonSize CGSizeMake(50,50)

@interface UploadViewController ()
{
    UITextField *addressNameField;
    UITextField *friendsField;
    UITextField *photoTagsField;
    
    TagsView *tagsView;
    
    BOOL ablumIsNotNull;
}

@property (nonatomic,retain) NSMutableArray *imageArray;
@property (nonatomic,retain) UIView *selectButtonsView;
@property (nonatomic,retain) UIView *itemsSubView;
@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic,retain) MBProgressHUD *progressHud;

@property (nonatomic,assign) NSInteger previousImageCount;//继续添加图片之前，已经存在的图片数量
@property (nonatomic,assign) NSInteger imageRowLineCount;//图片行
@property (nonatomic,assign) NSInteger selectDeleteIndex;//删除图片的index索引

@property (nonatomic,retain) ASINetworkQueue *queue;

@property (nonatomic,copy) NSString *photoLocation;

@property (nonatomic,retain) NSMutableArray *selectTags;

@end

@implementation UploadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.imageArray = [[NSMutableArray alloc]init];
        self.selectTags = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    
    [self setupViews];
    
    [self addSelectImageButton];
    
    [self getCurrentLocation];
}

-(void)setupViews
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [_scrollView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_scrollView];
    
    self.selectButtonsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kButtonSize.height + 2 * kButtonMargin)];
    [_scrollView addSubview:_selectButtonsView];
    
    self.itemsSubView = [[UIView alloc] initWithFrame:CGRectMake(0, kButtonSize.height + 2 * kButtonMargin, self.view.bounds.size.width, self.view.bounds.size.height - _selectButtonsView.bounds.size.height)];
    [_scrollView addSubview:_itemsSubView];
    
    UILabel *addressNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 40, 30)];
    [addressNameLabel setText:@"地点:"];
    [addressNameLabel setFont:[UIFont systemFontOfSize:14.0]];
    [addressNameLabel setBackgroundColor:[UIColor clearColor]];
    [_itemsSubView addSubview:addressNameLabel];
    [addressNameLabel release];
    
    addressNameField = [[UITextField alloc]initWithFrame:CGRectMake(65, 10, 150, 30)];
    [addressNameField setBorderStyle:UITextBorderStyleRoundedRect];
    [addressNameField setFont:[UIFont systemFontOfSize:14.0]];
    [addressNameField setPlaceholder:@"请输入地点名称"];
    [addressNameField setKeyboardType:UIKeyboardTypeDefault];
    [addressNameField setDelegate:self];
    [_itemsSubView addSubview:addressNameField];
    
    UILabel *friendsLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 40, 30)];
    [friendsLabel setText:@"朋友:"];
    [friendsLabel setFont:[UIFont systemFontOfSize:14.0]];
    [friendsLabel setBackgroundColor:[UIColor clearColor]];
    [_itemsSubView addSubview:friendsLabel];
    [friendsLabel release];
    
    friendsField = [[UITextField alloc]initWithFrame:CGRectMake(65, 50, 150, 30)];
    [friendsField setBorderStyle:UITextBorderStyleRoundedRect];
    [friendsField setFont:[UIFont systemFontOfSize:14.0]];
    [friendsField setPlaceholder:@"请输入朋友"];
    [friendsField setKeyboardType:UIKeyboardTypeDefault];
    [friendsField setDelegate:self];
    [_itemsSubView addSubview:friendsField];
    
    UILabel *tagsLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 90, 40, 30)];
    [tagsLabel setText:@"标签:"];
    [tagsLabel setFont:[UIFont systemFontOfSize:14.0]];
    [tagsLabel setBackgroundColor:[UIColor clearColor]];
    [_itemsSubView addSubview:tagsLabel];
    [tagsLabel release];
    
    photoTagsField = [[UITextField alloc]initWithFrame:CGRectMake(65, 90, 150, 30)];
    [photoTagsField setBorderStyle:UITextBorderStyleRoundedRect];
    [photoTagsField setFont:[UIFont systemFontOfSize:14.0]];
    [photoTagsField setText:@""];
    [photoTagsField setEnabled:NO];
    [_itemsSubView addSubview:photoTagsField];
    
    tagsView = [[TagsView alloc]initWithFrame:CGRectMake(0, 130, self.view.bounds.size.width, 110)];
    tagsView.delegate = self;
    [_itemsSubView addSubview:tagsView];
    
    UIButton *uploadBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    if ([[UIScreen mainScreen]bounds].size.height == 480) {
        
        [uploadBtn setFrame:CGRectMake(130, 250, 60, 30)];
            }
    else{
        [uploadBtn setFrame:CGRectMake(130, 280, 60, 30)];
    }
    [uploadBtn setTitle:@"上传" forState:UIControlStateNormal];
    [uploadBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    uploadBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [uploadBtn addTarget:self action:@selector(uploadImages:) forControlEvents:UIControlEventTouchUpInside];
    [_itemsSubView addSubview:uploadBtn];
}

#pragma mark -TagsViewDelegate
-(void)addTag:(NSString *)tagName
{
    [_selectTags addObject:tagName];
    
    NSString *tagStr = [NSString string];
    for (int i = 0; i < _selectTags.count; i++) {
        NSString *tag = [_selectTags objectAtIndex:i];
        if(i == 0)
        {
            tagStr = [tagStr stringByAppendingString:tag];
        }
        else
        {
            tagStr = [tagStr stringByAppendingFormat:@",%@",tag];
        }
    }
    
    [photoTagsField setText:tagStr];
}

-(void)removeTag:(NSString *)tagName
{
    [_selectTags removeObject:tagName];
    
    NSString *tagStr = [NSString string];
    for (int i = 0; i < _selectTags.count; i++) {
        NSString *tag = [_selectTags objectAtIndex:i];
        if(i == 0)
        {
            tagStr = [tagStr stringByAppendingString:tag];
        }
        else
        {
            tagStr = [tagStr stringByAppendingFormat:@",%@",tag];
        }
    }
    
    [photoTagsField setText:tagStr];
}

-(void)addSelectImageButton
{
    int addButtonCount = 0;
    if(_imageArray.count == 0)
    {
        self.previousImageCount = 0;
        self.imageRowLineCount = 0;
        addButtonCount = 1;
    }
    else
    {
        addButtonCount = _imageArray.count + 1;
    }
    
    float padding = (self.view.bounds.size.width - 2 * kButtonMargin - kNumberOfPicturesPerLine * kButtonSize.width) / (kNumberOfPicturesPerLine - 1);
    int temp = 0;
    
    for (int i = _previousImageCount; i < addButtonCount; i++) {
        temp = i % kNumberOfPicturesPerLine;
        
        if(i > 0 && i % kNumberOfPicturesPerLine == 0)
        {
            [self addButtonsViewFrame];
            _imageRowLineCount ++;
        }
        SelectImageButton *selectBtn = [SelectImageButton buttonWithType:UIButtonTypeCustom];
        [selectBtn setFrame:CGRectMake(kButtonMargin + temp * (kButtonSize.width + padding), kButtonMargin + _imageRowLineCount * (kButtonSize.height + kButtonMargin), kButtonSize.width, kButtonSize.height)];
        [selectBtn addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
        [selectBtn setTag:i + 1];
        [_selectButtonsView addSubview:selectBtn];
        if(_imageArray.count > 0 && i < addButtonCount - 1)
        {
            UIImage *image = ((UploadPhoto *)[_imageArray objectAtIndex:i]).image;
            [selectBtn setImage:image forState:UIControlStateNormal];
        }
    }
    
    self.previousImageCount = _imageArray.count;
}

//增加图片时，增加高度
-(void)addButtonsViewFrame
{
    float addHeight = kButtonSize.height + kButtonMargin;
    
    [self.selectButtonsView setFrame:CGRectMake(0, 20, _selectButtonsView.bounds.size.width, _selectButtonsView.bounds.size.height + addHeight)];
    
    [self.itemsSubView setCenter:CGPointMake(_itemsSubView.center.x, _itemsSubView.center.y + addHeight)];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + addHeight)];
}

//删除图片时，减少高度
-(void)reduceButtonsViewFrame
{
    float addHeight = kButtonSize.height + kButtonMargin;
    
    [self.selectButtonsView setFrame:CGRectMake(0, 20, _selectButtonsView.bounds.size.width, _selectButtonsView.bounds.size.height - addHeight)];
    
    [self.itemsSubView setCenter:CGPointMake(_itemsSubView.center.x, _itemsSubView.center.y - addHeight)];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - addHeight)];
}

//选择图片
-(void)selectImage:(id)sender
{
    SelectImageButton *selectBtn = sender;
    if(selectBtn.isSelectedImage)
    {
        self.selectDeleteIndex = selectBtn.tag;
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否删除照片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
        [alert release];
    }
    else
    {
        ELCAlbumPickerController *albumController = [[ELCAlbumPickerController alloc] initWithNibName: nil bundle: nil];
        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:albumController];
        [albumController setParent:elcPicker];
        [elcPicker setDelegate:self];
        
        [self presentViewController:elcPicker animated:YES completion:nil];
        
        [elcPicker release];
        [albumController release];
    }
}

#pragma mark -ELCImagePickerControllerDelegate
-(void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMddhhmmss"];
    NSDate *nowDate = [NSDate date];
    
//    for (NSDictionary *imageDic in info) {
    for (int i = 0; i < info.count; i++) {
        NSDate *date = [NSDate dateWithTimeInterval:i sinceDate:nowDate];
        NSDictionary *imageDic = [info objectAtIndex:i];

        UploadPhoto *photos = [[UploadPhoto alloc]init];
        photos.timeStampName = [dateFormatter stringFromDate:date];
        photos.image = [imageDic objectForKey:UIImagePickerControllerOriginalImage];
        
        [_imageArray addObject:photos];
        [photos release];
//        UIImage *selectImage = [imageDic objectForKey:UIImagePickerControllerOriginalImage];
//        [_imageArray addObject:selectImage];
    }
    [dateFormatter release];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self addSelectImageButton];
}

-(void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self refreshView];
    }
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [addressNameField resignFirstResponder];
    [friendsField resignFirstResponder];
    
    return YES;
}

//删除图片时刷新
-(void)refreshView
{
    for (UIView *view in self.selectButtonsView.subviews) {
        if([view isKindOfClass:[SelectImageButton class]])
        {
            [view removeFromSuperview];
        }
    }
    
    self.imageRowLineCount = 0;
    self.previousImageCount = 0;
    [self.imageArray removeObjectAtIndex:_selectDeleteIndex - 1];
    
    if(_imageArray.count % kNumberOfPicturesPerLine == kNumberOfPicturesPerLine - 1)
    {
        [self reduceButtonsViewFrame];
    }
    [self addSelectImageButton];
}

-(BOOL)insertPhotoDiscription
{
    if(_photoLocation == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无法获取位置信息" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        return NO;
    }
    
    for (UploadPhoto *photo in _imageArray) {
        photo.address = addressNameField.text;
        photo.friends = friendsField.text;
        photo.photoTag = photoTagsField.text;
        photo.location = self.photoLocation;
    }
    
    return YES;
}

//获取当前位置
-(void)getCurrentLocation
{
    CLLocationManager *locationManager = [[CLLocationManager alloc]init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 5.0;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}

#pragma mark -CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    self.photoLocation = [NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

#pragma mark -DialogCreateAblumViewDelegate
-(void)newAblumWithName:(NSString *)ablumName createDateString:(NSString *)dateString
{
    for (UploadPhoto *photo in _imageArray) {
        photo.ablumMonth = dateString;
        photo.ablumName = ablumName;
    }
    
    ablumIsNotNull = YES;
}

-(void)uploadImages:(id)sender
{
    if(![CheckNetWork isNetWorkEnable])
    {
        return;
    }
    
    if(!ablumIsNotNull)
    {
        DialogCreateAblumView *dialogView = [[DialogCreateAblumView alloc]initWithFrame:CGRectMake(0, 0, 280, 300)];
        dialogView.delegate = self;
        [dialogView show];
        return;
    }
    
    if([self insertPhotoDiscription])
    {    
        if(_imageArray && _imageArray.count > 0)
        {
            self.progressHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [_progressHud setMode:MBProgressHUDModeCustomView];
            [_progressHud setLabelText:@"正在上传..."];
            
            if(_queue == nil)
            {
                self.queue = [[ASINetworkQueue alloc]init];
            }
            [_queue cancelAllOperations];
            
            [_queue setDelegate:self];
            [_queue setRequestDidFailSelector:@selector(requestDidFailed:)];
            [_queue setRequestDidFinishSelector:@selector(requestDidFinished:)];
            [_queue setQueueDidFinishSelector:@selector(queueDidFinished:)];
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            NSString *userId = [ud objectForKey:@"userIdPath"];
            
            for (int i = 0; i < _imageArray.count; i++) {
                UploadPhoto *photo = [_imageArray objectAtIndex:i];
                
                NSData *imageData = UIImagePNGRepresentation(photo.image);
                ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kURL,@"uploadios"]]];
                
                [request setPostValue:userId forKey:@"userId"];
                [request setPostValue:imageData forKey:@"filecontent"];
                [request setDelegate:self];
                [request setTag:i];
                [_queue addOperation:request];
                [request release];
            }
            
            [_queue go];
        }
    }
}

#pragma mark -ASIHTTPRequestDelegate
-(void)requestDidFailed:(ASIHTTPRequest *)request
{
    [self.progressHud hide:YES];
    
    NSString *errMsg = request.error.description;
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:errMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
    
    [alert release];
}

-(void)requestDidFinished:(ASIHTTPRequest *)request
{
    if(_queue.requestsCount == 0)
    {        
        //添加图片信息
        int uploadCount = 0;
        NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userIdPath"];
        for (UploadPhoto *photo in _imageArray) {
            NSString *urlStr = [NSString stringWithFormat:@"%@photos?method=insert&userId=(int)%@&picAddress=(string)%@&picFriend=(string)%@&picUrl=(string)%@&picTag=(string)%@&picLocation=(string)%@&picAlbumMonth=(string)%@&picAlbum=(string)%@",kURL, userId, photo.address, photo.friends, photo.timeStampName, photo.photoTag, photo.location, photo.ablumMonth, photo.ablumName];
            
            ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
            [request setTimeOutSeconds:50.0];
            [request startSynchronous];
            NSError *error = request.error;
            if(!error)
            {
                uploadCount ++;
            }
        }
        
        if(uploadCount == _imageArray.count)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"上传成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

            [alert release];
            
            [self.progressHud hide:YES];
            
            [self clearContents];//清空界面
        }
    }
}

-(void)queueDidFinished:(ASIHTTPRequest *)request
{
    if(_queue.requestsCount == 0)
    {
        self.queue = nil;
    }
}

-(void)clearContents
{
    [self.imageArray removeAllObjects];
    [self.selectTags removeAllObjects];
    ablumIsNotNull = NO;
    [addressNameField setText:@""];
    [friendsField setText:@""];
    [photoTagsField setText:@""];

    [self refreshView]; //刷新图片选择控件
    [tagsView clearTags]; //清楚tag的选择状态
//    for (UIView *view in _selectButtonsView.subviews) {
//        if([view isKindOfClass:[SelectImageButton class]] && view.tag > 1)
//        {
//            [view removeFromSuperview];
//        }
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [addressNameField release];
    [friendsField release];
    [photoTagsField release];
    
    [_imageArray release];
    [_selectButtonsView release];
    [_itemsSubView release];
    [_scrollView release];
    [_progressHud release];
    [tagsView release];
    
    [_queue release];
    [_photoLocation release];
    [_selectTags release];
    
    [super dealloc];
}

@end
