//
//  MapViewController.m
//  Route
//
//  Created by Divyankitha Raghava Urs on 9/25/17.
//  Copyright © 2017 Divyankitha Raghava Urs. All rights reserved.
//

#import "MapViewController.h"
#import "annotation.h"

@interface MapViewController ()
@property (strong, nonatomic) MKPlacemark *destination;
@property (strong,nonatomic) MKPlacemark *source;
@property (strong, nonatomic) NSMutableArray *listAnnotation ;

@end
MKCoordinateRegion region;

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MKCoordinateRegion myRegion;
    
    CLLocationCoordinate2D center;
    center.latitude = 37.336079;
    center.longitude = -121.880454;
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.1f;
    span.longitudeDelta = 0.1f;
    
    myRegion.span=span;
    myRegion.center = center;
    
    [_myMapview setRegion:myRegion animated:YES];
    
    NSLog(@"%@", _sourceAddress);
    NSLog(@"%@", _destinationAddress);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)route:(id)sender
{
    NSLog(@"Inside route button");
    [self getDirections];
}

- (IBAction)mark:(id)sender
{
    [self.myMapview removeOverlays:self.myMapview.overlays];
    _listAnnotation = [[NSMutableArray alloc] init];
    CLLocationCoordinate2D location;
    annotation *myAnnotation ;
    
    myAnnotation = [[annotation alloc] init];
    location.latitude = 37.3327; //sap
    location.longitude = -121.9012;
    myAnnotation.coordinate = location;
    myAnnotation.title = @"Source";
    myAnnotation.title = @"Start Here!";
    [_listAnnotation addObject:myAnnotation];
    
    myAnnotation = [[annotation alloc] init];
    location.latitude = 37.336079;//sjsu
    location.longitude = -121.880454;
    myAnnotation.coordinate = location;
    myAnnotation.title = @"Destination";
    myAnnotation.title = @"Stop Here!";
    [_listAnnotation addObject:myAnnotation];
    
    [self.myMapview addAnnotations:_listAnnotation];
}

-(void)getDirections
{
    [self.myMapview removeAnnotations: _listAnnotation];
    
    NSLog(@"%@", _sourceAddress);
    NSLog(@"%@", _destinationAddress);
    
    
    CLGeocoder *geocoderSource = [[CLGeocoder alloc] init];
    NSLog(@"%@", _sourceAddress);
    
    [geocoderSource geocodeAddressString:_sourceAddress completionHandler:^(NSArray *placemarks,NSError *error)
     {
         if (error)
         {
             NSLog(@"Geocode failed with error: %@", error);
             return;
         }
         
         if (placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark = placemarks[0];
             
             CLLocation *location = placemark.location;
             
             _coords = location.coordinate;
             //_display.text = [NSString localizedStringWithFormat: @"Lat: %f, long = %f", _coords.latitude, _coords.longitude];
             
         }
     }];
    
    
    CLLocationCoordinate2D sourcCoords = _coords;
    CLLocationCoordinate2D sourceCoords;
    sourceCoords.latitude = 37.3327;
    sourceCoords.longitude = -121.9012;

    MKPlacemark *placemark  = [[MKPlacemark alloc] initWithCoordinate:sourceCoords addressDictionary:nil];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = sourceCoords;
    annotation.title = @"Source";
    [self.myMapview addAnnotation:annotation];
    [self.myMapview addAnnotation:placemark];

    _source = placemark;
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:_source];
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = mapItem;
    CLGeocoder *geocoderDestination = [[CLGeocoder alloc] init];
    

    [geocoderDestination geocodeAddressString:_destinationAddress completionHandler:^(NSArray *placemarks,NSError *error)
     {
         if (error)
         {
             NSLog(@"Geocode failed with error: %@", error);
             return;
         }
         
         if (placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark = placemarks[0];
             
             CLLocation *location = placemark.location;
             
             _coords2 = location.coordinate;
             /* _display.text = [NSString localizedStringWithFormat: @"Lat: %f, long = %f", _coords2.latitude, _coords2.longitude];*/
             
             
             
         }
     }];
    
    
    CLLocationCoordinate2D desCoords = _coords2;
    
    CLLocationCoordinate2D destCoords;
    destCoords.latitude = 37.336079;
    destCoords.longitude = -121.880454;
    
    MKPlacemark *placemark1  = [[MKPlacemark alloc] initWithCoordinate:destCoords addressDictionary:nil];
    
    MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init];
    annotation1.coordinate = destCoords;
    annotation1.title = @"Destination";
    [self.myMapview addAnnotation:annotation1];
    [self.myMapview addAnnotation:placemark1];
    _destination = placemark1;
    
    MKMapItem *mapItem1 = [[MKMapItem alloc] initWithPlacemark:_destination];
    
    request.destination = mapItem1;
    request.requestsAlternateRoutes = NO;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    
    [directions calculateDirectionsWithCompletionHandler: ^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"ERROR");
            NSLog(@"%@",[error localizedDescription]);
        } else {
            [self showRoute:response];
        }
    }];
    
}

-(void)showRoute:(MKDirectionsResponse *)response
{
    NSLog(@"Inside show route");
    for (MKRoute *route in response.routes)
    {
        [_myMapview addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
}

#pragma mark - MKMapViewDelegate methods

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    NSLog(@"Inside renderer");
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    renderer.strokeColor = [UIColor colorWithRed:0.0/255.0 green:171.0/255.0 blue:253.0/255.0 alpha:1.0];
    renderer.lineWidth = 5.0;
    
    return  renderer;
}
@end
