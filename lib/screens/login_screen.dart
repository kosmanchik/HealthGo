import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_go/firebase/firebase_auth_service.dart';
import 'package:health_go/screens/main_screen.dart';
import 'package:health_go/screens/train_choice.dart';
import 'package:health_go/supportive_widgets/input_textbox.dart';
import 'package:health_go/supportive_widgets/registration_text.dart';
import 'package:health_go/user/preferences.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
        height: 300.h,
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
              child: Center(child: Text("Вход", style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                ))
              ),
            ),
            SizedBox(height: 11),
            RegistrationText("Введите свои данные", 187.w, 30.h),

            InputTextBox("Ivan@gmail.com", 262.w, 40.h, _emailController, false),
            SizedBox(height: 20),
            InputTextBox("Пароль", 262.w, 40.h, _passwordController, true),

            SizedBox(height: 30.h),
            Container( 
                  margin: EdgeInsets.only(left: 150.w),
                  child:
                    ElevatedButton(
                      onPressed: () => showDialog(
                        context: context, 
                        builder: (context) => AlertDialog(
                          title: Text("Войти?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Нет")),
                            TextButton(
                              onPressed: SignIn,
                              child: Text("Да")
                            ),
                          ]
                        )
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1E1E1E),
                        foregroundColor: Color(0xFFF5F5F5),
                        minimumSize: Size(120.w, 32.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        )
                      ),
                      child: Text("Продолжить", style: TextStyle(fontSize: 14.0.sp))
                    ),
                ),
          ]
        )
      )
    ));
  }

  void SignIn() async{
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.SignInWithEmailPassword(email, password);

    if (user != null) {
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (context) => MainScreen()), 
        (route) => false
      );
    }
    UserPreferences.SetFirebaseRegistrated(true);
  }
}