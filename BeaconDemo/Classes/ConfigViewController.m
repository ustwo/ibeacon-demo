//
//  ConfigViewController.m
//  BeaconDemo
//
//  Created by Shagun Madhikarmi on 02/02/2014.
//  Copyright (c) 2014 ustwo. All rights reserved.
//

#import "ConfigViewController.h"

@interface ConfigViewController ()
@end

@implementation ConfigViewController


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initBeacon];
    [self setLabels];
}


#pragma mark - User Interface

- (void)setLabels
{
    if(self.beaconRegion)
    {
        self.uuidLabel.text = self.beaconRegion.proximityUUID.UUIDString;
        self.majorLabel.text = [NSString stringWithFormat:@"%@", self.beaconRegion.major];
        self.minorLabel.text = [NSString stringWithFormat:@"%@", self.beaconRegion.minor];
        self.identityLabel.text = self.beaconRegion.identifier;
    }
}


#pragma mark - Setup - Beacon Region

- (void)initBeacon
{
    // Open Terminal on Mac and type uuidgen. Paste value here
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:kBeaconIdentifier];
    
    // Create a specific beacon region with our UUID and major minor to identify the beacon
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:1
                                                                minor:1
                                                           identifier:kCompanyIdentifier];
}


#pragma mark - UI actions

- (IBAction)transmitBeacon:(UIButton *)sender
{
    // Prepeare dictionary data from the beacon region
    self.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
    
    // Create the peripheral manager.
    // Don't start advertising until the state changes to powered on
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
}


#pragma mark - CBPeripheralManagerDelegate methods

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheralManager
{
    if (peripheralManager.state == CBPeripheralManagerStatePoweredOn)
    {
        NSLog(@"Powered On");
        
        // Start advertising with the beacon data in dictionary form
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
    }
    else if (peripheralManager.state == CBPeripheralManagerStatePoweredOff)
    {
        NSLog(@"Powered Off");
        
        [self.peripheralManager stopAdvertising];
    }
}


#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
