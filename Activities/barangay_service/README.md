# Barangay Service App

A comprehensive Flutter application demonstrating various Flutter concepts, widgets, and architectural patterns. This project serves as a hands-on learning platform for Flutter development, showcasing best practices in mobile app development.

## 📱 Project Overview

The Barangay Service App is a multi-featured Flutter application that simulates a local government service platform. It demonstrates various Flutter concepts including state management, navigation, custom widgets, and third-party package integration.

## 🏗️ Architecture & Project Structure

### Directory Structure

```
lib/
├── main.dart                    # Application entry point
├── models/                      # Data models
│   ├── announcement.dart        # Announcement data model
│   ├── request_record.dart      # Service request data model
│   └── service.dart            # Service data model
├── services/                    # Business logic and data services
│   ├── data_service.dart       # Mock data service
│   ├── request_store.dart      # Request management service
│   └── settings_controller.dart # App settings controller
├── views/                       # Application screens/pages
│   ├── about_page.dart         # About information page
│   ├── announcements_page.dart # Community announcements
│   ├── counter_page.dart       # StatefulWidget counter demo
│   ├── cupertino_page.dart     # Cupertino widgets demo
│   ├── gallery_page.dart       # Staggered grid gallery
│   ├── hello_world.dart        # StatelessWidget demo
│   ├── home_page.dart          # Main dashboard
│   ├── notifications_page.dart # Notifications center
│   ├── profile_page.dart       # User profile
│   ├── request_form_page.dart  # Service request form
│   ├── requests_page.dart      # User requests history
│   ├── services_list_page.dart # Available services list
│   ├── services_page.dart      # Services overview
│   └── settings_page.dart      # App settings
└── widgets/                     # Reusable UI components
    ├── adaptive_scaffold.dart   # Responsive scaffold wrapper
    ├── announcement_tile.dart   # Announcement list item
    ├── custom_button.dart       # Custom reusable button
    ├── home_hero_section.dart   # Home page hero section
    ├── k_app_button.dart        # App-specific button style
    ├── quick_actions_section.dart # Home quick actions
    └── service_card.dart        # Service display card
```

### Architectural Patterns

- **Widget-based Architecture**: Follows Flutter's declarative UI paradigm
- **Separation of Concerns**: Clear separation between models, views, services, and widgets
- **Component Reusability**: Custom widgets for consistent UI patterns
- **State Management**: Demonstrates both StatelessWidget and StatefulWidget patterns

## ✨ Features Implemented

### 1. **Navigation & Structure**
- **Bottom Navigation**: Five-tab navigation (Home, Services, News, Requests, Settings)
- **Adaptive Scaffold**: Responsive layout that adapts to different screen sizes
- **Page Routing**: Seamless navigation between different app sections

### 2. **Widget Demonstrations**
- **StatelessWidget**: `HelloWorldPage` - Simple static content display
- **StatefulWidget**: `CounterPage` - Interactive counter with state management
- **Custom Widgets**: Reusable `CustomButton` implemented across multiple screens

### 3. **UI Design Patterns**
- **Material Design**: Primary UI framework with Material 3 components
- **Cupertino Widgets**: iOS-style components demonstration in `CupertinoDemoPage`
- **Responsive Design**: Adaptive layouts for different screen sizes

### 4. **Advanced Components**
- **Staggered Grid**: Gallery page using `flutter_staggered_grid_view` package
- **Hero Sections**: Gradient backgrounds and engaging visual elements
- **Form Handling**: Service request forms with input validation

### 5. **Code Organization**
- **Component Extraction**: Complex widget trees broken into reusable components
- **Home Hero Section**: Extracted into `HomeHeroSection` widget
- **Quick Actions**: Modularized into `QuickActionsSection` widget

## 🛠️ Dependencies

### Core Dependencies
- **flutter**: Flutter SDK
- **cupertino_icons**: iOS-style icons

### Third-party Packages
- **intl**: Internationalization and date formatting
- **flutter_staggered_grid_view**: Advanced grid layouts for gallery

### Development Dependencies
- **flutter_test**: Testing framework
- **flutter_lints**: Code quality and style enforcement

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=2.19.0 <4.0.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd barangay_service
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Development Setup

1. **Enable Flutter Web (optional)**
   ```bash
   flutter config --enable-web
   ```

2. **Run on specific platform**
   ```bash
   flutter run -d chrome    # Web
   flutter run -d android   # Android
   flutter run -d ios       # iOS
   ```

## 📋 Key Learning Concepts

### 1. **Widget Lifecycle**
- StatelessWidget vs StatefulWidget
- Widget rebuilding and performance optimization
- State management patterns

### 2. **Navigation**
- Bottom navigation implementation
- Page routing and navigation context
- Passing data between screens

### 3. **Custom Widgets**
- Creating reusable components
- Widget composition and inheritance
- Parameter passing and callbacks

### 4. **Third-party Integration**
- Package management with pubspec.yaml
- Implementing external libraries
- Custom styling with third-party widgets

### 5. **Code Organization**
- Folder structure best practices
- Separation of concerns
- Component extraction and reusability

## 🎯 Widget Tree Hierarchy

The application follows a hierarchical widget structure:

```
MaterialApp
└── Shell (StatefulWidget)
    └── AdaptiveScaffold
        ├── BottomNavigationBar (5 tabs)
        └── PageView
            ├── HomePage
            │   ├── HomeHeroSection
            │   └── QuickActionsSection
            ├── ServicesPage
            ├── AnnouncementsPage
            ├── RequestsPage
            └── SettingsPage
```

For detailed widget tree analysis, see [widget_tree_diagram.md](widget_tree_diagram.md).

## 🔧 Customization

### Adding New Pages
1. Create new page in `lib/views/`
2. Add navigation route in `main.dart`
3. Update bottom navigation if needed

### Creating Custom Widgets
1. Add widget file in `lib/widgets/`
2. Follow existing naming conventions
3. Implement proper parameter passing

### Styling
- Modify theme in `main.dart`
- Update individual widget styles
- Maintain consistency across components

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows (with Flutter desktop support)
- ✅ macOS (with Flutter desktop support)
- ✅ Linux (with Flutter desktop support)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Implement changes following existing patterns
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is created for educational purposes and demonstrates Flutter development concepts.

---

**Built with Flutter** 💙 | **Created for Learning** 📚 | **Barangay Service App** 🏛️
