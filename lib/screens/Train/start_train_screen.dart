import 'package:flutter/material.dart';
import 'package:health_go/firebase/firestore_service.dart';
import 'package:health_go/screens/Train/exercise_screen.dart';
import 'package:health_go/screens/main_screen.dart';
import 'package:health_go/screens/train_choice.dart';
import 'package:health_go/supportive_widgets/image_section.dart';
import 'package:health_go/screens/Train/train.dart';
import 'package:health_go/user/preferences.dart';

class StartTrainScreen extends StatelessWidget{
  final List<Widget> _exercisesList;

  StartTrainScreen(this._exercisesList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFF3EDF7), automaticallyImplyLeading: false),
      body: Center( child: Container(
        margin: EdgeInsets.only(top: 97, bottom: 157),
        width: 312,
        height: 352,
        decoration: BoxDecoration(
          color: Color(0xFFECE6F0),
          borderRadius: BorderRadius.circular(28)
        ),
        
        child: Container( 
          margin: EdgeInsets.only(right: 24, left: 24, top: 24), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Text(
                "Информация о тренировке",
                style: GetHeaderStyle()
              ),
              Text(
                "В тренировке присутствуют самые базовые упражнения на ноги и ягодицы. Напоминаем так же о том, как важно правильно выполнять упражнения, соблюдать правильное дыхание и следить за своим самочувствием! Желаем удачной тренировки!",
                style: GetMainTextStyle()
              ),

              Container( 
                margin: EdgeInsets.only(right: 24, top: 18),
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 32,
                  children: [

                    InkWell(
                      child: Text("Назад", style: GetClickTextStyle()),
                      onTap: () {
                        Navigator.pop(context); //Снимает данный экран с стэка и возвращается к предыдущему
                      },                  
                    ),

                    InkWell(
                      child: Text("Начать", style: GetClickTextStyle()),
                      onTap: () => NavigateTrainScreens(context, _exercisesList),                  
                    )
                  ],
                )
              )
            ],
          )
        )
      ))
    );
  }

  TextStyle GetMainTextStyle() {
    return TextStyle(
      color: Color(0xFF49454F),
      fontWeight: FontWeight.w400,
      fontSize: 14
    );
  }

  TextStyle GetHeaderStyle() {
    return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 24,
    );
  }

  TextStyle GetClickTextStyle() {
    return TextStyle(
      color: Color(0xFF65558F),
      fontWeight: FontWeight.w500,
      fontSize: 14
    );
  }
  
  void NavigateTrainScreens(BuildContext context, List<Widget> exercisesScreens) async { //перемещение по массиву с упражнениями
    for (var screen in exercisesScreens) {
      if (!context.mounted) 
        return;

      await Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => screen));
    }

    var isFirebaseRegistred = UserPreferences.GetFirebaseRegistrated() ?? false;
    if (!isFirebaseRegistred) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => TrainChooseScreen())
      );
      
      return;
    }

    var date = DateTime.now();
    var userData = await FirestoreService.GetUserData();

    if (date.difference(DateTime.parse(userData['last-streak-update'])).inDays == 1 
      || userData['day-streak'] == 0) {
      FirestoreService.UpdateDayStreak();
    }

    FirestoreService.UpdateScore();
    
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Поздравляем"),
        content: Text("Вы завершили тренировку!"),
        actions: [
          TextButton(
            onPressed: () =>  Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (context) => MainScreen())
            ), 
            child: Text("Перейти на начальный экран"))
        ],
      )
    );
  }
}