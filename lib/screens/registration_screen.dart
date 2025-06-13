import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_go/firebase/firestore_service.dart';
import 'package:health_go/screens/goal_screen.dart';
import 'package:health_go/screens/login_screen.dart';
import 'package:health_go/supportive_widgets/input_textbox.dart';
import 'package:health_go/supportive_widgets/registration_text.dart';
import 'package:health_go/firebase/firebase_auth_service.dart';
import 'package:health_go/user/preferences.dart';

class RegistrationScreen extends StatefulWidget{
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFDED8E0),
          boxShadow: [ 
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 6,
              blurRadius: 12,
              offset: Offset(0, 8),
            )]
          ),        
        height: 510.h,
        width: 306.w,
       
        child: Column(
          children: [
            Container(
              height: 53.h,
              width: 240.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFFFFFFF),
              ),
              margin: const EdgeInsets.only(top: 14),
              child: Center(child: Text("Регистрация", style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                ))
              ),
            ),

            SizedBox(height: 11.h),

            RegistrationText("Введите свои данные", 187.w, 30.h),

            InputTextBox("Ваше имя", 220.w, 40.h, _usernameController, false),
            SizedBox(height: 20),
            InputTextBox("Ваш возраст", 220.w, 40.h, _ageController, false),
            SizedBox(height: 35),

            RegistrationText("Введите электронную почту", 251.w, 30.h),

            InputTextBox("Ivan@gmail.com", 262.w, 40.h, _emailController, false),
            SizedBox(height: 20),
            InputTextBox("Пароль", 262.w, 40.h, _passwordController, true),

            SizedBox(height: 79.h),

            Row(
              children: [
                TextButton(
                  onPressed: () => 
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => LoginScreen())
                    ), 
                  child: Text("Уже есть аккаунт?", style: TextStyle(fontSize: 14.0.sp))
                ),
                Container( 
                  margin: EdgeInsets.only(left: 20.w),
                  child:
                    ElevatedButton(
                      onPressed: () => showDialog(
                        context: context, 
                        builder: (context) => AlertDialog(
                          title: Text("Сохранить данные?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Нет")),
                            TextButton(
                              onPressed: SignUp,
                              child: Text("Да")
                            ),
                          ]
                        )
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1E1E1E),
                        foregroundColor: Color(0xFFF5F5F5),
                        minimumSize: Size(114.w, 32.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        )
                      ),
                      child: Text("Продолжить", style: TextStyle(fontSize: 14.0.sp))
                    ),
                ),
                
              ]
            )
          ],
        ),
      ),
    ));
  }

  void SignUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String name = _usernameController.text;
    String age = _ageController.text;

    User? user = await _auth.SignUpWithEmailPassword(email, password);

    if (user != null && name != "" && age != "") {
      FirestoreService.SetBasicUserInfo(name, age);
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (context) => GoalScreen()), 
        (route) => false
      );
      UserPreferences.SetFirebaseRegistrated(true);
    }
    else {
      print("Ошибка авторизации в registration_screen");
    }
  }
}