import 'package:cloud_firestore/cloud_firestore.dart';

class Community {
  final String communityId;
  final String name;
  final String description;

  Community({
    required this.communityId,
    required this.name,
    required this.description,
  });

  factory Community.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Community(
      communityId: snapshot.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
    );
  }
}
