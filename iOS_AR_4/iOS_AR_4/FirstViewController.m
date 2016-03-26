//
//  FirstViewController.m
//  iOS_AR_4
//
//  Created by maha k on 26/3/16.
//  Copyright © 2016 maha. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize xLabel, yLabel, zLabel, xProgView, yProgView, zProgView;



- (void)viewDidLoad {
    
    
    //create reference to the shared accelerometer
    accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.updateInterval = .5; // update per second... set to .5 updates it twice per second
    accelerometer.delegate = self;
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//[update]this function is replaced by the coreMotion class... not used anymore by iOS

// this function will be called everytime there is new updates in the values
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    //the acceleration value of the axis will be populated in the label
    xLabel.text = [NSString stringWithFormat:@"%@%f", @"X: ", acceleration.x];
    yLabel.text = [NSString stringWithFormat:@"%@%f", @"Y: ", acceleration.y];
    zLabel.text = [NSString stringWithFormat:@"%@%f", @"Z: ", acceleration.z];
    
    //same values are popluated to the progress bar. Notice I'm using absolute value
    //why ABS? because progress bars can't display negative values
    xProgView.progress = ABS(acceleration.x);
    yProgView.progress = ABS(acceleration.y);
    zProgView.progress = ABS(acceleration.z);
    
    //define a constant to serve as threshold for shake detection
    double const kThreshold = 2.0; // 2Gs the default to measure shaking process
    
    //if there is a shake alert user
    if( ABS(acceleration.x) > kThreshold || ABS(acceleration.y) > kThreshold || ABS(acceleration.z) > kThreshold)
    {
        NSLog(@" shake is detected!");
        UIAlertView *alert= [[ UIAlertView alloc]initWithTitle:@"Shake it " message:(@"shake it, shake it") delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
        
        [alert show];

    }
}

@end
