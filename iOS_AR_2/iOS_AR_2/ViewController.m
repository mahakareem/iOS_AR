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
        /*
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Camera"
                                                                        message:@"Camera not detected" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Fine" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        */
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"camera"
                                                       message:@"not availabe"
                                                      delegate:self
                                             cancelButtonTitle:@"ok"
                                             otherButtonTitles:nil, nil];
         [alert show];
    }
    
    
    
    if (frontCameraAvailable) {
        
       /* UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Front Camera"
                                                                       message:@"Front Camera is detected"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"alright?" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        */
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Front camera"
                                                       message:@"availabe"
                                                      delegate:self
                                             cancelButtonTitle:@"ok"
                                             otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else {
        /*
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Front Camera"
                                                                       message:@"Front Camera not detected" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Fine" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        */
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


}



- (BOOL) isVideoCameraAvailable{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    NSArray *sourceTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    
    if(![sourceTypes containsObject:(NSString *)kUTTypeMovie])
    {
        return NO;
    }
    
    return YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
