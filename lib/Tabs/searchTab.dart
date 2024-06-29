import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/SearchViewModel.dart';
import '../Widgets/CategoryIcon.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'your_app_path/viewmodels/search_viewmodel.dart';

class SearchTab extends StatelessWidget {
  static const String routeName="SearchScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CategoryIcon(
                  icon: Icons.local_hospital,
                  label: 'Hospital',
                  onTap: () => Provider.of<SearchViewModel>(context, listen: false).setCategory('hospital'),
                ),
                CategoryIcon(
                  icon: Icons.local_pharmacy,
                  label: 'Pharmacy',
                  onTap: () => Provider.of<SearchViewModel>(context, listen: false).setCategory('pharmacy'),
                ),
                CategoryIcon(
                  icon: Icons.person,
                  label: 'Doctors',
                  onTap: () => Provider.of<SearchViewModel>(context, listen: false).setCategory('doctor'),
                ),
                CategoryIcon(
                  icon: Icons.accessibility_new,
                  label: 'Therapist',
                  onTap: () => Provider.of<SearchViewModel>(context, listen: false).setCategory('therapist'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


