
# Flutter Dynamic Screen Generator

Proyek ini bertujuan untuk memungkinkan pengguna membuat beberapa screen secara dinamis di aplikasi Flutter berdasarkan input jumlah screen yang diinginkan. Setiap screen yang dibuat akan memiliki konten unik dengan pesan "Selamat kamu membuat screen #".

## Struktur Folder

```
lib/
│
├── screens/
│   ├── screen_1.dart
│   ├── screen_2.dart
│   ├── screen_3.dart
│   └── generated_screen.dart
└── main.dart
```

## Deskripsi Fitur

1. **Screen 1, Screen 2, Screen 3**: 
   - Tiga file screen (screen_1.dart, screen_2.dart, dan screen_3.dart) masing-masing menampilkan pesan selamat yang berbeda: "Selamat kamu membuat screen 1", "Selamat kamu membuat screen 2", dan "Selamat kamu membuat screen 3".
   
2. **GeneratedScreen**:
   - File `generated_screen.dart` menangani logika untuk membuat dan menampilkan screen dinamis sesuai dengan input dari pengguna.
   - Pengguna dapat memasukkan jumlah screen yang ingin dibuat, dan aplikasi akan menghasilkan screen tersebut berdasarkan jumlah yang dimasukkan.

3. **Navigasi & Bottom Navigation**:
   - Aplikasi memiliki bottom navigation bar untuk berpindah antar halaman.
   - Screen yang dihasilkan oleh pengguna dapat dipilih, dan aplikasi akan mengarahkan pengguna ke screen baru yang menampilkan pesan terkait.

## Langkah-langkah Pembuatan

### 1. Membuat Folder Screens

Buat folder baru di dalam direktori `lib/` dengan nama `screens`. Di dalam folder ini, buat tiga file untuk `screen_1.dart`, `screen_2.dart`, dan `screen_3.dart`.

**Contoh untuk `screen_1.dart`:**

```dart
import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen 1")),
      body: Center(
        child: Text("Selamat kamu membuat screen 1!", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
```

Ulangi untuk `screen_2.dart` dan `screen_3.dart`, dengan mengganti nomor screen yang ditampilkan di teks.

### 2. Membuat `generated_screen.dart`

File `generated_screen.dart` akan menangani logika untuk membuat screen dinamis berdasarkan input pengguna. Berikut adalah kode lengkap untuk `generated_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'screen_1.dart';
import 'screen_2.dart';
import 'screen_3.dart';

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
    Widget newScreen;
    if (screenIndex == 0) {
      newScreen = Screen1();
    } else if (screenIndex == 1) {
      newScreen = Screen2();
    } else {
      newScreen = Screen3();
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => newScreen),
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
```

### 3. Menambahkan Logika Navigasi dan Dynamic Screen

File ini berfungsi untuk menangani input dari pengguna yang menentukan jumlah screen yang ingin dibuat. Setiap screen akan memiliki nomor yang unik, dan navigasi ke screen baru akan terjadi ketika pengguna menekan salah satu item di `ListView`.

### 4. File `main.dart`

Terakhir, di file `main.dart`, Anda perlu menambahkan routing atau pemanggilan awal untuk halaman `GeneratedScreen`.

```dart
import 'package:flutter/material.dart';
import 'screens/generated_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Screen Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GeneratedScreen(
        title: 'Dynamic Screen Generator',
        content: 'Masukkan jumlah screen yang ingin dibuat',
      ),
    );
  }
}
```

## Instalasi

1. **Clone Repository**: Clone atau download repositori ini ke komputer Anda.
2. **Install Dependencies**: Jalankan `flutter pub get` untuk menginstal semua dependencies yang dibutuhkan.
3. **Run Aplikasi**: Jalankan aplikasi menggunakan `flutter run` di terminal.

## Lisensi

MIT License. Silakan cek file `LICENSE` untuk detail lebih lanjut.
```

### Penjelasan Struktur dan Langkah-langkah:
1. **Folder `screens`**: Folder ini berisi file `screen_1.dart`, `screen_2.dart`, `screen_3.dart`, dan `generated_screen.dart`.
2. **Navigasi Dinamis**: File `generated_screen.dart` menangani pembuatan screen dinamis berdasarkan input pengguna dan menavigasi ke screen baru dengan pesan yang sesuai.
3. **Membatasi Jumlah Screen**: Pengguna hanya dapat membuat hingga 100 screen dengan validasi input.

Dengan petunjuk ini, Anda dapat mengembangkan proyek dan mengelola beberapa screen dinamis di aplikasi Flutter.