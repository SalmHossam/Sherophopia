import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  String _searchQuery = '';
  List<Map<String, dynamic>> _searchResults = [];

  // Getters

  String get searchQuery => _searchQuery;
  List<Map<String, dynamic>> get searchResults => _searchResults;

  // Update the search query
  void updateSearchQuery(String query) {
    _searchQuery = query;
    _performSearchPharmacy();
    _performSearchHospital();
  }

  // Perform search operation
  void _performSearchPharmacy() async {
    if (_searchQuery.isEmpty) {
      _searchResults = [];
    } else {
      final snapshot = await FirebaseFirestore.instance
          .collection('Pharmacy')
          .where('name', isEqualTo: _searchQuery)
          .get();

      _searchResults = snapshot.docs.map((doc) => doc.data()).toList();
    }
    notifyListeners();
  }
void _performSearchHospital() async {
  if (_searchQuery.isEmpty) {
    _searchResults = [];
  } else {
    final snapshot = await FirebaseFirestore.instance
        .collection('hospital')
        .where('name', isEqualTo: _searchQuery)
        .get();

    _searchResults = snapshot.docs.map((doc) => doc.data()).toList();
  }
  notifyListeners();
}
}