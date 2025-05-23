import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static String _userId = "";

  Future SetUserId(String userId) async  => _userId = userId; 

  static Future SetBasicUserInfo(String name, String age) async {
    name.trim();
    age.trim();

    await _firestore.collection('users')
      .doc(_userId)
      .set({
        'name': name,
        'age': age,
        'day-streak': 0,
        'last-streak-update': DateTime.now().toString(),
      });
  }

  static Future UpdateDayStreak() async {
    var userData = await GetUserData();
    await _firestore.collection('users')
      .doc(_userId)
      .update({
        'day-streak': userData['day-streak'] + 1
      });
  }

  static Future ResetDayStreak() async {
    await _firestore.collection('users')
      .doc(_userId)
      .update({
        'day-streak': 0
      });
  }

  static Future<Map<String, dynamic>> GetUserData() async {
  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(_userId)
      .get();
  return doc.data() ?? {};
}
}