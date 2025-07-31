import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Position?> getCurrentLocation() async {
  var status = await Permission.locationWhenInUse.request();
  if (status.isGranted) {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  } else {
    debugPrint("Location permission not granted.");
    return null;
  }
}
