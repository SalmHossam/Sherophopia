import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sherophopia/Models/SearchViewModel.dart';

class SearchViewModel extends ChangeNotifier {
  String _category = 'hospital';
  String get category => _category;

  void setCategory(String category) {
    _category = category;
    notifyListeners();
    fetchNearbyPlaces();
  }

  Future<void> searchPlaces(String query) async {
    // Implement search logic here
    // Example Firestore search logic:
    var firestore;
    var result = await firestore.instance
        .collection('places')
        .where('name', isGreaterThanOrEqualTo: query)
        .get();

    // Handle the result
    print('Found ${result.docs.length} places');
  }

  Future<void> fetchNearbyPlaces() async {
    // Example Firestore fetch logic:
    var firestore;
    var result = await firestore.instance
        .collection('places')
        .where('category', isEqualTo: _category)
        .get();

    // Handle the result
    print('Found ${result.docs.length} places in category $_category');
  }
}
