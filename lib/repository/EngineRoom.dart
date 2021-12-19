import 'dart:developer';

import 'package:crimetracker/model/crime.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
class EngineRoom {

  static var databasePath;
  static var path;
  static String eventTable = "EVENT";


  // static Future<Position> getMyLocation() async{
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  //   log("HU",error:position);
  //
  //   return position;
  // }
  //

  // static Future<String> getLocAddress() async {
  //
  //   // final Geolocator geolocator = Geolocator();
  //   Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
  //   bool serviceEnabled = await geolocator.isLocationServiceEnabled();
  //   GeolocationStatus permission;
  //
  //   if (!serviceEnabled) {
  //         // Location services are not enabled don't continue
  //         // accessing the position and request users of the
  //         // App to enable the location services.
  //         return Future.error('Location services are disabled.');
  //       }
  //
  //   permission = await geolocator.checkGeolocationPermissionStatus();
  //     if (permission == GeolocationStatus.denied) {
  //       permission =  GeolocationStatus.granted;
  //       if (permission == GeolocationStatus.denied) {
  //         // Permissions are denied, next time you could try
  //         // requesting permissions again (this is also where
  //         // Android's shouldShowRequestPermissionRationale
  //         // returned true. According to Android guidelines
  //         // your App should show an explanatory UI now.
  //         return Future.error('Location permissions are denied');
  //       }
  //     }
  //   Position position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  //   List<Placemark> placemark = await geolocator.placemarkFromCoordinates(position.latitude, position.longitude);
  //   Placemark data = placemark[0];
  //   return "${data.name}  ${data.locality}  ${data.country}";
  // }

  static Future<String> getLocAddress() async {

    // final Geolocator geolocator = Geolocator();
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission =  await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark data = placemark[0];
    return "${data.name}  ${data.locality}  ${data.country}";
  }

  //
  // /// Determine the current position of the device.
  // ///
  // /// When the location services are not enabled or permissions
  // /// are denied the `Future` will return an error.
  // static Future<Position> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   print(Geolocator.getCurrentPosition());
  //   return await Geolocator.getCurrentPosition();
  // }
}