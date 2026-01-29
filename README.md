# Curesee – Aplikasi Mobile Pemberdayaan Kesehatan

Curesee adalah aplikasi kesehatan berbasis mobile yang dikembangkan menggunakan Flutter dengan tujuan meningkatkan kesadaran dan pemahaman masyarakat terhadap kondisi kesehatan melalui teknologi digital dan kecerdasan buatan (AI), khususnya dalam membantu deteksi awal penyakit kulit secara mandiri dan mudah diakses.

---

## 📱 Gambaran Umum

Akses terhadap informasi kesehatan, khususnya terkait deteksi awal penyakit kulit, masih menjadi tantangan bagi banyak masyarakat. Tidak semua individu memiliki akses langsung ke tenaga medis atau fasilitas kesehatan untuk melakukan pemeriksaan dini. Curesee hadir sebagai solusi kesehatan digital berbasis mobile yang mengintegrasikan teknologi kecerdasan buatan (machine learning) untuk membantu pengguna mendeteksi potensi penyakit kulit melalui analisis gambar. Selain fitur deteksi, Curesee juga menyediakan edukasi kesehatan dan pencatatan riwayat kesehatan guna meningkatkan kesadaran dan pencegahan sejak dini.

---

## 🎯 Identifikasi Masalah

Permasalahan yang melatarbelakangi pengembangan Curesee antara lain:

- Terbatasnya akses masyarakat terhadap edukasi kesehatan dasar
- Rendahnya kesadaran terhadap kondisi kesehatan sejak dini
- Ketimpangan akses layanan kesehatan digital
- Minimnya aplikasi kesehatan yang sederhana dan ramah pengguna

---

## 💡 Solusi dan Fitur Utama

Curesee menawarkan solusi kesehatan digital dengan mengintegrasikan teknologi kecerdasan buatan (AI) dan sistem informasi kesehatan melalui beberapa fitur utama berikut:

- Autentikasi pengguna menggunakan Firebase
- Pengelolaan profil kesehatan pengguna
- Pemantauan dan riwayat kesehatan
- Informasi dan edukasi kesehatan
- Deteksi penyakit kulit menggunakan teknologi machine learning berbasis analisis citra
- Fitur berbasis kamera untuk pengambilan dan analisis gambar kulit
- Pemisahan peran pengguna dan admin dalam pengelolaan data dan sistem

---

## 🧑‍🤝‍🧑 Target Pengguna

- Masyarakat umum
- Individu yang ingin meningkatkan kesadaran kesehatan
- Komunitas dengan keterbatasan akses fasilitas kesehatan
- Pelajar dan mahasiswa

---

## 🏗️ Arsitektur Sistem

Curesee menerapkan **Clean Architecture** untuk memastikan aplikasi bersifat modular, mudah dikembangkan, dan mudah dipelihara.
Lapisan arsitektur:

- **Presentation Layer**: Antarmuka pengguna, state management (BLoC), dan interaksi pengguna
- **Domain Layer**: Logika bisnis dan use case
- **Data Layer**: Pengelolaan API, repository, dan sumber data
  Pendekatan ini memungkinkan pengembangan aplikasi yang skalabel dan berkelanjutan.

---

## 🤖 Alur Machine Learning
Model machine learning dikembangkan dan dilatih menggunakan Google Colab dengan bahasa pemrograman Python. Data citra kulit diproses melalui tahapan preprocessing, pelatihan model, dan evaluasi performa. Model hasil pelatihan kemudian diintegrasikan ke dalam aplikasi mobile dalam bentuk file tflite untuk membantu proses deteksi awal penyakit kulit.

---

## 🔗 API dan Integrasi

- RESTful API berbasis Laravel
- Komunikasi data menggunakan format JSON
- Integrasi Firebase untuk autentikasi pengguna
- Dukungan integrasi eksternal untuk pengembangan lanjutan

---

## 🚀 Instalasi dan Konfigurasi

### Prasyarat

- Flutter SDK
- Dart SDK
- Android Studio atau VS Code
- Emulator atau perangkat Android fisik

### Langkah Instalasi

```bash
git clone https://github.com/sony12subagyo/curesee.git
cd curesee
flutter pub get
```

---

## 🛠️ Teknologi yang Digunakan

- **Frontend Mobile**: Flutter (Dart)
- **State Management**: BLoC
- **Backend API**: Laravel REST API
- **Database**: MySQL (phpMyAdmin)
- **Autentikasi**: Firebase Authentication

- **Machine Learning**:
  - Google Colab (training dan evaluasi model)
  - Python (pengolahan data dan pemodelan)
  - Model Machine Learning untuk deteksi penyakit kulit berbasis citra

- **Version Control**: Git dan GitHub

---

## Struktur Utama Folder

```text
lib/
 ├── admin/
 │   └── Fitur khusus untuk admin dalam pengelolaan data dan sistem
 ├── app/
 │   └── Berisi konfigurasi inti aplikasi seperti routing, tema, dan pengaturan global
 ├── users/
 │   ├── features/        # Fitur-fitur utama yang digunakan oleh pengguna
 │   ├── data/            # Implementasi API, repository, dan data source
 │   ├── domain/          # Entity dan use case (logika bisnis)
 │   └── presentation/    # UI, halaman, widget, dan BLoC
 └── main.dart
     └── Entry point utama aplikasi
```

---

## ▶️ Menjalankan Aplikasi

```bash
flutter run
```
