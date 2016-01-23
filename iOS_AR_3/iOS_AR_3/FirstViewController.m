//
//  FirstViewController.m
//  iOS_AR_3
//
//  Created by maha k on 23/1/16.
//  Copyright © 2016 maha. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize locationTextLabel;


- (void)viewDidLoad {
    [self startStandardUpdates]; //call the method to run 
    [super viewDidLoad];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    //return YES for supported orientations
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    NSDate * eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs (howRecent)<15.0) { //this is Apple recommendation to check the date
        locationTextLabel.text= [NSString stringWithFormat:@"latitude %+.6f, longitude %+.6f\n",
                                 newLocation.coordinate.latitude,
                                 newLocation.coordinate.longitude];
    }else{
        locationTextLabel.text =@"Update is old";
    }
}
-(void)startStandardUpdates{  //to start location service
    CLLocationManager *locationManger = [[CLLocationManager alloc]init]; //our object
    locationManger.delegate = self;
    locationManger.desiredAccuracy = kCLLocationAccuracyBest; // be careful for battery sake
    locationManger.distanceFilter = .1;   // how long to change or update the location .1 km
    
    
    [locationManger startUpdatingLocation];
    
}

@end
