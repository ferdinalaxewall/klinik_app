# Klinik App

Klinik App adalah aplikasi yang dibangun menggunakan Flutter untuk mengelola data klinik seperti poli, pegawai, pasien, dan jadwal dokter. Aplikasi ini menyediakan fitur login dan logout serta operasi CRUD (Create, Read, Update, Delete) untuk berbagai entitas.

## Tech Stack

- Flutter

## Fitur

- Login
- Logout
- CRUD Poli
- CRUD Pegawai
- CRUD Pasien
- CRUD Jadwal Dokter

## Persyaratan

Sebelum memulai, pastikan Anda memiliki persyaratan berikut:

- [Flutter](https://flutter.dev/docs/get-started/install) SDK
- [Git](https://git-scm.com/) 

## Instalasi

Ikuti langkah-langkah berikut untuk menjalankan aplikasi ini di mesin lokal Anda:

1. Clone repositori ini

   ```sh
   git clone https://github.com/ferdinalaxewall/klinik_app.git
   cd klinik_app
   ```

2. Instal dependensi

   Jalankan perintah berikut untuk menginstal semua dependensi yang dibutuhkan oleh aplikasi Flutter:

   ```sh
   flutter pub get
   ```

3. Jalankan aplikasi

   Pastikan Anda telah menghubungkan perangkat atau emulator yang mendukung Flutter. Kemudian, jalankan aplikasi dengan perintah berikut:

   ```sh
   flutter run
   ```

4. Backend Aplikasi (Custom)

   Untuk menjalankan aplikasi backend, silakan menuju ke repositori [backend_klinik_app](https://github.com/ferdinalaxewall/backend_klinik_app) dan ikuti petunjuk instalasi yang terdapat di sana.

## Penggunaan

Setelah berhasil menjalankan aplikasi, Anda dapat melakukan login dengan akun yang disediakan dibawah ini. Setelah login, Anda dapat mengelola data poli, pegawai, pasien, dan jadwal dokter melalui antarmuka yang disediakan.

## Integrasi API

Dalam aplikasi ini anda dapat menggunakan API/Backend dengan 2 Tipe Integrasi (MockAPI dan Custom API menggunakan NestJS + TypeScript)

1. Integrasi dengan MockAPI
   Buka file `lib/helper/api_client.dart` lalu aktifkan `baseUrl` yang **menggunakan MockAPI**
   ```dart
   late final Dio dio = Dio(
      BaseOptions(
         // URL dasar menggunakan MockAPI
         baseUrl: customBaseURL ?? apiBaseURL1,

         // URL dasar menggunakan aplikasi lokal NestJS
         // baseUrl: 'http://localhost:3000/',
         connectTimeout: const Duration(seconds: 5), // Waktu timeout untuk koneksi
         receiveTimeout: const Duration(seconds: 3) // Waktu timeout untuk menerima data
      )
   );
   ```

   Karena menggunakan MockAPI versi gratis dibatasi 2 resource per-project, maka untuk endpoint/URL mockapi dibagi menjadi 2
   - Untuk endpoint pertama (poli & jadwal_dokter) anda bisa menggantinya di file `lib/helper/api_client.dart` pada variable `apiBaseURL1`
   - Untuk endpoint kedua (pasien & pegawai) anda bisa menggantinya di file `lib/service/pasien_service.dart` dan `lib/service/pegawai_service.dart` pada variable `apiBaseURL`

2. Integrasi dengan Lokal NestJS API 
   Buka file `lib/helper/api_client.dart` lalu aktifkan `baseUrl` yang **menggunakan lokal NestJS**
   ```dart
   late final Dio dio = Dio(
      BaseOptions(
         // URL dasar menggunakan MockAPI
         // baseUrl: customBaseURL ?? apiBaseURL1,

         // URL dasar menggunakan aplikasi lokal NestJS
         baseUrl: 'http://localhost:3000/',
         connectTimeout: const Duration(seconds: 5), // Waktu timeout untuk koneksi
         receiveTimeout: const Duration(seconds: 3) // Waktu timeout untuk menerima data
      )
   );
   ```

## Akun Admin
- Username : admin
- Password : admin

## Kontribusi

Kami menyambut kontribusi dari siapa saja. Jika Anda ingin berkontribusi, silakan fork repositori ini dan buat pull request dengan perubahan yang Anda buat.

## Lisensi

Aplikasi ini dilisensikan di bawah [MIT License](LICENSE).

## Kontak

Jika Anda memiliki pertanyaan atau masukan, silakan hubungi kami di [ferdinalraihan@gmail.com].


Sesuaikan bagian yang perlu dengan informasi spesifik dari proyek Anda. README ini memberikan panduan dasar untuk memulai dengan aplikasi Klinik App, termasuk cara menginstal dan menjalankan aplikasi, serta mengarahkan pengguna ke repositori backend.
