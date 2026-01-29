# Curesee – Aplikasi Mobile Pemberdayaan Kesehatan

Curesee adalah aplikasi kesehatan berbasis mobile yang dikembangkan menggunakan Flutter dengan tujuan meningkatkan kesadaran dan pemahaman masyarakat terhadap kondisi kesehatan melalui teknologi digital yang mudah diakses.

---

## 📱 Gambaran Umum

Akses terhadap informasi kesehatan dan kesadaran akan kondisi kesehatan dini masih menjadi tantangan bagi banyak masyarakat. Curesee hadir sebagai solusi digital untuk membantu menjembatani kesenjangan tersebut melalui aplikasi mobile yang sederhana, informatif, dan mudah digunakan.

---

## 🎯 Identifikasi Masalah

Permasalahan yang melatarbelakangi pengembangan Curesee antara lain:

- Terbatasnya akses masyarakat terhadap edukasi kesehatan dasar
- Rendahnya kesadaran terhadap kondisi kesehatan sejak dini
- Ketimpangan akses layanan kesehatan digital
- Minimnya aplikasi kesehatan yang sederhana dan ramah pengguna

---

## 💡 Solusi dan Fitur Utama

Curesee menawarkan solusi melalui beberapa fitur utama:

- Autentikasi pengguna menggunakan Firebase
- Pengelolaan profil kesehatan pengguna
- Pemantauan dan riwayat kesehatan
- Informasi dan edukasi kesehatan
- Fitur berbasis kamera untuk mendukung kebutuhan kesehatan
- Pemisahan peran pengguna dan admin dalam pengelolaan data

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

- **Frontend**: Flutter (Dart)
- **State Management**: BLoC
- **Backend API**: Laravel REST API
- **Database**: MySQL (phpMyAdmin)
- **Autentikasi**: Firebase Authentication
- **Version Control**: Git dan GitHub

---

## Struktur Utama Folder

```bash
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

### menjalankan aplikasi

```bash
flutter run
```
