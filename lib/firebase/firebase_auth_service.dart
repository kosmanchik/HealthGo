
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_go/firebase/achievements_service.dart';
import 'package:health_go/firebase/firestore_service.dart';


class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> SignUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirestoreService.SetUserId(credential.user!.uid);
      AchievementsService.InitAchievements();
      AchievementsService.InitUserAchievements();

      return credential.user;
    } on FirebaseAuthException catch (e) {
      HandleAuthException(e);
    }

    return null;
  }

  Future<User?> SignInWithEmailPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirestoreService.SetUserId(credential.user!.uid);
      AchievementsService.InitAchievements();
      
      await ChekAchievementsWhenAuth(credential);

      return credential.user;
    } on FirebaseAuthException catch(e) {
      HandleAuthException(e);
    }
  }

  Future<void> ChekAchievementsWhenAuth(UserCredential credential) async {
    var userDoc = await FirestoreService.GetUserData();
    
    if (userDoc != {}) {
      final score = userDoc['score'] ?? 0;
      final dayStreak = userDoc['day-streak'] ?? 0;
      await AchievementsService.CheckAchievements(credential.user!.uid, score, dayStreak);
    }
  }

  String HandleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Некорректный email адрес';
      case 'user-disabled':
        return 'Пользователь заблокирован';
      case 'user-not-found':
        return 'Пользователь не найден';
      case 'wrong-password':
        return 'Неверный пароль';
      case 'email-already-in-use':
        return 'Email уже используется';
      case 'operation-not-allowed':
        return 'Операция не разрешена';
      case 'weak-password':
        return 'Слишком слабый пароль';
      default:
        return 'Ошибка авторизации: ${e.message}';
    }
  }
}