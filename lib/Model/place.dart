import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceLocation {
  String shopName;
  String address;
  String thumbNail;
  LatLng locationCoords;
  PlaceLocation({
    this.shopName,
    this.locationCoords,
    this.address,
    this.thumbNail,
  });
}

final List<PlaceLocation> placeAvms = [
  PlaceLocation(
      shopName: 'Stumptown Coffee Roasters',
      address: '18 W 29th St',
      locationCoords: LatLng(40.745803, -73.988213),
      thumbNail:
          'https://i4.hurimg.com/i/hurriyet/75/750x422/5df8c39c0f254425902e2271.jpg'),
  PlaceLocation(
      shopName: 'Andrews Coffee Shop',
      address: '463 7th Ave',
      locationCoords: LatLng(40.751908, -73.989804),
      thumbNail:
          'https://lh5.googleusercontent.com/p/AF1QipOfv3DSTkjsgvwCsUe_flDr4DBXneEVR1hWQCvR=w90-h90-n-k-no'),
  PlaceLocation(
      shopName: 'Third Rail Coffee',
      address: '240 Sullivan St',
      locationCoords: LatLng(40.730148, -73.999639),
      thumbNail:
          'https://lh5.googleusercontent.com/p/AF1QipPGoxAP7eK6C44vSIx4SdhXdp78qiZz2qKp8-o1=w90-h90-n-k-no'),
  PlaceLocation(
      shopName: 'Hi-Collar',
      address: '214 E 10th St',
      locationCoords: LatLng(40.729515, -73.985927),
      thumbNail:
          'https://lh5.googleusercontent.com/p/AF1QipNhygtMc1wNzN4n6txZLzIhgJ-QZ044R4axyFZX=w90-h90-n-k-no'),
  PlaceLocation(
      shopName: 'Everyman Espresso',
      address: '301 W Broadway',
      locationCoords: LatLng(40.721622, -74.004308),
      thumbNail:
          'https://lh5.googleusercontent.com/p/AF1QipOMNvnrTlesBJwUcVVFBqVF-KnMVlJMi7_uU6lZ=w90-h90-n-k-no')
];
