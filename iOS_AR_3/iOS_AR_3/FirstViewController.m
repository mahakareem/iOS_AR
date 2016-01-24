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
@synthesize locationTextLabel, locationAltitude,latitudeLabel,longitudeLabel,AltitudeLabel;

- (void)viewDidLoad {
    
    [self startStandardUpdates];
    [self startRegionaMonitoring];

    [super viewDidLoad];
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    //return YES for supported orientations
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}



///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

-(double)calculateDistance{
    
    currentlocation = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    
    ictQATARloc = [[CLLocation alloc] initWithLatitude:25.31334 longitude:51.51878];
    
    return [currentlocation distanceFromLocation:ictQATARloc];
    
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)startStandardUpdates{  //to start location service
    
    // Check for iOS 8. Without this guard the code will not work and wont show any errors
    [locationManager requestWhenInUseAuthorization];
    //[locationManager requestAlwaysAuthorization];
    
    
    if (nil == locationManager){
        locationManager = [[CLLocationManager alloc] init]; // our object
    }
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever I move
    [locationManager startUpdatingLocation];

    //locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // to the nearest 100 m
    //locationManger.distanceFilter = 1;   // how long to change or update the location 1 km
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    // If it's a relatively recent event, turn off updates to save power.
    location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    
    
   //if(signbit(location.verticalAccuracy)){ // for vertical alignment (useful when using the camera
    //altitude can help make sure that the angle of the camera is appropriate
    //check the availability of altitude first then get it from GPS
    
    
   if (abs(howRecent) < 15.0) {
        // If the event is recent do:
       latitudeLabel.text = [NSString stringWithFormat:@"%+.6f",location.coordinate.latitude];
       longitudeLabel.text = [NSString stringWithFormat:@"%+.6f",location.coordinate.longitude];
       AltitudeLabel.text = [NSString stringWithFormat:@"%+.6f m",location.altitude];
       
       
       locationTextLabel.text = [NSString stringWithFormat:@"the distance between here & ictQATAR is %.02f", [self calculateDistance]];
       
       
   }else{
       AltitudeLabel.text = [NSString stringWithFormat:@"%6.2f m. ", location.altitude];
   }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    NSLog(@"%@",error);
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)startRegionaMonitoring
{
    /*
    CLLocationManager *locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(25.31334, 51.51878); //ictQATAR coordinates
    CLRegion *region = [[CLRegion alloc]initCircularRegionWithCenter:coord radius:1000.0 identifier:@"ictQATAR"];
    [locationManager startMonitoringForRegion:region desiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    */
    
    
    //1st : make sure of the permission is set to always. while driving is not enough :(
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self askForPermission];
            return;
            
        case kCLAuthorizationStatusAuthorizedAlways:
            [self setUpictQATARGeofences];
            return;
            
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            [self SorryAlert];
            return;
    }
    
   
}


-(void) askForPermission{
    /*  
     you’ll need to implement the CLLocationManagerDelegate protocol and implement didChangeAuthorizationStatus to
     detect if permission was granted, or not. The new status is of the same CLAuthorizationStatus type that 
     authorizationStatus gave before
    */
    locationManager = [CLLocationManager new];
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [locationManager requestAlwaysAuthorization];
    } else {
        [self setUpictQATARGeofences];
    }
}

-(void)setUpictQATARGeofences
{
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(25.31334, 51.51878);
    CLRegion *ictQATAR = [[CLCircularRegion alloc]initWithCenter:center radius:100.0  //radius in meters
                                                    identifier:@"ictQATAR"];
    
    [locationManager startMonitoringForRegion:ictQATAR];
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)SorryAlert{
    UIAlertView *alert= [[ UIAlertView alloc]initWithTitle:@"ictQATAR Alert" message:@"we cannot help you. get out of hear" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    UIAlertView *alert= [[ UIAlertView alloc]initWithTitle:@"ictQATAR Error" message:(@"It seems that we failed. %@",error) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
    
    [alert show];
    
    NSLog(@"%@",error);
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    UIAlertView *alert= [[ UIAlertView alloc]initWithTitle:@"ictQATAR Alert" message:@"ictQATAR is near" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
    
    
    [alert show];
}
///////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    UIAlertView *alert= [[ UIAlertView alloc]initWithTitle:@"ictQATAR Alert" message:@"you are no longer near ictQATAR " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil ];
    
    [alert show];
}
@end
