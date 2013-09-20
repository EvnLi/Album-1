//
//  CheckNetWork.m
//  Album
//
//  Created by fhkj on 13-9-12.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "CheckNetWork.h"
#import "Reachability.h"

@implementation CheckNetWork

+(BOOL)isNetWorkEnable
{
    if(([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable)
       && ([Reachability reachabilityForLocalWiFi].currentReachabilityStatus == NotReachable))
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络不给力啊" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
