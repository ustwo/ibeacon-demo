//
//  ConfigViewController.h
//  BeaconDemo
//
//  Created by Shagun Madhikarmi on 02/02/2014.
//  Copyright (c) 2014 ustwo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ConfigViewController : UIViewController <CBPeripheralManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;

// Object defines settings needed to set the beacon up up as a transmitter.
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;

// Contains peripheral data of the beacon
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;

// Object with methods to used to start transmitting the becon
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

@end
