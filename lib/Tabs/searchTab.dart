import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherophopia/Models/SearchViewModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import '../Widgets/CategoryIcon.dart';

void map(String query) async {
  final url = 'https://www.google.com/maps/search/?api=1&query=$query';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// Helper function to format JSON
String formatJson(Map<String, dynamic> json) {
  return json.entries.map((e) => "${e.key}: ${e.value}").join('\n');
}

class SearchTab extends StatelessWidget {
  static const String routeName = "SearchScreen";

  @override
  Widget build(BuildContext context) {
    final searchViewModel = Provider.of<SearchViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Color.fromRGBO(72, 132, 151, 1),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                searchViewModel.updateSearchQuery(value);
              },
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryIcon(
                icon: Icons.local_hospital,
                label: 'Hospital',
                onTap: () {
                  map('psychiatric hospital near me');
                },
              ),
              CategoryIcon(
                icon: Icons.local_pharmacy,
                label: 'Pharmacy',
                onTap: () {
                  map('pharmacy near me');
                },
              ),
              CategoryIcon(
                icon: Icons.medical_services_outlined,
                label: 'Doctor',
                onTap: () {
                  map('psychiatrists near me');
                },
              ),
              CategoryIcon(
                icon: Icons.person,
                label: 'Therapist',
                onTap: () {
                  map('therapist near me');
                },
              ),
            ],
          ),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: searchViewModel.searchResults.length,
              itemBuilder: (context, index) {
                var searchResult = searchViewModel.searchResults[index];
                String displayText;

                // Check if searchResult is a Map<String, dynamic>
                if (searchResult is Map<String, dynamic>) {
                  displayText = formatJson(searchResult);
                } else {
                  displayText = searchResult.toString();
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(displayText),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
