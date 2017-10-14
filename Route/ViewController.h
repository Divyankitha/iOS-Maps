//
//  ViewController.h
//  Route
//
//  Created by Divyankitha Raghava Urs on 9/25/17.
//  Copyright © 2017 Divyankitha Raghava Urs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>

@interface ViewController : UIViewController


@property NSString *sourceAddressString;
@property NSString *destinationAddressString;

@property (weak, nonatomic) IBOutlet UITextField *startStreet;
@property (weak, nonatomic) IBOutlet UITextField *startCity;
@property (weak, nonatomic) IBOutlet UITextField *startState;
@property (strong, nonatomic) IBOutlet UITextField *startZip;


@property (weak, nonatomic) IBOutlet UITextField *destStreet;
@property (weak, nonatomic) IBOutlet UITextField *destCity;
@property (weak, nonatomic) IBOutlet UITextField *destState;
@property (weak, nonatomic) IBOutlet UITextField *destZip;

- (IBAction)Go:(UIButton *)sender;

@end

