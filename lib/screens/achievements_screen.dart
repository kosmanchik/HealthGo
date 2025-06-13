import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_go/firebase/achievements_service.dart';
import 'package:health_go/firebase/firestore_service.dart';
import 'package:health_go/supportive_widgets/achievement_widget.dart';
import 'package:health_go/supportive_widgets/image_section.dart';

class AchievementsScreen extends StatefulWidget {
  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  List<String> ImagesPaths = ['assets/images/achievement_lock.png', 
    'assets/images/achievement_lock.png', 
    'assets/images/achievement_lock.png', 
    'assets/images/achievement_lock.png']; 

  @override void initState() {
    super.initState();
    GetUpdateImages();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFF3EDF7)),
      body: Column(
        spacing: 50.h,
        children: [
          SizedBox(height: 30.h),
          AchievementWidget(ImageSection(ImagesPaths[0]), "Первые шаги", "Закончить свою первую тренировку"),
          AchievementWidget(ImageSection(ImagesPaths[1]), "Постоянство", "Тренироваться на протяжении 7 дней"),
          AchievementWidget(ImageSection(ImagesPaths[2]), "Наращиваем темп", "Набрать 100 очков"),
          AchievementWidget(ImageSection(ImagesPaths[3]), "Рекорд", "Набрать 500 очков"),
        ],
      ),
    );
  }
  
  void GetUpdateImages() async {
    final docs = await FirebaseFirestore.instance
      .collection('userAchievements')
      .where('userId', isEqualTo: FirestoreService.GetUserId())
      .get();

    for (final achievement in docs.docs){
      final achievementData = achievement.data();
      setState(() {
        ImagesPaths[achievementData['achievementId'] - 1] = achievementData['icon'];
      });      
    }
  }
}