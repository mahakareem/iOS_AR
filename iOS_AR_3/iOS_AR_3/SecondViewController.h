//
//  SecondViewController.h
//  iOS_AR_3
//
//  Created by maha k on 23/1/16.
//  Copyright © 2016 maha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"


#define MERCATOR_OFFSET 268435456
#define MERCATOR_RADIUS 85445659.44705395

@interface SecondViewController : UIViewController <MKMapViewDelegate>{
                                    //declare that our class is an MKMapView delagate to handle updates from
                                    //the map
    IBOutlet MKMapView *mapView;
    UISegmentedControl *buttonBarSegmentedControl;
    
}

@property (nonatomic, retain)IBOutlet MKMapView *mapView;
@property (nonatomic, retain)IBOutlet UISegmentedControl *buttonBarSegmentedControl;


- (double)longitudeToPixelSpaceX:(double)longitude;
- (void)initSegmentedControl;

- (IBAction)setupSegmentedControl:(id)sender;


@end

