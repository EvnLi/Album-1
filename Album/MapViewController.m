//
//  MapViewController.m
//  Album
//
//  Created by smq on 13-8-21.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize locationStr,receivelocationStr,locationArrXY,locationX,locationY;

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
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UINavigationItem *navItem = [[UINavigationItem alloc]initWithTitle:@"地图"];
    UIBarButtonItem  *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnBack:)];
    [navItem setLeftBarButtonItem:leftBtn];
    [navBar pushNavigationItem:navItem animated:NO];
    [navBar setTintColor:[UIColor redColor]];
    [self.view addSubview:navBar];
    [navItem release];
    [navBar release];
    
    receivelocationStr = [[NSString alloc]init];
    receivelocationStr = locationStr;
    locationArrXY = [receivelocationStr componentsSeparatedByString:@","];
    locationX = [locationArrXY objectAtIndex:0];
    locationY = [locationArrXY objectAtIndex:1];
    if (([locationX intValue] == 0)&&([locationY intValue] == 0)) {
        locationX = [NSString stringWithFormat:@"22.663550376891433"];
        locationY = [NSString stringWithFormat:@"114.05568122863438"];
    }
    mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 46, 320, 480)];
    mapView.showsUserLocation = YES;
    mapView.mapType = MKMapTypeStandard;
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake([locationX doubleValue], [locationY doubleValue]);
     float zoomLevel = 0.02;
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
    [self.view addSubview:mapView];
    
    // Do any additional setup af;ter loading the view from its nib.
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
    [mapView release];
    [receivelocationStr release];
}
@end
