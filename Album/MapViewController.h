//
//  MapViewController.h
//  Album
//
//  Created by smq on 13-8-21.
//  Copyright (c) 2013年 smq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>{
    MKMapView *mapView;
    CLLocationManager *locationManager;
    NSString          *locationStr;
    NSString          *receivelocationStr;
    NSArray           *locationArrXY;
    NSString          *locationX;
    NSString          *locationY;
    
    
}

@property (nonatomic,retain) NSString     *locationStr;
@property (nonatomic,retain) NSString     *receivelocationStr;
@property (nonatomic,retain) NSArray      *locationArrXY;
@property (nonatomic,retain) NSString      *locationX;
@property (nonatomic,retain) NSString      *locationY;
@end
