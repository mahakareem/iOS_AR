//
//  FirstViewController.h
//  iOS_AR_3
//
//  Created by maha k on 23/1/16.
//  Copyright © 2016 maha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface FirstViewController : UIViewController <CLLocationManagerDelegate>{
    UILabel *locationTextLabel, *locationAltitude,*latitudeLabel,*longitudeLabel,*altitudeLabel;

    CLLocationManager *locationManager;
    
    CLLocation* location, *currentlocation, *ictQATARloc;
    
    CLRegion *ictQATAR;
    
    NSString   *myLocation;
}

@property (nonatomic, retain) IBOutlet UILabel *locationTextLabel;
@property (nonatomic, retain) IBOutlet UILabel *locationAltitude;
@property (nonatomic, retain) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *AltitudeLabel;

-(void)startStandardUpdates;
//- (NSString *)deviceLocation;
-(void)startRegionaMonitoring;

@end

