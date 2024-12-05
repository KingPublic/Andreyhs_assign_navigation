import 'package:flutter/foundation.dart';

class ScreenDataProvider with ChangeNotifier {
  String _name = '';
  String _job = '';
  DateTime _studyDate = DateTime.now();

  String get name => _name;
  String get job => _job;
  DateTime get studyDate => _studyDate;

  void setData({required String name, required String job, required DateTime studyDate}) {
    _name = name;
    _job = job;
    _studyDate = studyDate;
    notifyListeners();
  }
}
