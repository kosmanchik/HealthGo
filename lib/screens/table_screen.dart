import 'package:flutter/material.dart';
import 'package:health_go/firebase/firestore_service.dart';
import 'package:health_go/user/user.dart';

class RatingTable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TableScreenState();
  
}

class _TableScreenState extends State<RatingTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<User>>(
        stream: FirestoreService.GetUsersScore(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Ошибка: ${snapshot.error}');
          if (!snapshot.hasData) return CircularProgressIndicator();

          List<User> users = snapshot.data!;
          users.sort((a, b) => b.score.compareTo(a.score));

          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height * 0.5,
                  ),
                  child: DataTable(
                    columns: [ 
                      DataColumn(label: Text("Имя")),
                      DataColumn(label: Text("Очки"))
                    ], 
                    rows: users.map((users) {
                      return DataRow(cells: [
                        DataCell(Text(users.name)),
                        DataCell(Text(users.score.toString())),
                      ]);
                    }).toList(),
                  )
              )],
              ),
            ),
          );
        }    
    ));
  }
}
