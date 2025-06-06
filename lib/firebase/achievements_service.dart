import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:health_go/firebase/firestore_service.dart';

class AchievementsService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final String _userId = FirestoreService.GetUserId(); 

  static Future InitAchievements() async {
    final achievementsRef = _firestore.collection('achievements');

    final existingAchievements = await achievementsRef.get();
    if (existingAchievements.docs.isNotEmpty) 
      return;

    final defaultAchievements = [
    {
      'title': 'Первые шаги',
      'description': 'Закончить свою первую тренировку',
      'icon': 'assets/images/achievement_first.png',
      'score-threshold': 0,
      'day-streak-threshold': 1,
      'order': 1
    },
    {
      'title': 'Постоянство',
      'description': 'Тренироваться на протяжении 7 дней',
      'icon': 'assets/images/achievement_second.png',
      'score-threshold': 0,
      'day-streak-threshold': 7,
      'order': 2
    },
    {
      'title': 'Наращиваем темп',
      'description': 'Набрать 100 очков',
      'icon': 'assets/images/achievement_third.png',
      'score-threshold': 100,
      'day-streak-threshold': 0,
      'order': 3
    },
    {
      'title': 'Рекорд',
      'description': 'Набрать 500 очков',
      'icon': 'assets/images/achievement_fourth.png',
      'score-threshold': 500,
      'day-streak-threshold': 0,
      'order': 4
    }
  ];
    final batch = FirebaseFirestore.instance.batch();
    
    for (final achievement in defaultAchievements) {
      final docRef = achievementsRef.doc();
      batch.set(docRef, achievement);
    }
    await batch.commit();
  }

  static Future InitUserAchievements() async {
    final userAchievementsRef = FirebaseFirestore.instance.collection('userAchievements');
    
    final existingAchievements = await userAchievementsRef
        .where('userId', isEqualTo: _userId)
        .get();
    
    if (existingAchievements.docs.isNotEmpty) return;
    
    final achievements = await FirebaseFirestore.instance
        .collection('achievements')
        .get();
  }

  static Future<bool> CheckAchievements(String uid, score, dayStreak) async {
    var result = false;
    final achievements = await _firestore
      .collection('achievements')
      .get();
    
    final userAchievements = await _firestore
      .collection('userAchievements')
      .where('userId', isEqualTo: _userId)
      .get();

    final unlockedAchievementIds = userAchievements.docs
      .map((doc) => doc['achievementId'])
      .toSet();

    final userData = await FirestoreService.GetUserData();
    
    for (final achievement in achievements.docs) {
      final achievementData = achievement.data();
      
      if (!unlockedAchievementIds.contains(achievementData['order']) 
        && userData['score'] >= achievementData['score-threshold'] 
        && userData['day-streak'] >= achievementData['day-streak-threshold']) {

          final achievementId = achievementData['order'];
          final achievementTittle = achievementData['title'];
          final achievementDescription = achievementData['description'];
          final achievementIcon = achievementData['icon'];

          await _firestore
            .collection('userAchievements')
            .doc('${_userId}_$achievementId')
            .set({
              'userId': _userId,
              'achievementId': achievementId,
              'unlockedAt': FieldValue.serverTimestamp(),
              'title': achievementTittle,
              'description': achievementDescription,
              'icon': achievementIcon,
            });
          FirestoreService.UpdateScore(50);
          result = true;
      }
    }
    return result;
  }
}