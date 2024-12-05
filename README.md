
# Flutter Dynamic Screen Generator

Proyek ini bertujuan untuk memungkinkan pengguna membuat beberapa screen secara dinamis di aplikasi Flutter berdasarkan input jumlah screen yang diinginkan. Setiap screen yang dibuat akan memiliki konten unik dengan pesan "Selamat kamu membuat screen #".

## Struktur Folder

```
lib/
│   ├── generated_screen.dart
│   ├── screen_data_provider.dart
│   └── main.dart
└── screens/
    ├── screen_1.dart
    ├── screen_2.dart
    ├── screen_3.dart

```

## Deskripsi Fitur

1. **Screen 1, Screen 2, Screen 3**: 
   - Tiga file screen (screen_1.dart, screen_2.dart, dan screen_3.dart), screen_1.dart menampilkan user input untuk pass data nya dan bottom navigation ke fitur generated_screen.dart.
   screen_2.dart akan receive data dari inputan di screen 1 dan menampilkan berapa hari lagi akan kuliah.
   screen_3.dart akan receive data dari inputan juga dan menampilkan selamat kamu akan berkuliah dalam $hari lagi
   
2. **GeneratedScreen**:
   - File `generated_screen.dart` menangani logika untuk membuat dan menampilkan screen dinamis sesuai dengan input dari pengguna.
   - Pengguna dapat memasukkan jumlah screen yang ingin dibuat, dan aplikasi akan menghasilkan screen tersebut berdasarkan jumlah yang dimasukkan.

3. **Navigasi & Bottom Navigation**:
   - Aplikasi memiliki bottom navigation bar untuk berpindah antar halaman.
   - Screen yang dihasilkan oleh pengguna dapat dipilih, dan aplikasi akan mengarahkan pengguna ke screen baru yang menampilkan pesan terkait. - pada generated_screen.dart

## Langkah-langkah Pembuatan

### 1. Membuat Folder Screens

Buat folder baru di dalam direktori `lib/` dengan nama `screens`. Di dalam folder ini, buat tiga file untuk `screen_1.dart`, `screen_2.dart`, dan `screen_3.dart`.

**Contoh untuk `screen_1.dart`:**

```dart
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

```

### 2. Membuat `generated_screen.dart`

File `generated_screen.dart` akan menangani logika untuk membuat screen dinamis berdasarkan input pengguna. Berikut adalah kode lengkap untuk `generated_screen.dart`:

```dart
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
                  Text(
                    widget.content,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
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
                  Text("Jumlah Screen yang Akan Ditampilkan: $_numScreens"),
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
                        onTap: () => _createNewScreen(index), // Pindah ke screen baru
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
        child: Text(
          "Selamat kamu membuat screen $screenNumber!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

```

### 3. Menambahkan Logika Navigasi dan Dynamic Screen

File ini berfungsi untuk menangani input dari pengguna yang menentukan jumlah screen yang ingin dibuat. Setiap screen akan memiliki nomor yang unik, dan navigasi ke screen baru akan terjadi ketika pengguna menekan salah satu item di `ListView`.

### 4. File `main.dart`

Terakhir, di file `main.dart`, Anda perlu menambahkan routing atau pemanggilan awal untuk halaman `GeneratedScreen`.

```dart
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

```

## Instalasi

1. **Clone Repository**: Clone atau download repositori ini ke komputer Anda.
2. **Install Dependencies**: Jalankan `flutter pub get` untuk menginstal semua dependencies yang dibutuhkan.
3. **Run Aplikasi**: Jalankan aplikasi menggunakan `flutter run` di terminal.

## Penjelasan singkat
```

### Penjelasan Struktur dan Langkah-langkah:
1. **Folder `screens`**: Folder ini berisi file `screen_1.dart`, `screen_2.dart`, `screen_3.dart`.
2. **Navigasi Dinamis**: File `generated_screen.dart` menangani pembuatan screen dinamis berdasarkan input pengguna dan menavigasi ke screen baru dengan pesan yang sesuai.
3. **Membatasi Jumlah Screen**: Pengguna hanya dapat membuat hingga 100 screen dengan validasi input.

Dengan petunjuk ini, Anda dapat mengembangkan proyek dan mengelola beberapa screen dinamis di aplikasi Flutter.