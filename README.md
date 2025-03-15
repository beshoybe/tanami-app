# Tanami App

## 📌 Overview

This app is built using **Clean Architecture** and leverages **Riverpod** for state management. It features **GoRouter** for navigation and uses **code generation** to streamline various aspects, including navigation, state management, assets, localization, and theming. The app also includes **unit testing with Mockito**, **test coverage analysis**, and **integration testing using Patrol CLI**.

## 🚀 Features

- **Clean Architecture** for maintainability and scalability
- **Riverpod** for efficient and testable state management
- **GoRouter** for declarative and dynamic routing
- **Code Generation** for:
  - GoRouter navigation
  - Riverpod providers
  - Assets management
  - Localization
  - Tailor-based theming
- **Localization Support** for multi-language apps
- **Custom Theming** using Tailor
- **Environment Configuration (.env) Support**
- **Unit Testing with Mockito**
- **Test Coverage Analysis**
- **Integration Testing with Patrol CLI**

## 🏗️ Project Structure

```
project_root/
├── lib/                # Main application code
│   ├── core/           # Common utilities and base classes
│   │   ├── theme/      # Tailor-based theme management
│   ├── features/       # Feature-based modules
│   ├── l10n/           # Localization files
│   ├── config/         # Configuration settings
│   │   ├── router/     # Navigation setup with GoRouter
├── test/               # Unit tests (Mockito & test coverage)
├── integration_test/   # Integration tests (Patrol)
├── .env                # Environment variables file
```

## 🌍 Environment Configuration

This app uses a `.env` file to store environment-specific variables.

### 📄 Create a `.env` File

Inside your project root, create a `.env` file:

```

BASE_URL = https://tanami-app-backend-b43011bdbd4c.herokuapp.com

TESTING_EMAIL = beshoybe2001@gmail.com
TESTING_PASSWORD = Test@123
TESTING_PIN = 1234

```

## 🚀 Getting Started

### 1️⃣ Install Dependencies

Run the following command to install required packages:

```sh
flutter pub get
```

### 2️⃣ Run Code Generation

```sh
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3️⃣ Run the App

```sh
flutter run
```

## 🧪 Testing

### ✅ Unit Testing (with Mockito)

```sh
flutter test
```

### 📊 Test Coverage

```sh
flutter test --coverage
lcov --list coverage/lcov.info
```

### 🏁 Integration Testing (with Patrol CLI)

### Activate Patrol CLI

```sh
dart pub global activate patrol_cli
```

```sh
patrol drive
```
