
# Pass Data Example - Flutter Project

## **Deskripsi Proyek**
Proyek ini adalah aplikasi Flutter yang menggunakan **Provider** sebagai state management untuk berbagi data antar layar dan juga mendukung pembuatan layar dinamis. Proyek ini dirancang untuk mempelajari manajemen state dengan **ChangeNotifierProvider**, navigasi antar layar, serta pembuatan layar dinamis berdasarkan input pengguna.

---

## **Fitur Utama**
1. **Pengelolaan State dengan Provider**:
   - Data seperti nama, pekerjaan, dan tanggal disimpan di `ScreenDataProvider`.
   - Data otomatis diperbarui antar layar.

2. **Navigasi Multi-Screen**:
   - Memiliki beberapa layar untuk menginput dan menampilkan data.

3. **Pembuatan Screen Dinamis**:
   - Melalui `GeneratedScreen`, pengguna dapat membuat hingga 100 layar berdasarkan input mereka.
   - Tiap layar memiliki pesan unik yang disesuaikan.

4. **Animasikan UI**:
   - Menggunakan `AnimatedSwitcher` untuk memberikan transisi visual yang halus.

---

## **Alur Kerja Aplikasi**
1. **Manajemen Data dengan Provider**:
   - `ScreenDataProvider` mengelola data (`name`, `job`, `studyDate`) yang dapat diperbarui melalui layar input (Screen1).

2. **Navigasi Antar Layar**:
   - Aplikasi dimulai di `Screen1`, tempat pengguna memasukkan data.
   - Data yang dimasukkan diteruskan dan ditampilkan di layar lain seperti `Screen2` dan `Screen3`.

3. **Generated Screens**:
   - Melalui `GeneratedScreen`, pengguna dapat menentukan jumlah layar yang ingin dibuat.
   - Daftar layar ditampilkan di tab kedua, dan pengguna dapat membuka detail dari layar tersebut.

---

## **Penjelasan File**
### **1. `screen_data_provider.dart`**
- **Tujuan**: Mengelola data (nama, pekerjaan, tanggal studi) dan memberitahu widget untuk memperbarui UI jika data berubah.
- **Properti**:
  - `_name`, `_job`, `_studyDate`: Data yang dikelola.
- **Metode**:
  - `setData()`: Memperbarui data dan memanggil `notifyListeners()`.

### **2. `main.dart`**
- **Tujuan**: Menginisialisasi aplikasi Flutter dan menyediakan `ScreenDataProvider` menggunakan `MultiProvider`.

### **3. `screen1.dart`, `screen2.dart`, `screen3.dart`**
- **Tujuan**:
  - `Screen1`: Layar untuk menginput data.
  - `Screen2` dan `Screen3`: Layar untuk menampilkan data yang dikelola oleh Provider.

### **4. `generated_screen function`**
- **Tujuan**: Mendukung pembuatan layar dinamis berdasarkan input pengguna.
- **Fitur**:
  - Input jumlah layar (hingga 100).
  - Menampilkan daftar layar dalam tab kedua.
  - Membuka detail layar tertentu dengan pesan unik.
- **Komponen Utama**:
  - `GeneratedScreen`: Widget utama dengan dua tab (Input Data dan Generated Screens).
  - `ScreenDetail`: Menampilkan detail layar dengan pesan unik berdasarkan nomor layar.

---

## **Instalasi Proyek**
1. **Persyaratan**:
   - Flutter SDK
   - Dart
   - IDE seperti Android Studio atau VS Code

2. **Langkah Instalasi**:
   1. Clone repository ini:
      ```bash
      git clone https://github.com/KingPublic/Andreyhs_assign_navigation
      ```
   2. Masuk ke folder proyek:
      ```bash
      cd navigation_lab5
      ```
   3. Jalankan `flutter pub get` untuk mengunduh dependensi.
   4. Jalankan aplikasi dengan:
      ```bash
      flutter run
      ```

---

## **Tantangan dan Pendekatan**
### **Tantangan**
1. **Validasi Input**:
   - Input jumlah layar harus valid (1–100).
2. **Navigasi Antar Layar**:
   - Memastikan data konsisten saat berpindah layar.
3. **Pengelolaan State**:
   - Sinkronisasi data antar layar menggunakan Provider.

### **Pendekatan**
1. **Validasi**:
   - Gunakan `int.tryParse` dan `SnackBar` untuk menangani input tidak valid.
2. **Navigasi**:
   - Gunakan `Navigator.push` untuk berpindah antar layar, dengan parameter untuk menentukan konten layar.
3. **State Management**:
   - Gunakan `ChangeNotifierProvider` untuk mempermudah sinkronisasi data global.

