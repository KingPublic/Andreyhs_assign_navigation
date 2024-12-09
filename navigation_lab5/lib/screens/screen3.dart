import 'package:flutter/material.dart';
import 'package:navigation_lab5/screens/screen1.dart';
import 'package:provider/provider.dart';
import '/screen_data_provider.dart';

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ScreenDataProvider>(context);
    final int daysUntilStudy =
        dataProvider.studyDate.difference(DateTime.now()).inDays;

    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 3"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),  
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Screen1()));  // Kembali ke Screen1
          },
        ),
      ),

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
