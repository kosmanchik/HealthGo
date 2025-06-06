import 'package:flutter/material.dart';
import 'package:health_go/firebase/firestore_service.dart';
import 'package:health_go/screens/achievements_screen.dart';
import 'package:health_go/screens/table_screen.dart';
import 'package:health_go/screens/train_choice.dart';
import 'package:health_go/supportive_widgets/button.dart';
import 'package:health_go/supportive_widgets/button_icon.dart';
import 'package:health_go/user/preferences.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _dayStreak = 0;
  String _maxScore = "";
  String _currentScore = "";
  String _userName = "";

  @override
  void initState() {
    UpdateDayStreak();
    SetMaxScore();
    SetCurrentScore();
    SetUserName();
    super.initState();
  }

  void UpdateDayStreak() async {
    var isFirebaseRegistred = UserPreferences.GetFirebaseRegistrated() ?? false;
    if (!isFirebaseRegistred) return;

    var userData = await FirestoreService.GetUserData();
    var date = DateTime.now();

    if (date.difference(DateTime.parse(userData['last-streak-update'])).inDays > 1
      && date.difference(DateTime.parse(userData['last-streak-update'])).inDays != 0) {
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

  void SetMaxScore() async => _maxScore = await FirestoreService.GetUserMaxScore();
  
  void SetCurrentScore() async => _currentScore = await FirestoreService.GetUserScore();

  void SetUserName() async {
    var userData = await FirestoreService.GetUserData();
    _userName = userData['name'] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFF3EDF7), automaticallyImplyLeading: false),
      body: Column(
        spacing: 20.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          SizedBox(height: 20),

          Center(child: RichText(
            text: TextSpan(
              text: "Здравствуйте,\n",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 20,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "$_userName!",
                  style: const TextStyle(fontWeight: FontWeight.w400),
                )
              ]
            ),
            textAlign: TextAlign.center,
          )),
          Row(
            spacing: 20,
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
                margin: EdgeInsets.only(left: 16),
                child: Center(
                  child: GetDayStreakData(),
                ),
              ),

              Container(
                child: RichText(
                  text: TextSpan(
                    text: "Ваш рекорд\n",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "$_maxScore очков",
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )
                    ]
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
            ],
          ),
          
          Row(
            spacing: 20,
            children: [
              InkWell( 
                child: Container(
                  height: 131,
                  width: 240,
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
              ),

              RichText(
                text: TextSpan(
                  text: "Сейчас у вас\n",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "$_currentScore очков",
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    )
                  ]
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),

          Container(
            height: 100,
            width: 380,
            margin: EdgeInsets.only(left: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEADDFF),
                foregroundColor: Color(0xFF65558F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RatingTable())
              ), 
              child: Center(child: Text(
                  "Таблица Рейтинга",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                )
              ),
            )
          ),

          Container(
            height: 100,
            width: 380,
            margin: EdgeInsets.only(left: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEADDFF),
                foregroundColor: Color(0xFF65558F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AchievementsScreen())
              ), 
              child: Center(child: Text(
                  "Достижения",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                )
              ),
            )
          ),
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