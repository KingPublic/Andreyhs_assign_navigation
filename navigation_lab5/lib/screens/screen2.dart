import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/screen_data_provider.dart';
import 'screen3.dart';

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ScreenDataProvider>(context);
    final int daysUntilStudy =
        dataProvider.studyDate.difference(DateTime.now()).inDays;

    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 2"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed: () {
            Navigator.pop(context);  
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama: ${dataProvider.name}"),
            Text("Pekerjaan: ${dataProvider.job}"),
            Text("Tanggal Kuliah: ${dataProvider.studyDate.toLocal()}".split(' ')[0]),
            SizedBox(height: 20),
            Text(
              "Berapa hari lagi kuliah: $daysUntilStudy hari lagi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen3()),
                  );
                },
                child: Text("Lanjutkan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
