# PathFinder Pro 📍

**PathFinder Pro** is a premium, high-performance, offline-first mobile application designed for seamless background location tracking and real-time telemetry mapping. Built using Flutter, BLoC, and Clean Architecture principles, the app features rich animations, glassmorphic visual aesthetics, and advanced performance optimizations.

---

## 🚀 Key Features

* **📦 Offline-First Architecture**: Location coordinates are queried directly from device GPS hardware and written to a local SQLite database. The app works 100% offline without jank.
* **🛡️ Background Tracking Service**: Spawns an isolated background Dart process (using foreground notifications) that continues logging coordinates safely even when the app is closed.
* **🗺️ Interactive Map View**: 
  * Premium dark-themed OpenStreetMap tiles.
  * Real-time GPS recentering and manual zoom controls.
  * Vector route pathing (polylines) with automated recentering on active routes.
* **🫧 Glassmorphic & Adaptive UI**: 
  * Custom floating frosted-glass controls overlaying the map view using BackdropFilters.
  * Responsive and adaptive layouts optimized for Mobile, Tablet, and Desktop screens.
* **⚡ High-Performance Draggable Button**: The floating "Sessions" drawer button uses an isolated `ValueNotifier` layout stack, avoiding screen-wide rebuilds to render smooth **60/120 FPS dragging**.
* **🔋 Dynamic Battery Monitoring**: A smart battery monitor card displaying color themes matching battery health levels (Green, Amber, Orange, Red) and micro-animations.
* **✨ Fluent Animations**: Pulsing radar-like GPS location indicators, sliding menu panel entries, and breathing progress bars using `flutter_animate`.

---

## 🛠️ Architecture & Tech Stack

This project follows **Clean Architecture** patterns to enforce separation of concerns, testability, and scalability:

* **Presentation Layer**: Flutter UI, BLoC State Management (`flutter_bloc`), and responsive design layouts.
* **Domain Layer**: Core Business Logic, Entities, and Use Case definitions.
* **Data Layer**: Repositories, Database Providers (SQLite via `sqflite`), and Service wrappers (`geolocator`).
* **Dependency Injection**: Unified service registry powered by `get_it`.
* **Code Generation**: Automated model compilation using `freezed` and `json_serializable`.

---

## ⚙️ Setup and Build Instructions

### Prerequisites
Make sure you have Flutter SDK (version 3.22.0+ recommended) and Dart installed on your system.

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run Code Generation (Freezed / Models)
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Run the App
```bash
flutter run
```

### 4. Build Optimized Release APK (Comprehensive)
To build a standard release version that works on all Android devices and emulators:
```bash
flutter build apk --release
```
*The compiled APK file will be located at `build/app/outputs/flutter-apk/app-release.apk`.*

---

## 🎨 Design Tokens & Themes
Brand colors and battery health indicators are dynamically mapped and managed inside a centralized color resource config file (`app_theme.dart`):
* `primaryNeon` (`#10B981` Emerald) - Main tracking active theme.
* `batteryLow` (`#EF4444` Red) - Triggered when device charge drops below 20%.
* `batteryNormal` (`#F97316` Orange) - Charge levels between 21% - 50%.
* `batteryOptimal` (`#F59E0B` Amber) - Charge levels between 51% - 80%.
* `batteryFull` (`#10B981` Green) - High battery charge.
