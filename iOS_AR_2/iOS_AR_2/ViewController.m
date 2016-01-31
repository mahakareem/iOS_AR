//
//  ViewController.m
//  iOS_AR_2
//
//  Created by maha k on 16/1/16.
//  Copyright © 2016 maha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /////////////////////////////////////////////////////////////////////////////////
    /////////////////////////  [1] Check for camera  presence ///////////////////////
    /////////////////////////////////////////////////////////////////////////////////
    
    BOOL cameraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]; //rear camera
 
    BOOL frontCameraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerCameraDeviceFront]; //front camera
    
    
    if (cameraAvailable) {
      
        /* 
         UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Camera"
                                     message:@"Camera is detected"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"alright?"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            [self dismissViewControllerAnimated:YES completion:nil];
                                        }];
        
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        */
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"camera"
                                                       message:@"availabe"
                                                      delegate:self
                                             cancelButtonTitle:@"ok"
                                             otherButtonTitles:nil, nil];
        [alert show];
       // [alert release];
        
        
    }
    else {

        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"camera"
                                                       message:@"not availabe"
                                                      delegate:self
                                             cancelButtonTitle:@"ok"
                                             otherButtonTitles:nil, nil];
         [alert show];
    }
    
    
    
    if (frontCameraAvailable) {

        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Front camera"
                                                       message:@"availabe"
                                                      delegate:self
                                             cancelButtonTitle:@"ok"
                                             otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else {

        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Front camera"
                                                       message:@"not availabe"
                                                      delegate:self
                                             cancelButtonTitle:@"ok"
                                             otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    //////////////////////////////////////////////////////////////////////////////////
    ////////////////////////  [2] Check for digital compus  //////////////////////////
    /////////////////////////////////////////////////////////////////////////////////
    
    BOOL magnetometerAvailable = [CLLocationManager headingAvailable];
    
    if(magnetometerAvailable){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Magnetometer"
                                                      message:@"is availabe"
                                                     delegate:self
                                            cancelButtonTitle:@"ok"
                                            otherButtonTitles:nil, nil];
        [alert show];
    } else{
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Magnetometer"
                                                      message:@"is not availabe"
                                                     delegate:self
                                            cancelButtonTitle:@"ok"
                                            otherButtonTitles:nil, nil];
        [alert show];
    
        
    }
    
    /////////////////////////////////////////////////////////////////////////////////
    ///////////////////////  [3] Check for audio/sound  /////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    BOOL audioAvailable = audioSession.inputIsAvailable;
    
    if(audioAvailable){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Audio"
                                                      message:@"is availabe"
                                                     delegate:self
                                            cancelButtonTitle:@"ok"
                                            otherButtonTitles:nil, nil];
        [alert show];
        
        
    }else{
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Audio"
                                                      message:@"is not availabe"
                                                     delegate:self
                                            cancelButtonTitle:@"ok"
                                            otherButtonTitles:nil, nil];
        [alert show];
    }
    
    /////////////////////////////////////////////////////////////////////////////////
    ///////////////////  [4] Check for video capabilities  //////////////////////////
    /////////////////////////////////////////////////////////////////////////////////
    if([self isVideoCameraAvailable]){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Video "
                                                      message:@"is  availabe"
                                                     delegate:self
                                            cancelButtonTitle:@"ok"
                                            otherButtonTitles:nil, nil];
        [alert show];
    }else{
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Video"
                                                      message:@"is not availabe"
                                                     delegate:self
                                            cancelButtonTitle:@"ok"
                                            otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    /////////////////////////////////////////////////////////////////////////////////
    //////////////////  [5] Check for gyroscope availability  ///////////////////////
    /////////////////////////////////////////////////////////////////////////////////
    if ([self isGyroscopeAvailable]){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Gyroscope "
                                                      message:@"is  availabe"
                                                     delegate:self
                                            cancelButtonTitle:@"ok"
                                            otherButtonTitles:nil, nil];
        [alert show];
    }else{
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Gyroscope"
                                                      message:@"is not availabe"
                                                     delegate:self
                                            cancelButtonTitle:@"ok"
                                            otherButtonTitles:nil, nil];
        [alert show];
    }

}



- (BOOL) isVideoCameraAvailable{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    NSArray *sourceTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    
    if(![sourceTypes containsObject:(NSString *)kUTTypeMovie]) // kUTTypeMovie means that video is supported
    {
        return NO;
    }
    
    return YES;
    
}

-(BOOL) isGyroscopeAvailable{
#ifdef __IPHONE_4_0 //because it was not available for previous versions
    CMMotionManager * motionManager = [[CMMotionManager alloc] init];
    BOOL gyroscopeAvailable = motionManager.gyroAvailable;
    
    return gyroscopeAvailable;
#else
    return NO;
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
