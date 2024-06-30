import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ManageRequestsScreen extends StatefulWidget {
  static const String routeName = "manage";

  final String ?communityId; // Add communityId as a parameter
  final String ?username; // Add username as a parameter

  ManageRequestsScreen({
    this.communityId,
     this.username,
  }); // Constructor with communityId and username parameters

  @override
  _ManageRequestsScreenState createState() => _ManageRequestsScreenState();
}

class _ManageRequestsScreenState extends State<ManageRequestsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _currentUserEmail;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserEmail();
  }

  void _fetchCurrentUserEmail() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _currentUserEmail = user.email;
      });
    } else {
      setState(() {
        _currentUserEmail = null;
      });
      print('User not authenticated.');
      // Optionally, handle the case where user is not authenticated, e.g., redirect to login screen
    }
  }

  void acceptRequest(String requestId, String communityId, String email) async {
    try {
      DocumentReference communityDoc = _firestore.collection('communities').doc(communityId);

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot communitySnapshot = await transaction.get(communityDoc);
        List requests = List.from(communitySnapshot['requests']);
        requests.remove(requestId);

        List members = List.from(communitySnapshot['members']);
        members.add(email);

        transaction.update(communityDoc, {
          'requests': requests,
          'members': members,
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request accepted for $email!')),
      );
    } catch (e) {
      print('Error accepting request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error accepting request: $e')),
      );
    }
  }

  void declineRequest(String requestId, String communityId, String email) async {
    try {
      DocumentReference communityDoc = _firestore.collection('communities').doc(communityId);

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot communitySnapshot = await transaction.get(communityDoc);
        List requests = List.from(communitySnapshot['requests']);
        requests.remove(requestId);

        transaction.update(communityDoc, {
          'requests': requests,
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request declined for $email!')),
      );
    } catch (e) {
      print('Error declining request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error declining request: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUserEmail == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Manage Membership Requests'),
          backgroundColor: Color.fromRGBO(72, 132, 151, 1),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Membership Requests'),
        backgroundColor: Color.fromRGBO(72, 132, 151, 1),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('communities')
            .where('members', arrayContains: _currentUserEmail)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print('Firestore error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('You are not a member of any communities.'),
            );
          }

          var communities = snapshot.data!.docs;
          return ListView.builder(
            itemCount: communities.length,
            itemBuilder: (context, index) {
              var community = communities[index];
              var communityId = community.id;
              var communityData = community.data() as Map<String, dynamic>;
              var requests = List<String>.from(communityData['requests'] ?? []);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      communityData['communityName'] ?? 'Unknown',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  requests.isEmpty
                      ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('No membership requests.'),
                  )
                      : Column(
                    children: requests.map<Widget>((requestId) {
                      return FutureBuilder<DocumentSnapshot>(
                        future: _firestore.collection('users').doc(requestId).get(),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (userSnapshot.hasError) {
                            print('Firestore error: ${userSnapshot.error}');
                            return Center(child: Text('Error: ${userSnapshot.error}'));
                          }
                          if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text('Request not found.'),
                            );
                          }

                          var userData = userSnapshot.data!.data() as Map<String, dynamic>;

                          return Card(
                            elevation: 3,
                            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: ListTile(
                              title: Text(userData['name'] ?? 'Unknown'),
                              subtitle: Text(
                                userData['email'] ?? 'No email available',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.check),
                                    onPressed: () {
                                      acceptRequest(requestId, communityId, userData['email']);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      declineRequest(requestId, communityId, userData['email']);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
