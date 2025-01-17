import 'package:geolocator/geolocator.dart' as pt;
import 'package:flutter/material.dart';

class MaPosition {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<pt.Position> determinePosition() async {
    bool serviceEnabled;
    pt.LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await pt.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await pt.Geolocator.checkPermission();
    if (permission == pt.LocationPermission.denied) {
      permission = await pt.Geolocator.requestPermission();
      if (permission == pt.LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == pt.LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return pt.Geolocator.getCurrentPosition();
  }
}
