import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? error;
  List<Map<String, dynamic>> results = [];

  Future<void> search(String query) async {
    isLoading = true;
    error = null;
    results = [];
    notifyListeners();

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('medical_professionals')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      results = querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
