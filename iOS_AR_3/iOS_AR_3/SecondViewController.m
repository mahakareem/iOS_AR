//
//  SecondViewController.m
//  iOS_AR_3
//
//  Created by maha k on 23/1/16.
//  Copyright © 2016 maha. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end


@implementation SecondViewController
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:mapView]; //set the delegate of the viewMap to self
    
    

    [NSThread detachNewThreadSelector:@selector(displayMap) toTarget:self withObject:nil];
    /*
     [1]
     we can load the viewMap, but used threading instead 
     threading is useful for AR
     
    threads to avoid blocking the main thread of the application, which handles user interface and event-
    related actions
    */
    
   }

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)displayMap{
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init]; only if not ARC
    // to support reference counted memory system (WE DO NOT NEED IT )
    
    
    //create the map manually with ictQATAR in the middle
    CLLocationCoordinate2D ictQATARcoord;
    ictQATARcoord.latitude = 25.31334;
    ictQATARcoord.longitude = 51.51878;
    
    
    /////////////////////////////////////////////////////////////////////////////////
    //////////////////////////// [ calculate the delta ] ////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////
    //used code from troybrant.net/blog/2010/01/set-the-zoom-level-of-an-mkmapview/
    /////////////////////////////////////////////////////////////////////////////////
    
    //[1] convert center coordiate to pixel space
    double centerPixelX = [self latitudeToPixelSpaceY:ictQATARcoord.latitude];
    double centerPixelY = [self longitudeToPixelSpaceX:ictQATARcoord.longitude];
    // [2] determine the scale value from the zoom level
    NSUInteger zoomLevel = 11;
    NSInteger zoomExponent = 20 - zoomLevel;
    double zoomScale = pow(2, zoomExponent);
    // [3] scale the map’s size in pixel space
    CGSize mapSizeInPixels = mapView.bounds.size;
    double scaledMapWidth = mapSizeInPixels.width * zoomScale;
    double scaledMapHeight = mapSizeInPixels.height * zoomScale;
    
    // [4]figure out the position of the top-left pixel
    double topLeftPixelX = centerPixelX - (scaledMapWidth / 2);
    double topLeftPixelY = centerPixelY - (scaledMapHeight / 2);
    
    // [5]find delta between left and right longitudes
    CLLocationDegrees minLng = [self pixelSpaceXToLongitude:topLeftPixelX];
    CLLocationDegrees maxLng = [self pixelSpaceXToLongitude:topLeftPixelX + scaledMapWidth];
    CLLocationDegrees longitudeDelta = maxLng - minLng;
    
    // [6]find delta between top and bottom latitudes
    CLLocationDegrees minLat = [self pixelSpaceYToLatitude:topLeftPixelY];
    CLLocationDegrees maxLat = [self pixelSpaceYToLatitude:topLeftPixelY + scaledMapHeight];
    CLLocationDegrees latitudeDelta = -1 * (maxLat - minLat);
    //////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////
    
    
    MKCoordinateSpan span = MKCoordinateSpanMake( latitudeDelta, longitudeDelta); //using delta values
    
    
    
    //MapKit does not include a way to set the zoom level. Instead, the zoom level is set implicitly
    //by defining the MKCoordinateRegion of the map’s viewport
    
    MKCoordinateRegion ictQATARregion = MKCoordinateRegionMake(ictQATARcoord, span);// if used delta
    //MKCoordinateRegion ictQATARregion = MKCoordinateRegionMakeWithDistance(ictQATARcoord,3500, 3500);
    //or simply if you do not want to calculat the delta, use this function. 3500 meters in raduis
    
    //add annotation
    MapAnnotation *addAnnotation = [[MapAnnotation alloc]initWithCoordinate:ictQATARcoord];
    [addAnnotation setTitle:@"ictQATAR"];
    [addAnnotation setsubtitle:@"or is it Ministry of transportation?"];
    [mapView addAnnotation:addAnnotation];
    [mapView setDelegate:self];// if not added then mapview for annotation wont be called
    // u need to assign the class for map view
    
    
    [mapView setRegion:ictQATARregion animated:YES];
    [mapView setScrollEnabled:YES];
    [mapView setZoomEnabled:YES];
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{// one of the default methods. will be called when an annotation is created and will customize the pin
    MKPinAnnotationView *annView =[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"MyPin"];
    
    
    
    annView.animatesDrop= true;
    annView.canShowCallout=YES;
    [annView setSelected:YES];
    annView.pinTintColor = [UIColor purpleColor];
    annView.calloutOffset = CGPointMake(-50, 5);
    
    
    
    
    return annView;
    
}
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)setupSegmentedControl:(id)sender{
    
     UISegmentedControl *segControl = sender;
    switch (segControl.selectedSegmentIndex) {
        case 0: //standard map
        {
            [mapView setMapType:MKMapTypeStandard];
            break;
        }
        case 1: // satellite view
        {
            [mapView setMapType:MKMapTypeSatellite];
            break;
        }
        case 2: // hybrid view
        {
            [mapView setMapType:MKMapTypeHybrid];
            break;
        }
    }

    //buttonBarSegmentedControl.segmentedControlStyle = UIScrollViewIndicatorStyleWhite;
    buttonBarSegmentedControl.backgroundColor = [UIColor clearColor];
    [buttonBarSegmentedControl setAlpha:0.8];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////// [*] delta points  and longti & latitude //////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

- (double)longitudeToPixelSpaceX:(double)longitude
{
    return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

- (double)latitudeToPixelSpaceY:(double)latitude
{
    return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
}

- (double)pixelSpaceXToLongitude:(double)pixelX
{
    return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI;
}

- (double)pixelSpaceYToLatitude:(double)pixelY
{
    return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI;
}

@end
