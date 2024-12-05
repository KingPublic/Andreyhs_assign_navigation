import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/screen_data_provider.dart';

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ScreenDataProvider>(context);
    final int daysUntilStudy =
        dataProvider.studyDate.difference(DateTime.now()).inDays;

    return Scaffold(
      appBar: AppBar(title: Text("Screen 3")),
      body: Center(
        child: Text(
          "Selamat ${dataProvider.name}, Anda akan berkuliah lagi dalam $daysUntilStudy hari lagi.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
