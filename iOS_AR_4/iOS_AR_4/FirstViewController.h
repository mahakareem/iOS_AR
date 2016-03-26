//
//  FirstViewController.h
//  iOS_AR_4
//
//  Created by maha k on 26/3/16.
//  Copyright © 2016 maha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UIAccelerometerDelegate>{

    UIAccelerometer *accelerometer;
    
    UILabel *xLabel;
    UILabel *yLabel;
    UILabel *zLabel;
    
    UIProgressView *xProgView;
    UIProgressView *yProgView;
    UIProgressView *zProgView;
    
}

@property (nonatomic, retain) UIAccelerometer *accelerometer;

//declare 3 labels
@property (nonatomic, retain) IBOutlet UILabel *xLabel;
@property (nonatomic, retain) IBOutlet UILabel *yLabel;
@property (nonatomic, retain) IBOutlet UILabel *zLabel;

//declare 3 progress bars 
@property (nonatomic, retain) IBOutlet UIProgressView *xProgView;
@property (nonatomic, retain) IBOutlet UIProgressView *yProgView;
@property (nonatomic, retain) IBOutlet UIProgressView *zProgView;



@end

