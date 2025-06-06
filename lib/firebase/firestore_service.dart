import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_go/firebase/achievements_service.dart';
import 'package:health_go/screens/table_screen.dart';
import 'package:health_go/user/user.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static String _userId = "";
  static int _scoreUpdate = 10;

  static Future SetUserId(String userId) async  => _userId = userId; 
  static String GetUserId() => _userId; 

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
        'score': 0,
        'max-score': 0
      });
  }

  static Future UpdateScore(int scoreToAdd) async {
    var userData = await GetUserData();
    await _firestore.collection('users')
      .doc(_userId)
      .update({
        'score': userData['score'] + scoreToAdd
      });

    if (userData['score'] + scoreToAdd > userData['max-score']) {
      await _firestore.collection('users')
        .doc(_userId)
        .update( {
          'max-score': userData['score'] + scoreToAdd,
        });
    }
  }

  static Future UpdateDayStreak() async {
    var userData = await GetUserData();
    await _firestore.collection('users')
      .doc(_userId)
      .update({
        'day-streak': userData['day-streak'] + 1
      });
    await _firestore.collection('users')
      .doc(_userId)
      .update({
        'last-streak-update': DateTime.now().toString()
      });
  }

  static Future ResetDayStreak() async {
    await _firestore.collection('users')
      .doc(_userId)
      .update({
        'day-streak': 0,
        'score': 0,
      });
  }

  static Future<Map<String, dynamic>> GetUserData() async {
    final doc = await _firestore
        .collection('users')
        .doc(_userId)
        .get();
    return doc.data() ?? {};
  }

  static Stream<List<User>> GetUsersScore()  {
    return _firestore
        .collection('users')
        .snapshots().map((snapshot) {
          return snapshot.docs.map((doc) => User.fromFirestore(doc)).toList();
        });
  }

  static Future<String> GetUserScore() async {
    final data = await GetUserData();
    return data['score'].toString();
  }

  static Future<String> GetUserMaxScore() async {
    final data = await GetUserData();
    return data['max-score'].toString();
  }

  static void ResetUserScore() async {
    final data = await GetUserData();
    data['score'] = 0;
  }
}