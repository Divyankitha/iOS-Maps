//
//  annotation.h
//  Route
//
//  Created by Divyankitha Raghava Urs on 9/26/17.
//  Copyright © 2017 Divyankitha Raghava Urs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapkit/Mapkit.h>

@interface annotation : NSObject <MKAnnotation>

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;


@end
