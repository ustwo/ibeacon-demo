ibeacon-demo
============

iOS project example that uses iBeacon API's in either transmitter or scanner mode


## Requirements

- OS X
- Xcode
- 3rd party iBeacon hardware e.g. Estimote or an iOS device that supports Bluetooth LE (for use as an iBeacon transmitter)

## Usage

Open the project and first update the <code>kBeaconIdentifier</code> with known UUID if using 3rd party hardware iBeacons

Otherwise if using an iOS device transmitter generate a UUID for use by opening a Terminal on Mac and type the following command

<code>uuidgen</code>

Replace the value of the kBeaconIdentifier constant with this UUID

### Transmitter
Activate your iBeacon hardware or deploy the app to an iOS device and choose the transmitter option on the home screen

### Scanner

Deploy the app to another iOS device and choose the scanner option


The scanner app should update when it comes into range of the iBeacon transmitter UUIO it is looking for


## Team

* Development: [Shagun Madhikarmi](mailto:shagun@ustwo.com?subject=ibeacon-demo)
