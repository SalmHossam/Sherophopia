import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'SearchViewModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'CategoryIcon.dart'; // Import the CategoryIcon widget

class SearchTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              Provider.of<SearchViewModel>(context, listen: false).search(value);
            },
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoryIcon(
                icon: Icons.local_hospital,
                label: 'Hospital',
                onTap: () {
                  // Handle tap for Hospital
                },
              ),
              CategoryIcon(
                icon: Icons.local_pharmacy,
                label: 'Pharmacy',
                onTap: () {
                  // Handle tap for Pharmacy
                },
              ),
              CategoryIcon(
                icon: Icons.person,
                label: 'Doctors',
                onTap: () {
                  // Handle tap for Doctors
                },
              ),
              CategoryIcon(
                icon: Icons.psychology,
                label: 'Therapist',
                onTap: () {
                  // Handle tap for Therapist
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Consumer<SearchViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (viewModel.error != null) {
                  return Center(child: Text('Error: ${viewModel.error}'));
                }
                return ListView.builder(
                  itemCount: viewModel.results.length,
                  itemBuilder: (context, index) {
                    final result = viewModel.results[index];
                    return ListTile(
                      title: Text(result['name']),
                      subtitle: Text(result['type']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapPage(
                              latitude: result['location'].latitude,
                              longitude: result['location'].longitude,
                              name: result['name'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}