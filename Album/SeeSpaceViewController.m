//
//  SeeSpaceViewController.m
//  Album
//
//  Created by smq on 13-8-30.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "SeeSpaceViewController.h"

@interface SeeSpaceViewController ()

@end

@implementation SeeSpaceViewController
@synthesize seePicArr,navBar,attUserNickName;
@synthesize tableView,keystableView;

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
    [super viewDidLoad];
    self.keystableView = [[NSMutableArray alloc]init];
    self.receivedPicDic = [[NSMutableDictionary alloc]init];
    self.receivedNickName = [[NSString alloc]init];
    navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    navItem = [[UINavigationItem alloc]init];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnBack:)];
    [navItem setLeftBarButtonItem:leftBtn];
    [navBar pushNavigationItem:navItem animated:YES];
    [navBar setTintColor:[UIColor redColor]];
    [self.view addSubview:navBar];
    [leftBtn release];
    [navItem release];
    [navBar release];
    
    self.receivedPicArr = [[NSArray alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, [UIScreen mainScreen].bounds.size.height - 44 - 20)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor grayColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //    self.receivedPicArr = self.seePicArr;
    self.receivedPicDic = self.picDic;
    [self.keystableView removeAllObjects];
    self.keystableView = [[self.receivedPicDic allKeys]mutableCopy];
    self.receivedNickName = self.attUserNickName;
    [navItem setTitle:self.receivedNickName];
    [tableView reloadData];
}


//UItableView 表格显示begin
#pragma mark UITableViewDataSource,UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdetify = @"cellIdentify";
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:reuseIdetify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdetify] autorelease];
    }
    
    NSArray *allPicArr = nil;
    allPicArr = [self.picDic objectForKey:[keystableView objectAtIndex:indexPath.row]];
    UIView *imagesBack = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 220, 150)];
    imagesBack.backgroundColor = [UIColor whiteColor];
    int counts;
    if ([allPicArr count] > 6) {
        counts = 6;
    }
    else{
        counts = [allPicArr count];
    }
    if (counts == 1) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            imageModeViewController *newImageTodo = nil;
            newImageTodo = [allPicArr objectAtIndex:0];
            NSString* picUrlStr =  [newImageTodo picUrl];
            NSURL  *imageUrl = [NSURL URLWithString:picUrlStr];
            NSData *imageDate = [[NSData alloc]initWithContentsOfURL:imageUrl];
            UIImage * imageCon = [UIImage imageWithData:imageDate];
            UIImageView *imageView;
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20 , 20, 130, 100)];
            //图片排列
            imageView.userInteractionEnabled = YES;
            imageView.tag = indexPath.row;
            [imageView setImage:imageCon];
            UITapGestureRecognizer *tp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchPic:)];
            [tp setNumberOfTapsRequired:1];
            [imageView addGestureRecognizer:tp];
            dispatch_async(dispatch_get_main_queue(), ^{
                [imagesBack addSubview:imageView];
                [imageView release];
                UILabel *conLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 10, 100, 20)];
                conLable.text = [keystableView objectAtIndex:indexPath.row] ;
                [conLable setFont:[UIFont systemFontOfSize:12]];
                conLable.backgroundColor = [UIColor grayColor];
                [cell.contentView addSubview:conLable];
                [conLable release];
                UILabel *friendLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 35, 100, 20)];
                [friendLable setFont:[UIFont systemFontOfSize:12]];
                [friendLable setBackgroundColor:[UIColor grayColor]];
                [friendLable setText:@"朋友："];
                [cell.contentView addSubview:friendLable];
                [friendLable release];
                UILabel *showFriendLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 60, 100, 60)];
                [showFriendLable setFont:[UIFont systemFontOfSize:12]];
                [showFriendLable setBackgroundColor:[UIColor grayColor]];
                showFriendLable.numberOfLines = 0;
                NSString *friendStr = [[NSString alloc]init];
                friendStr = [[allPicArr objectAtIndex:0]picFriend];
                for (int i = 0; i < [allPicArr count]; i++) {
                    
                    imageModeViewController *newImageTodo = nil;
                    newImageTodo = [allPicArr objectAtIndex:i];
                    NSRange rang = [friendStr rangeOfString:[newImageTodo picFriend]] ;
                    if (rang.length == 0 ){
                        
                        [friendStr stringByAppendingString:[newImageTodo picFriend]];
                    }
                }
                //                    showFriendLable.text = [keystableView objectAtIndex:indexPath.row] ;
                showFriendLable.text = friendStr ;
                //                showFriendLable.text = [keystableView objectAtIndex:indexPath.row] ;
                [cell.contentView addSubview:showFriendLable];
                [showFriendLable release];
            });
        });
    }
    
    
    
    else if (counts == 2){
        for (int i = 0; i < counts; i++) {//下载图片用多线程
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                imageModeViewController *newImageTodo = nil;
                newImageTodo = [allPicArr objectAtIndex:i];
                NSString* picUrlStr =  [newImageTodo picUrl];
                NSURL  *imageUrl = [NSURL URLWithString:picUrlStr];
                NSData *imageDate = [[NSData alloc]initWithContentsOfURL:imageUrl];
                UIImage * imageCon = [UIImage imageWithData:imageDate];
                UIImageView *imageView;
                if (i == 0) {
                    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20 , 15, 80, 120)];
                }
                else{
                    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(110 , 15, 80, 120)];
                }
                //图片排列
                imageView.userInteractionEnabled = YES;
                imageView.tag = indexPath.row;
                [imageView setImage:imageCon];
                UITapGestureRecognizer *tp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchPic:)];
                [tp setNumberOfTapsRequired:1];
                [imageView addGestureRecognizer:tp];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [imagesBack addSubview:imageView];
                    [imageView release];
                    UILabel *conLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 10, 100, 20)];
                    conLable.text = [keystableView objectAtIndex:indexPath.row] ;
                    [conLable setFont:[UIFont systemFontOfSize:12]];
                    conLable.backgroundColor = [UIColor grayColor];
                    [cell.contentView addSubview:conLable];
                    [conLable release];
                    UILabel *friendLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 35, 100, 20)];
                    [friendLable setFont:[UIFont systemFontOfSize:12]];
                    [friendLable setBackgroundColor:[UIColor grayColor]];
                    [friendLable setText:@"朋友："];
                    [cell.contentView addSubview:friendLable];
                    [friendLable release];
                    UILabel *showFriendLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 60, 100, 60)];
                    [showFriendLable setFont:[UIFont systemFontOfSize:12]];
                    [showFriendLable setBackgroundColor:[UIColor grayColor]];
                    showFriendLable.numberOfLines = 0;
                    NSString *friendStr = [[NSString alloc]init];
                    friendStr = [[allPicArr objectAtIndex:0]picFriend];
                    for (int i = 0; i < [allPicArr count]; i++) {
                        
                        imageModeViewController *newImageTodo = nil;
                        newImageTodo = [allPicArr objectAtIndex:i];
                        NSRange rang = [friendStr rangeOfString:[newImageTodo picFriend]] ;
                        if (rang.length == 0 ){
                            
                            [friendStr stringByAppendingString:[newImageTodo picFriend]];
                        }
                    }
                    //                    showFriendLable.text = [keystableView objectAtIndex:indexPath.row] ;
                    showFriendLable.text = friendStr ;
                    //                showFriendLable.text = [keystableView objectAtIndex:indexPath.row] ;
                    [cell.contentView addSubview:showFriendLable];
                    [showFriendLable release];
                });
            });
            [cell.contentView addSubview:imagesBack];
            
        }
    }
    
    
    
    
    
    else{
        for (int i = 0; i < counts; i++) {//下载图片用多线程
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                imageModeViewController *newImageTodo = nil;
                newImageTodo = [allPicArr objectAtIndex:i];
                NSString* picUrlStr =  [newImageTodo picUrl];
                NSURL  *imageUrl = [NSURL URLWithString:picUrlStr];
                NSData *imageDate = [[NSData alloc]initWithContentsOfURL:imageUrl];
                UIImage * imageCon = [UIImage imageWithData:imageDate];
                UIImageView *imageView;
                if (i > 2) {
                    imageView = [[UIImageView alloc]initWithFrame:CGRectMake((i - 3) * 50 + 15*(i%3+1) , 79, 57, 62)];
                }
                else{
                    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * 50 + 15*(i%3+1) , 7, 57, 62)];
                }
                //图片排列
                imageView.userInteractionEnabled = YES;
                imageView.tag = indexPath.row;
                [imageView setImage:imageCon];
                UITapGestureRecognizer *tp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchPic:)];
                [tp setNumberOfTapsRequired:1];
                [imageView addGestureRecognizer:tp];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [imagesBack addSubview:imageView];
                    [imageView release];
                    UILabel *conLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 10, 100, 20)];
                    conLable.text = [keystableView objectAtIndex:indexPath.row] ;
                    [conLable setFont:[UIFont systemFontOfSize:12]];
                    conLable.backgroundColor = [UIColor grayColor];
                    [cell.contentView addSubview:conLable];
                    [conLable release];
                    UILabel *friendLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 35, 100, 20)];
                    [friendLable setFont:[UIFont systemFontOfSize:12]];
                    [friendLable setBackgroundColor:[UIColor grayColor]];
                    [friendLable setText:@"朋友："];
                    [cell.contentView addSubview:friendLable];
                    [friendLable release];
                    UILabel *showFriendLable = [[UILabel alloc]initWithFrame:CGRectMake(230 , 60, 100, 60)];
                    [showFriendLable setFont:[UIFont systemFontOfSize:12]];
                    [showFriendLable setBackgroundColor:[UIColor grayColor]];
                    showFriendLable.numberOfLines = 0;
                    NSString *friendStr = [[NSString alloc]init];
                    friendStr = [[allPicArr objectAtIndex:0]picFriend];
                    for (int i = 0; i < [allPicArr count]; i++) {
                        
                        imageModeViewController *newImageTodo = nil;
                        newImageTodo = [allPicArr objectAtIndex:i];
                        NSRange rang = [friendStr rangeOfString:[newImageTodo picFriend]] ;
                        if (rang.length == 0 ){
                            
                            [friendStr stringByAppendingString:[newImageTodo picFriend]];
                        }
                    }
                    //                    showFriendLable.text = [keystableView objectAtIndex:indexPath.row] ;
                    showFriendLable.text = friendStr ;
                    //                showFriendLable.text = [keystableView objectAtIndex:indexPath.row] ;
                    [cell.contentView addSubview:showFriendLable];
                    [showFriendLable release];
                });
            });
            [cell.contentView addSubview:imagesBack];
            
        }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
#pragma mark 这里跳转到图片浏览模式
- (void)changeUserInfor:(id)sender{
    
//    userInfor.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:userInfor animated:YES completion:nil];
    
}
- (void)touchPic:(id)sender{

    SeeSpacePicViewController *seeSpacePicView = nil;
    seeSpacePicView = [[SeeSpacePicViewController alloc]init];
    [seeSpacePicView.spacePicArr removeAllObjects];
    seeSpacePicView.spacePicArr =[self.picDic objectForKey:[keystableView objectAtIndex:[[(UITapGestureRecognizer*)sender view] tag]]];
    seeSpacePicView.spacePicTitleStr = [keystableView objectAtIndex:[[(UITapGestureRecognizer*)sender view] tag]];
    seeSpacePicView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:seeSpacePicView animated:YES completion:nil];
}
//这里跳转到剧场模式end
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [keystableView count];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
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
    [self.keystableView release];
    [self.receivedNickName release];
    [seePicArr release];
    [self.receivedPicArr release];
}

@end
