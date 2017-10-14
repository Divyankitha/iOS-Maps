//
//  ViewController.m
//  Route
//
//  Created by Divyankitha Raghava Urs on 9/25/17.
//  Copyright © 2017 Divyankitha Raghava Urs. All rights reserved.
//

#import "ViewController.h"
#import "MapViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *sourceAddressString =
    [NSString stringWithFormat:
     @"%@ %@ %@ %@",
     _startStreet.text,
     _startCity.text,
     _startState.text,
     _startZip.text];
    NSLog(@"%@", sourceAddressString);
    
    NSString *destinationAddressString =
    [NSString stringWithFormat:
     @"%@ %@ %@ %@",
     _destStreet.text,
     _destCity.text,
     _destState.text,
     _destZip.text];
    NSLog(@"%@", destinationAddressString);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)Go:(UIButton *)sender
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Inside prepare for seque");
    if([[segue identifier] isEqualToString:@"gotoMap"])
    {
    MapViewController *destViewController = (MapViewController *)segue.destinationViewController;
    destViewController.dis.text = _sourceAddressString;
    destViewController.destinationAddress = _destinationAddressString;
    }
}
@end
