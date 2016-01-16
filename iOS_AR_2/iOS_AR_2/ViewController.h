//
//  ViewController.h
//  iOS_AR_2
//
//  Created by maha k on 16/1/16.
//  Copyright © 2016 maha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h> // to be able to call CLLocationManager/ digital compus
#import <AVFoundation/AVFoundation.h> // sound 
#import <MobileCoreServices/UTCoreTypes.h> // video capability
#import <CoreMotion/CoreMotion.h> //gyrpscope / accelerometer


@interface ViewController : UIViewController{
    
    
}


- (BOOL) isVideoCameraAvailable;
- (BOOL) isGyroscopeAvailable;


@end

