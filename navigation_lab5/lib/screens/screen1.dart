import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '/screen_data_provider.dart';
import 'screen2.dart';
import '/generated_screen.dart'; 

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  DateTime? _selectedDate;
  int _selectedIndex = 0; // Untuk Bottom Navigation

  static const List<Widget> _widgetOptions = <Widget>[
    // Home
    Center(child: Text('Home Screen', style: TextStyle(fontSize: 24))),
    // Screen2
    Center(child: Text('Screen 2', style: TextStyle(fontSize: 24))),
    // GeneratedScreen
    GeneratedScreen(title: "Generated Screen", content: "Content of generated screen"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen 1")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: _jobController,
              decoration: InputDecoration(labelText: "Pekerjaan"),
            ),
            SizedBox(height: 16),
            Text(
              _selectedDate == null
                  ? "Tanggal Kuliah: Belum dipilih"
                  : "Tanggal Kuliah: ${_selectedDate!.toLocal()}".split(' ')[0],
            ),
            ElevatedButton(
              onPressed: () async {
                _selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                setState(() {});
              },
              child: Text("Pilih Tanggal Kuliah"),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                      _jobController.text.isNotEmpty &&
                      _selectedDate != null) {
                    Provider.of<ScreenDataProvider>(context, listen: false)
                        .setData(
                      name: _nameController.text,
                      job: _jobController.text,
                      studyDate: _selectedDate!,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Screen2()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Harap isi semua data!")),
                    );
                  }
                },
                child: Text("Lanjutkan"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Screen 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Generated Screen',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (indeX){
          setState(() {
            _selectedIndex = indeX;

          });
          // Menambahkan navigasi eksplisit ke GeneratedScreen
          if (indeX == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GeneratedScreen(
                  title: "Generated Screen",
                  content: "Content of generated screen",
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
