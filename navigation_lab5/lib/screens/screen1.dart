import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/screen_data_provider.dart';
import 'screen2.dart';

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _screenController = TextEditingController();
  DateTime? _selectedDate;

  int _selectedIndex = 0; 
  int _numScreens = 0; 

  // Fungsi untuk memperbarui jumlah screen berdasarkan input user
  void _updateNumScreens() {
    final int? newNumScreens = int.tryParse(_screenController.text);
    if (newNumScreens != null && newNumScreens > 0 && newNumScreens <= 500) {
      setState(() {
        _numScreens = newNumScreens;
      });
    } else if (newNumScreens != null && newNumScreens > 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Maksimal 500 screen!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Masukkan jumlah screen yang valid!")),
      );
    }
  }

  // Fungsi untuk membuka detail screen
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

  // Fungsi untuk menangani tab navigasi
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pass Data Example"),
      ),
      body: _selectedIndex == 0
          ? Padding(
              padding: const EdgeInsets.all(20.0),
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
            )
          : _selectedIndex == 1
              ? 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _screenController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Jumlah Screen yang Ingin Dibuat",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _updateNumScreens,
                    child: Text("Buat Screen"),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
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
                ],
                )

              : Center(
                  child: Text(
                    "Tab lain dapat ditambahkan di sini!",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Input Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Generated Screens',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
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
          duration: Duration(milliseconds: 5000),
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
