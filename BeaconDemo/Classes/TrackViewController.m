//
//  TrackViewController.m
//  BeaconDemo
//
//  Created by Shagun Madhikarmi on 02/02/2014.
//  Copyright (c) 2014 ustwo. All rights reserved.
//

#import "TrackViewController.h"

@interface TrackViewController ()
@end

@implementation TrackViewController


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self initRegion];
    
//    UNCOMMENT BELOW TO FAKE AUTO REGION ENTRY i.e. if you're starting from within the beacon region
//    [self locationManager:self.locationManager didStartMonitoringForRegion:self.beaconRegion];
}


#pragma mark - Setup - Beacon Region

- (void)initRegion
{
    // Open Terminal on Mac and type uuidgen. Paste value here
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:kBeaconIdentifier];

    // Setup the beacon region we want to look for. Comprises all beacons in that region
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                           identifier:kCompanyIdentifier];
    
    // Start looking for beacon regions
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
}


#pragma mark - CLLocationManagerDelegate methods

// UNCOMMENT BELOW TO FAKE AUTO REGION ENTRY i.e. if you're starting from within the beacon region
/*
 - (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
 {
     [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
 }
*/

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    // Entered a beacon region. So now start discovering all beacons in the region.
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    self.beaconFoundLabel.text = @"No";
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    // Pick the last beacon from the set of beacons we discovered
    CLBeacon *beacon = [[CLBeacon alloc] init];
    beacon = [beacons lastObject]; // Note. assuming one beacon this is sufficient
    
    // Update UI
    self.beaconFoundLabel.text = @"Yes";
    self.proximityUUIDLabel.text = beacon.proximityUUID.UUIDString;
    self.majorLabel.text = [NSString stringWithFormat:@"%@", beacon.major];
    self.minorLabel.text = [NSString stringWithFormat:@"%@", beacon.minor];
    self.accuracyLabel.text = [NSString stringWithFormat:@"%f", beacon.accuracy];
    
    if (beacon.proximity == CLProximityUnknown)
    {
        self.distanceLabel.text = @"Unknown Proximity";
    }
    else if (beacon.proximity == CLProximityImmediate) // e.g. half meter or so away
    {
        self.distanceLabel.text = @"Immediate";
    }
    else if (beacon.proximity == CLProximityNear) // e.g. a meter or so
    {
        self.distanceLabel.text = @"Near";
    }
    else if (beacon.proximity == CLProximityFar) // e.g. several meters away
    {
        self.distanceLabel.text = @"Far";
    }

    // rssi is the signal strength in decibels
    self.rssiLabel.text = [NSString stringWithFormat:@"%li", (long)beacon.rssi];
}


#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
