import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class LocationModel {
  final String id;
  final String address;
  final double latitude;
  final double longitude;

  LocationModel({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class LocationProvider extends ChangeNotifier {
  final AppDio dio;
  List<LocationModel> _locations = [];

  List<LocationModel> get locations => _locations;

  LocationProvider(BuildContext context) : dio = AppDio(context);
  Future<void> fetchLocations() async {
    try {
      final res = await dio.get(path: AppUrls.getLocations);

      final List<dynamic> locationList =
          res.data['data']; // access the nested data field
      _locations =
          locationList.map((json) => LocationModel.fromJson(json)).toList();

      notifyListeners();
    } catch (e) {
      debugPrint("Fetch Locations Error: $e");
    }
  }

  Future<void> addLocation(String name) async {
    try {
      List<Location> geo = await locationFromAddress(name);
      if (geo.isEmpty) throw Exception("Coordinates not found");

      double lat = geo.first.latitude;
      double lng = geo.first.longitude;

      final res = await dio.post(path: AppUrls.addLocation, data: {
        "address": name,
        "latitude": lat.toString(),
        "longitude": lng.toString(),
      });

      final newLoc = LocationModel.fromJson(res.data['data']);
      _locations.add(newLoc);
      notifyListeners();
    } catch (e) {
      debugPrint("Add Location Error: $e");
    }
  }

  Future<void> deleteLocation(String id) async {
    try {
      await dio.delete(path: "${AppUrls.deleteLocation}?locationId=$id");
      _locations.removeWhere((loc) => loc.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint("Delete Location Error: $e");
    }
  }
}
