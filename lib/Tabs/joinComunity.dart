import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sherophopia/DoctorTabs/manageRequestScreen.dart'; // Import ManageRequestsScreen

class JoinCommunityScreen extends StatefulWidget {
  static String routeName = "join";

  @override
  _JoinCommunityScreenState createState() => _JoinCommunityScreenState();
}

class _JoinCommunityScreenState extends State<JoinCommunityScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _usernameController = TextEditingController();

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _requestToJoinCommunity(String communityId) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('communities').doc(communityId).update({
          'requests': FieldValue.arrayUnion([user.email]),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request sent successfully!')),
        );

        // Show bottom sheet to get username
        _showUsernameBottomSheet(communityId);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send request: $e')),
        );
      }
    }
  }

  void _showUsernameBottomSheet(String communityId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Enter your username:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String username = _usernameController.text.trim();
                  if (username.isNotEmpty) {
                    Navigator.pop(context); // Close the bottom sheet
                    _handleUsername(username, communityId);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter your username!')),
                    );
                  }
                },
                child: Text('Send'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleUsername(String username, String communityId) {
    // Do whatever you need with the username
    print('Username entered: $username');
    // Instantiate ManageRequestsScreen directly and navigate to it
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManageRequestsScreen(
          communityId: communityId,
          username: username,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(72, 132, 151, 1),
        title: Text('Join Community'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('communities').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var communities = snapshot.data!.docs;
          return ListView.builder(
            itemCount: communities.length,
            itemBuilder: (context, index) {
              var community = communities[index];
              var communityData = community.data() as Map<String, dynamic>?;

              var link = communityData != null && communityData.containsKey('link') ? communityData['link'] : null;
              var acceptedRequests = communityData != null && communityData.containsKey('acceptedRequests')
                  ? communityData['acceptedRequests']
                  : null;

              User? user = _auth.currentUser; // Fetch current user
              bool requestAccepted = acceptedRequests != null && acceptedRequests[user!.email] != null;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  title: Text(communityData != null ? communityData['symptomName'] : 'Unknown'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(communityData != null ? communityData['description'] : 'No description available'),
                      SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          if (link != null && link.isNotEmpty) {
                            _launchURL(link);
                          }
                        },
                        child: Text(
                          requestAccepted ? link ?? 'No meeting link provided' : 'Request pending...',
                          style: TextStyle(
                            color: requestAccepted ? Colors.blue : Colors.grey,
                            decoration: requestAccepted ? TextDecoration.underline : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(72, 132, 151, 1))),
                    onPressed: () {
                      _requestToJoinCommunity(community.id);
                    },
                    child: Text('Join'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
