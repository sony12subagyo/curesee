# Curesee – Mobile Health Empowerment Application

Curesee is a mobile health application developed using Flutter, aimed at improving public awareness and understanding of health conditions through digital technology and artificial intelligence (AI), particularly in assisting early detection of skin diseases in an accessible and user-friendly way.

---

## 📱 Overview

Access to health information, especially for early detection of skin diseases, remains a challenge for many communities. Not everyone has direct access to medical professionals or healthcare facilities for early diagnosis.

Curesee provides a mobile-based digital health solution that integrates artificial intelligence (machine learning) to help users detect potential skin diseases through image analysis. In addition to detection features, Curesee also offers health education and health history tracking to promote awareness and preventive care.

---

## 🎯 Problem Identification

The main problems that motivated the development of Curesee include:

- Limited access to basic health education
- Low awareness of early health condition detection
- Inequality in access to digital health services
- Lack of simple and user-friendly health applications

---

## 💡 Solution and Key Features

Curesee offers a digital health solution by integrating artificial intelligence (AI) and health information systems through the following key features:

- User authentication using Firebase
- User health profile management
- Health monitoring and history tracking
- Health information and educational content
- Skin disease detection using machine learning-based image analysis
- Camera-based feature for capturing and analyzing skin images
- Separation of user and admin roles for system and data management

---

## 🧑‍🤝‍🧑 Target Users

- General public
- Individuals who want to improve their health awareness
- Communities with limited access to healthcare facilities
- Students and young adults

---

## 🏗️ System Architecture

Curesee implements **Clean Architecture** to ensure modularity, scalability, and maintainability.

Architecture layers:

- **Presentation Layer**: User interface, state management (BLoC), and user interaction
- **Domain Layer**: Business logic and use cases
- **Data Layer**: API handling, repositories, and data sources

This approach allows the application to be easily maintained and further developed.

---

## 🤖 Machine Learning Workflow

The machine learning model is developed and trained using Google Colab with Python. Skin image data is processed through preprocessing, model training, and evaluation stages. The trained model is then integrated into the mobile application in the form of a `.tflite` file to support early skin disease detection.

---

## 🔗 API and Integrations

- RESTful API built with Laravel
- JSON-based data communication
- Firebase integration for user authentication
- Support for future external integrations

---

## 🚀 Installation and Setup

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- Emulator or physical Android device

### Installation Steps

```bash
git clone https://github.com/sony12subagyo/curesee.git
cd curesee
flutter pub get
```

---

## 🛠️ Technologies Used

- **Mobile Frontend**: Flutter (Dart)
- **State Management**: BLoC
- **Backend API**: Laravel REST API
- **Database**: MySQL (phpMyAdmin)
- **Authentication**: Firebase Authentication

- **Machine Learning**:
  - Google Colab (model training and evaluation)
  - Python (data processing and modeling)
  - Machine learning model for image-based skin disease detection

- **Version Control**: Git and GitHub

---

## Struktur Utama Folder

```text
lib/
 ├── admin/
 │   └── Admin features for managing system and user data
 ├── app/
 │   └── Core application configuration such as routing, theme, and global settings
 ├── users/
 │   ├── features/        # Main features used by users
 │   ├── data/            # API implementation, repositories, and data sources
 │   ├── domain/          # Entities and business logic (use cases)
 │   └── presentation/    # UI, pages, widgets, and BLoC
 └── main.dart
     └── Application entry point
```

---

## ▶️ Running the Application

```bash
flutter run
```
