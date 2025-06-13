
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final int score;

  const User(this.name, this.score);

  factory User.fromFirestore(DocumentSnapshot  doc) {
    Map data = doc.data() as  Map<String, dynamic>;
    return User(doc['name'], doc['score']);
  }
}