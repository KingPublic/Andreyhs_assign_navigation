import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen_data_provider.dart';
import 'screens/screen1.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScreenDataProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pass Data Example',
      home: Screen1(),
    );
  }
}
