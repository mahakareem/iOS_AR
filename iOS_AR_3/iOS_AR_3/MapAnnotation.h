//
//  MapAnnotation.h
//  iOS_AR_3
//
//  Created by maha k on 31/1/16.
//  Copyright © 2016 maha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString *subtitletext, *titletext;
}

@property (nonatomic, readonly)CLLocationCoordinate2D coordinate;
@property (readwrite, retain)NSString *titletext;
@property (readwrite, retain)NSString *subtitletext;

-(id)initWithCoordinate: (CLLocationCoordinate2D)coordinate;
-(NSString *)subtitle; //getter
-(NSString *)title; //getter
-(void)setTitle:(NSString*)strTitle; //setter
-(void)setsubtitle:(NSString*)strSubTitle; //setter

@end
