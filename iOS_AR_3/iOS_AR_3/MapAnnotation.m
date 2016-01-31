//
//  MapAnnotation.m
//  iOS_AR_3
//
//  Created by maha k on 31/1/16.
//  Copyright © 2016 maha. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation
@synthesize coordinate, titletext, subtitletext;



-(NSString *)subtitle{
    return subtitletext;
}
-(NSString *)title{
    return titletext;
}
-(void)setTitle:(NSString*)strTitle{
    self.titletext = strTitle;
}
-(void)setsubtitle:(NSString*)strSubTitle{
    self.subtitletext = strSubTitle;
}
-(id)initWithCoordinate: (CLLocationCoordinate2D)coor{
    coordinate = coor;
    return self;
    
}

@end
