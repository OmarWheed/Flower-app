
# 📑 Table of Contents
 
- [📱 Screenshots](#-screenshots)
- [✨ Features](#-features)
- [🏗️ Architecture](#️-architecture)
- [📂 Project Structure](#-project-structure)
- [🛠️ Tech Stack](#️-tech-stack)
- [🚀 Getting Started](#-getting-started)
- [🧪 Testing](#-testing)
- [🔄 CI / CD](#-ci--cd)
- [👥 Contributors](#-contributors)

---
 
 ## 📱 Screenshots

🎨 Full UI design available on Figma
 https://www.figma.com/design/jefwMXqsdkzUdJgfyM9otG/Flower-app?node-id=70-3347&p=f&t=8kjBjNghWirE3BR2-0


<h2>📸 App Showcase</h2>

<h3>🔍 Discovery & Shopping</h3>
<p>Find the perfect gift through a dynamic home feed, curated categories, and smart search.</p>

<table>
<tr>
<td align="center"><b>Home Screen</b></td>
<td align="center"><b>Best Sellers</b></td>
</tr>
<tr>
<td><img src="https://github.com/user-attachments/assets/e17a7969-1241-4153-a1ef-b8aa304ecbef" width="350"/></td>
<td><img src="https://github.com/user-attachments/assets/180d5450-860a-4f9c-9810-15dc211e156f" width="350"/></td>
</tr>
</table>

<table>
<tr>
<td align="center"><b>Categories</b></td>
<td align="center"><b>Product Details</b></td>
</tr>
<tr>
<td><img src="https://github.com/user-attachments/assets/4433e022-cc37-4bfc-aba8-e5efa16bcff9" width="350"/></td>
<td><img src="https://github.com/user-attachments/assets/b9cabe7d-ba85-4a6c-881e-e4e3da2f6a98" width="350"/></td>
</tr>
</table>

<h3>🛒 Checkout & Logistics</h3>
<p>A seamless flow from the shopping cart to final delivery with real-time tracking integration.</p>

<table>
  <tr>
    <td align="center"><b>Shopping Cart</b></td>
    <td align="center"><b>Shipping Details</b></td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/01f7c8b0-4205-43c4-b3dc-c02f40ba7747" width="350" height="750"/>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/7d932676-cfb8-4a30-acfd-cc8046c2cf25" width="350" height="750"/>
    </td>
  </tr>
</table>

<table>
<tr>
<td align="center"><b>Order Success</b></td>
<td align="center"><b>Real-time Tracking</b></td>
</tr>
<tr>
<td><img src="https://github.com/user-attachments/assets/b3be22e8-c1ac-44b8-8b9f-7faf50159553" width="350"/></td>
<td><img src="https://github.com/user-attachments/assets/dda0f7f7-73c1-454c-b441-e0ae14f2849f" width="350"/></td>
</tr>
</table>

<h3>👤 Profile & Addresses</h3>
<p>Manage your personal identity, delivery history, and saved locations.</p>

<table>
<tr>
<td align="center"><b>Profile Hub</b></td>
<td align="center"><b>Saved Addresses</b></td>
</tr>
<tr>
<td><img src="https://github.com/user-attachments/assets/781d1213-ba76-49e8-aefb-d5fd85bcab88" width="350"/></td>
<td><img src="https://github.com/user-attachments/assets/ad701c4b-c4e6-49ef-bb92-aa6a9b85de73" width="350"/></td>
</tr>
</table>

<table>
<tr>
<td align="center"><b>Edit Profile</b></td>
<td align="center"><b>Active Orders</b></td>
</tr>
<tr>
<td><img src="https://github.com/user-attachments/assets/641f7149-5b5d-4881-a9bc-8068a1006225" width="350"/></td>
<td><img src="https://github.com/user-attachments/assets/39494b84-f745-4828-8f51-f80d3260c433" width="350"/></td>
</tr>
</table>

<h3>🔐 Authentication & Security</h3>
<p>Secure onboarding featuring OTP verification and robust input validation.</p>

<table>
<tr>
<td align="center"><b>Login Screen</b></td>
<td align="center"><b>Sign Up</b></td>
</tr>
<tr>
<td><img src="https://github.com/user-attachments/assets/a85d547c-de65-47f1-bfe8-67eaee788eef" width="350"/></td>
<td><img src="https://github.com/user-attachments/assets/74aa7038-fe19-4783-83b8-6a0bb47da955" width="350"/></td>
</tr>
</table>

<table>
<tr>
<td align="center"><b>Verification Code</b></td>
<td align="center"><b>Error States</b></td>
</tr>
<tr>
<td><img src="https://github.com/user-attachments/assets/d5866be8-cb73-4d5e-b28e-d84642cf32f3" width="350"/></td>
<td><img src="https://github.com/user-attachments/assets/e9ca4ac9-45e5-40ad-9df2-326973e92ac1" width="350"/></td>
</tr>
</table>


# ✨ Features
 
<div align="center">
 
| | Feature | Description |
|:---:|:---|:---|
| 🔐 | **Authentication** | Email/password login & registration with secure OTP verification |
| 🌺 | **Flower Catalog** | Rich product browsing with skeleton loaders and optimized image caching |
| 🔍 | **Search & Filter** | Find flowers by category, price, and popularity |
| 🛒 | **Smart Cart** | Add, remove, and update items with real-time total calculation |
| 💳 | **Checkout Flow** | Smooth multi-step checkout with address selection and order summary |
| 📍 | **Maps & Location** | Google Maps integration with live geocoding and saved delivery addresses |
| 🚚 | **Live Order Tracking** | Real-time order status updates powered by Cloud Firestore |
| 🔔 | **Push Notifications** | FCM-powered alerts for order status, promos, and delivery updates |
| 🌍 | **Localization** | Full multi-language support via `easy_localization` |
| 🎨 | **Lottie Animations** | Delightful micro-animations for loading states and transitions |
| 🌐 | **In-App WebView** | Embedded browser for terms, policies, and external content |
| 🐛 | **Crash Reporting** | Automatic crash and error tracking with Firebase Crashlytics |
| 🔒 | **Secure Storage** | Sensitive tokens encrypted with `flutter_secure_storage` |
| 📦 | **Package Info** | Dynamic versioning with `package_info_plus` |
 
</div>
 
---
 
---
 
## 🏗️ Architecture
 
This project follows **Clean Architecture** with a strict 3-layer separation of concerns, ensuring testability, maintainability, and scalability.
 
```
┌──────────────────────────────────────────────────────────────┐
│                     PRESENTATION LAYER                       │
│                                                              │
│   ┌─────────────┐  ┌──────────────┐  ┌───────────────────┐  │
│   │   Screens   │  │   Widgets    │  │   BLoC / Cubit    │  │
│   └─────────────┘  └──────────────┘  └───────────────────┘  │
│                    ┌──────────────┐                          │
│                    │ Localization │                          │
│                    └──────────────┘                          │
└────────────────────────┬─────────────────────────────────────┘
                         │  calls use-cases
┌────────────────────────▼─────────────────────────────────────┐
│                       DOMAIN LAYER                           │
│                                                              │
│   ┌─────────────┐  ┌──────────────┐  ┌───────────────────┐  │
│   │  Entities   │  │  Use Cases   │  │ Repo Interfaces   │  │
│   └─────────────┘  └──────────────┘  └───────────────────┘  │
│                    ┌──────────────┐                          │
│                    │  Failures    │                          │
│                    └──────────────┘                          │
└────────────────────────┬─────────────────────────────────────┘
                         │  implements interfaces
┌────────────────────────▼─────────────────────────────────────┐
│                        DATA LAYER                            │
│                                                              │
│   ┌─────────────┐  ┌──────────────┐  ┌───────────────────┐  │
│   │ Retrofit /  │  │    DTOs &    │  │  Repo Impls &     │  │
│   │    Dio      │  │    Models    │  │  Data Sources     │  │
│   └─────────────┘  └──────────────┘  └───────────────────┘  │
│                    ┌──────────────┐                          │
│                    │  Local DB    │                          │
│                    └──────────────┘                          │
└──────┬──────────────────────────────────────────┬────────────┘
       │                                          │
       ▼                                          ▼
┌─────────────────────┐              ┌────────────────────────┐
│  Firebase Services  │              │     Local Storage      │
│                     │              │                        │
│  • Firestore        │              │  • SharedPreferences   │
│  • FCM              │              │  • SecureStorage       │
│  • Crashlytics      │              │  • Cached Images       │
└─────────────────────┘              └────────────────────────┘
```
 
### Key Design Decisions
 
| Decision | Choice | Why |
|:---|:---|:---|
| State Management | `flutter_bloc` | Predictable, testable, scales well |
| DI Container | `get_it` + `injectable` | Code-gen DI, zero boilerplate |
| Networking | `dio` + `retrofit` | Type-safe REST, interceptors, logging |
| Serialization | `json_serializable` | Auto-generated, no manual parsing |
| Env Config | `envied` | Compile-time secrets, not at runtime |
| Logging | `talker_dio_logger` | Structured request/response logs |
 
---
 
## 📂 Project Structure
 
```
flower_app/
│
├── 📁 lib/
│   ├── 📁 core/
│   │   ├── di/                    # Dependency injection setup
│   │   ├── network/               # Dio client, interceptors, base API
│   │   ├── error/                 # Failure classes & exception handling
│   │   ├── utils/                 # Extensions, helpers, constants
│   │   └── widgets/               # Shared reusable widgets
│   │
│   ├── 📁 features/
│   │   ├── auth/
│   │   │   ├── data/              # LoginDto, AuthRepositoryImpl, RemoteDS
│   │   │   ├── domain/            # User entity, LoginUseCase, IAuthRepo
│   │   │   └── presentation/      # AuthBloc, LoginScreen, RegisterScreen
│   │   │
│   │   ├── home/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/      # HomeBloc, HomeScreen
│   │   │
│   │   ├── product/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/      # ProductBloc, DetailScreen
│   │   │
│   │   ├── cart/                  # Cart feature (BLoC + repo)
│   │   ├── orders/                # Order history + live tracking
│   │   ├── address/               # Address management + maps
│   │   ├── notifications/         # FCM + local notifications
│   │   └── profile/               # User profile management
│   │
│   ├── 📁 config/
│   │   ├── router/                # App navigation & routing
│   │   ├── themes/                # Light/dark theme, colors, text styles
│   │   └── localization/          # easy_localization setup
│   │
│   └── main.dart                  # App entry point
│
├── 📁 assets/
│   ├── translations/              # en.json, ar.json …
│   ├── icon/                      # app_icon.png
│   ├── image/                     # Static images
│   ├── animation/                 # Lottie .json files
│   ├── fonts/                     # Inter (Regular, Medium, SemiBold)
│   ├── address_json/              # Address data
│   └── json/                      # Misc JSON assets
│
├── 📁 test/                       # Unit, widget & integration tests
├── 📁 android/                    # Android native project
├── 📁 ios/                        # iOS native project
├── 📁 env/                        # Environment config files
├── 📁 .github/workflows/          # GitHub Actions CI pipelines
│
├── pubspec.yaml
├── firebase.json
├── analysis_options.yaml
└── sonar-project.properties
```
 
---
 
## 🛠️ Tech Stack
 
<div align="center">
 
### 🧩 Core
 
| Package | Version | Role |
|:---|:---:|:---|
| [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) | `^9.1.1` | State management |
| [`get_it`](https://pub.dev/packages/get_it) | `^9.2.0` | Service locator / DI |
| [`injectable`](https://pub.dev/packages/injectable) | `^2.7.1` | Code-gen DI annotations |
| [`dio`](https://pub.dev/packages/dio) | `^5.9.0` | HTTP client with interceptors |
| [`retrofit`](https://pub.dev/packages/retrofit) | `^4.9.1` | Type-safe REST API generator |
| [`json_serializable`](https://pub.dev/packages/json_serializable) | `^6.10.0` | JSON serialization |
| [`equatable`](https://pub.dev/packages/equatable) | `^2.0.7` | Value equality |
| [`envied`](https://pub.dev/packages/envied) | `^1.3.2` | Compile-time env variables |
| [`talker_dio_logger`](https://pub.dev/packages/talker_dio_logger) | `^5.1.9` | Network request logging |
| [`shared_preferences`](https://pub.dev/packages/shared_preferences) | `^2.5.4` | Lightweight local storage |
| [`flutter_secure_storage`](https://pub.dev/packages/flutter_secure_storage) | `^10.0.0` | Encrypted token storage |
 
### 🔥 Firebase
 
| Package | Role |
|:---|:---|
| [`firebase_core`](https://pub.dev/packages/firebase_core) | Firebase SDK initialization |
| [`firebase_messaging`](https://pub.dev/packages/firebase_messaging) | Push notification delivery |
| [`firebase_crashlytics`](https://pub.dev/packages/firebase_crashlytics) | Crash reporting & analytics |
| [`cloud_firestore`](https://pub.dev/packages/cloud_firestore) | Real-time NoSQL database |
| [`flutter_local_notifications`](https://pub.dev/packages/flutter_local_notifications) | Local notification display |
 
### 🗺️ Maps & Location
 
| Package | Role |
|:---|:---|
| [`google_maps_flutter`](https://pub.dev/packages/google_maps_flutter) | Interactive map display |
| [`location`](https://pub.dev/packages/location) | Device GPS access |
| [`geocoding`](https://pub.dev/packages/geocoding) | Address ↔ coordinates conversion |
| [`permission_handler`](https://pub.dev/packages/permission_handler) | Runtime permission management |
 
### 🎨 UI & UX
 
| Package | Role |
|:---|:---|
| [`lottie`](https://pub.dev/packages/lottie) | High-quality animations |
| [`cached_network_image`](https://pub.dev/packages/cached_network_image) | Efficient image loading & caching |
| [`skeletonizer`](https://pub.dev/packages/skeletonizer) | Skeleton loading shimmer |
| [`pinput`](https://pub.dev/packages/pinput) | Beautiful OTP pin input |
| [`badges`](https://pub.dev/packages/badges) | Cart / notification badge overlays |
| [`flutter_svg`](https://pub.dev/packages/flutter_svg) | SVG rendering |
| [`loading_indicator`](https://pub.dev/packages/loading_indicator) | Custom loading spinners |
| [`awesome_dialog`](https://pub.dev/packages/awesome_dialog) | Animated dialog boxes |
| [`easy_localization`](https://pub.dev/packages/easy_localization) | Multi-language i18n |
| [`webview_flutter`](https://pub.dev/packages/webview_flutter) | In-app browser |
| [`image_picker`](https://pub.dev/packages/image_picker) | Camera / gallery image selection |
| [`flutter_native_splash`](https://pub.dev/packages/flutter_native_splash) | Native splash screen |
 
</div>
 
---

---
 
## 🚀 Getting Started
 
### Prerequisites
 
Make sure you have the following installed:
 
- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>= 3.9.2`
- [Dart SDK](https://dart.dev/get-dart) `>= 3.9.2`
- [Android Studio](https://developer.android.com/studio) or [Xcode](https://developer.apple.com/xcode/) (for iOS)
- A configured [Firebase project](https://console.firebase.google.com/)
- A [Google Maps API key](https://developers.google.com/maps/documentation/flutter-sdk/get-started)
 
### Step-by-Step Setup
 
**1. Clone the repository**
 
```bash
git clone https://github.com/OmarWheed/Flower-app.git
cd Flower-app
git checkout development
```
 
**2. Install Flutter dependencies**
 
```bash
flutter pub get
```
 
**3. Set up environment variables**
 
The project uses `envied` for compile-time secrets. Create your env file inside the `/env` directory:
 
```bash
# Create your environment file
cp env/.env.example env/.env.development
 
# Fill in your secrets:
# BASE_URL=https://your-api.com
# GOOGLE_MAPS_API_KEY=your_key_here
```
 
**4. Run code generation**
 
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
 
> This generates: Retrofit API clients, JSON serialization, injectable DI, and envied env classes.
 
**5. Configure Firebase**
 
```bash
# Android
cp google-services.json android/app/
 
# iOS
cp GoogleService-Info.plist ios/Runner/
```
 
**6. Configure Google Maps**
 
- **Android** — add to `android/app/src/main/AndroidManifest.xml`:
 
```xml
<meta-data
  android:name="com.google.android.geo.API_KEY"
  android:value="YOUR_GOOGLE_MAPS_KEY"/>
```
 
- **iOS** — add to `ios/Runner/AppDelegate.swift`:
 
```swift
GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_KEY")
```
 
**7. Run the app**
 
```bash
# Debug
flutter run
 
# Target a specific device
flutter run -d <device_id>
 
# Release build
flutter run --release
```
 
---
 
## 🧪 Testing
 
```bash
# Run all unit & widget tests
flutter test
 
# Run with coverage
flutter test --coverage
 
# View HTML coverage report (PowerShell)
./show_coverage.ps1
 
# Static analysis
flutter analyze
 
# Format check
dart format --output=none --set-exit-if-changed .
```
 
### Testing Stack
 
| Tool | Purpose |
|:---|:---|
| `flutter_test` | Unit tests, widget tests |
| `bloc_test` | BLoC state & event testing |
| `mockito` | Mock generation for dependencies |
 
### Test Structure
 
```
test/
├── features/
│   ├── auth/
│   │   ├── data/           # Repository impl tests
│   │   ├── domain/         # Use-case tests
│   │   └── presentation/   # BLoC tests
│   └── address/
│       └── data/           # address_repository_impl_test.dart
└── helpers/                # Shared test utilities & mocks
```
 
---
 
## 🔄 CI / CD
 
The project has a complete automated pipeline via **GitHub Actions**:
 
```
Push to development
        │
        ▼
┌───────────────────┐
│  flutter analyze  │  ← Lint + static analysis
└────────┬──────────┘
         │
         ▼
┌───────────────────┐
│   flutter test    │  ← Unit & widget tests
└────────┬──────────┘
         │
         ▼
┌───────────────────┐
│  SonarQube scan   │  ← Code quality gate
└────────┬──────────┘
         │
         ▼
┌───────────────────┐
│   flutter build   │  ← APK / IPA artifact
└───────────────────┘
```
 
| Check | Tool | Config File |
|:---|:---|:---|
| Linting | `flutter_lints` | `analysis_options.yaml` |
| Code quality | SonarQube | `sonar-project.properties` |
| CI pipeline | GitHub Actions | `.github/workflows/` |
| Coverage report | LCOV | `show_coverage.ps1` |
 
---

## 👥 Contributors
 
<div align="center">
 
A huge thank you to every developer who has poured their effort into this project! 🙏
 

<br/>
 
<table>
  <tr>
    <td align="center">
      <a href="https://github.com/OmarWheed">
        <img src="https://github.com/OmarWheed.png" width="90" style="border-radius:50%"/><br/>
        <sub><b>Omar Wheed</b></sub>
      </a>
      <br/>
      <sub>🏆 Flutter Developer </sub>
      <br/>
      <br/>
      <img src="https://img.shields.io/badge/Owner-FF6B6B?style=flat-square"/>
    </td>
    <td align="center">
      <a href="https://github.com/Mahamed-Kamal">
        <img src="https://github.com/Mahamed-Kamal.png" width="90" style="border-radius:50%"/><br/>
        <sub><b>Mahamed Kamal</b></sub>
      </a>
      <br/>
          <sub>🏆 Flutter Developer </sub>
      <br/>
      <br/>
      <img src="https://img.shields.io/badge/Contributor-4ECDC4?style=flat-square"/>
    </td>
    <td align="center">
      <a href="https://github.com/AbdelrahmanAyman1">
        <img src="https://github.com/AbdelrahmanAyman1.png" width="90" style="border-radius:50%"/><br/>
        <sub><b>Abdelrahman Ayman</b></sub>
      </a>
      <br/>
          <sub>🏆 Flutter Developer </sub>
      <br/>
      <br/>
      <img src="https://img.shields.io/badge/Contributor-4ECDC4?style=flat-square"/>
    </td>
    <td align="center">
      <a href="https://github.com/Abdo0Salah">
        <img src="https://github.com/Abdo0Salah.png" width="90" style="border-radius:50%"/><br/>
        <sub><b>Abdo Salah</b></sub>
      </a>
      <br/>
          <sub>🏆 Flutter Developer </sub>
      <br/>
      <br/>
      <img src="https://img.shields.io/badge/Contributor-4ECDC4?style=flat-square"/>
    </td>
    <td align="center">
      <a href="https://github.com/Mohamed-Ehab-Elsawy">
        <img src="https://github.com/Mohamed-Ehab-Elsawy.png" width="90" style="border-radius:50%"/><br/>
        <sub><b>Mohamed Ehab Elsawy</b></sub>
      </a>
      <br/>
          <sub>🏆 Flutter Developer </sub>
      <br/>
      <br/>
      <img src="https://img.shields.io/badge/Contributor-4ECDC4?style=flat-square"/>
    </td>
  </tr>
</table>
 
<br/>

[![PRs Welcome](https://img.shields.io/badge/PRs-Welcome!-brightgreen?style=for-the-badge)](https://github.com/OmarWheed/Flower-app/pulls)
 
Want to contribute? Fork the repo, create a feature branch, and open a PR! 🌱



 
</div>
 
---
