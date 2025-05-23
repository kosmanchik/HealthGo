import 'package:flutter/material.dart';
import 'package:health_go/firebase/firestore_service.dart';
import 'package:health_go/screens/train_choice.dart';
import 'package:health_go/user/preferences.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _dayStreak = 0;

  @override
  void initState() {
    super.initState();
    UpdateDayStreak();
  }

  void UpdateDayStreak() async {
    var isFirebaseRegistred = UserPreferences.GetFirebaseRegistrated() ?? false;
    if (!isFirebaseRegistred) return;

    var userData = await FirestoreService.GetUserData();
    var date = DateTime.now();

    if (date.difference(DateTime.parse(userData['last-streak-update'])).inDays > 1) {
      FirestoreService.ResetDayStreak();
        setState(() {
        _dayStreak = 0;
      });
      return;
    }

    setState(() {
      _dayStreak = userData['day-streak'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFF3EDF7), automaticallyImplyLeading: false),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFAE1FA),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [ 
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                )]
            ),
            width: 240.0,
            height: 182.0,
            margin: EdgeInsets.only(left: 16, top: 189),
            child: Center(
              child: GetDayStreakData(),
            ),
          ),

          SizedBox(height: 20),

          InkWell( 
            child: Container(
              height: 131,
              width: 233,
              margin: EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/gym.jpg"), fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(child: Text(
                "Начать\nтренировку",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              )),
            ),
            onTap: () => Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => TrainChooseScreen())
            ),
          )
        ],
      ),
    );
  }
  
  Widget GetDayStreakData() {
    if (_dayStreak > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 24),
          Icon(Icons.auto_graph, size: 40),
          SizedBox(height: 24),
          Text(_dayStreak.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 28,
            ),
            textAlign: TextAlign.center,  
          ),
          SizedBox(height: 4),
          RichText(
            text: TextSpan(
              text: "День!",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              children: const <TextSpan>[
                TextSpan(
                  text: "\nВы смело идете к цели!",
                  style: TextStyle(fontWeight: FontWeight.w400),
                )
              ]
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 24),
        Icon(Icons.watch_outlined, size: 40),
        SizedBox(height: 24),
        Text(
          "Самое время!",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
          )
        ),
        Text(
          "Начни уже сегодня свой\nпуть к лучшей версии себя",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}