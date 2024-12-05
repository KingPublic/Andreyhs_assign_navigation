import 'package:flutter/material.dart';

class GeneratedScreen extends StatefulWidget {
  final String title; // Title unik dari screen
  final String content; // Konten unik dari screen

  const GeneratedScreen({required this.title, required this.content});

  @override
  _GeneratedScreenState createState() => _GeneratedScreenState();
}

class _GeneratedScreenState extends State<GeneratedScreen> {
  int _currentIndex = 0; // Untuk melacak tab aktif
  int _numScreens = 1; // Default hanya satu screen
  final TextEditingController _screenController = TextEditingController();

  // Fungsi untuk mengubah jumlah screen berdasarkan input user
  void _updateNumScreens() {
    final int? newNumScreens = int.tryParse(_screenController.text);
    if (newNumScreens != null && newNumScreens > 0 && newNumScreens <= 100) {
      setState(() {
        _numScreens = newNumScreens;
      });
    } else if (newNumScreens != null && newNumScreens > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Maksimal 100 screen!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Masukkan jumlah screen yang valid!")),
      );
    }
  }

  // Fungsi untuk membuat screen baru dengan pesan selamat
  void _createNewScreen(int screenIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScreenDetail(
          screenNumber: screenIndex + 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
      ),
      body: Center(
        child: _currentIndex == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      widget.content,
                      key: ValueKey<String>(widget.content),
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _screenController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Jumlah Screen yang Ingin Dibuat",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _updateNumScreens,
                    child: Text("Buat Screen"),
                  ),
                  SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      "Jumlah Screen yang Akan Ditampilkan: $_numScreens",
                      key: ValueKey<int>(_numScreens),
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: _numScreens,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text("Screen #${index + 1}"),
                        subtitle: Text("Konten dari screen ${index + 1}"),
                        onTap: () => _createNewScreen(index),
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Generated Screens",
          ),
        ],
      ),
    );
  }
}

class ScreenDetail extends StatelessWidget {
  final int screenNumber;

  const ScreenDetail({required this.screenNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen $screenNumber"),
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: Text(
            "Selamat kamu membuat screen $screenNumber!",
            key: ValueKey<int>(screenNumber),
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
