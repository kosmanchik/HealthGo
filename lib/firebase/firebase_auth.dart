
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_go/firebase/firestore_service.dart';


class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreService _firestoreService = FirestoreService();

  Future<User?> SignUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _firestoreService.SetUserId(credential.user!.uid);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      HandleAuthException(e);
    }

    return null;
  }

  Future<User?> SignInWithEmailPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      _firestoreService.SetUserId(credential.user!.uid);
      return credential.user;
    } on FirebaseAuthException catch(e) {
      HandleAuthException(e);
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