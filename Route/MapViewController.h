//
//  MapViewController.h
//  Route
//
//  Created by Divyankitha Raghava Urs on 9/25/17.
//  Copyright © 2017 Divyankitha Raghava Urs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>

@interface MapViewController : UIViewController<MKMapViewDelegate>

@property CLLocationCoordinate2D coords;
@property CLLocationCoordinate2D coords2;
- (id)initWithCoordinates:(CLLocationCoordinate2D)location;

@property (nonatomic, assign) NSString* sourceAddress;
@property (nonatomic, assign) NSString* destinationAddress;

@property (strong, nonatomic) IBOutlet MKMapView *myMapview;

- (IBAction)route:(id)sender;
- (IBAction)mark:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *dis;

@end
