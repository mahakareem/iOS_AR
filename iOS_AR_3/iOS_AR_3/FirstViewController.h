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
                                                // declares that this class conforms to CLLocation delegate
                                                // this si send info to locationManger didupdate to location
UITextView *locationTextView;
UILabel *locationTextLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *locationTextLabel;

-(void)startStandardUpdates;

@end

