import 'package:flutter/material.dart';
import 'package:ustaad/Models/get_nearby_tutor_model.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class GetTutorsProvider extends ChangeNotifier {
  final AppDio dio;
  GetTutorsProvider(BuildContext context) : dio = AppDio(context);

  List<TutorModel> _tutors = [];
  List<TutorModel> get tutors => _tutors;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchNearbyTutors(double latitude, double longitude) async {
    try {
      if (tutors.isEmpty) {
        _isLoading = true;
        notifyListeners();
      }

      final res = await dio.get(
        path: AppUrls.getTutor,
        queryParameters: {
          "latitude": latitude,
          "longitude": longitude,
          "radius": 100,
          "limit": 20,
          "offset": 0,
        },
      );

      final List data = res.data['data'];
      _tutors = data.map((e) => TutorModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Fetch Nearby Tutors Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
