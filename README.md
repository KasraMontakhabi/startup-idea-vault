# StartupIdeaVault

A clean and intuitive Flutter application for showcasing, managing, and exploring creative startup ideas. This app provides a comprehensive platform for entrepreneurs and innovators to store, rate, and discover startup concepts.

## Features

### Core Functionality
- **Idea Management**: Add, view, edit, and delete startup ideas
- **Rating System**: Rate ideas based on innovation, feasibility, and monetization potential
- **Random Idea Generator**: Get inspired with a random startup idea using an animated spinner
- **Search & Filter**: Find specific ideas by title, description, or tags
- **Detailed View**: Comprehensive idea details with ratings and tags

### User Experience
- **Authentication**: Simple login system with persistent session
- **Dark/Light Theme**: Toggle between dark and light modes
- **Responsive Design**: Works seamlessly across different screen sizes
- **Smooth Animations**: Engaging UI with fade and spin animations
- **Swipe to Delete**: Intuitive gesture-based idea removal

### Technical Features
- **State Management**: Powered by Provider pattern
- **Local Storage**: Persistent data using SharedPreferences
- **Cross-Platform**: Supports iOS, Android, Web, Windows, macOS, and Linux

## Screenshots

The app includes several key screens:
- **Home Screen**: Browse all startup ideas in a card-based layout
- **Add Idea Screen**: Create new ideas with ratings and custom icons
- **Random Idea Screen**: Discover ideas with an animated spinner
- **Idea Detail Screen**: View comprehensive information about each idea
- **Login Screen**: Simple authentication interface

## Tech Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **State Management**: Provider
- **Local Storage**: SharedPreferences
- **UI Components**: Material Design 3
- **Animations**: Lottie, Custom Flutter Animations
- **Rating System**: Flutter Rating Bar

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  provider: ^6.1.5
  shared_preferences: ^2.3.2
  lottie: ^3.3.1
  flutter_rating_bar: ^4.0.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK
- IDE (VS Code, Android Studio, or IntelliJ)
- Platform-specific requirements for your target platform

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/kasramontakhabi/startup-idea-vault.git
   cd startup-idea-vault
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Login Credentials
- **Username**: `admin`
- **Password**: `admin123`

## Project Structure

```
lib/
├── data/
│   └── dummy_ideas.dart          # Sample startup ideas
├── models/
│   └── startup_idea.dart         # Startup idea data model
├── providers/
│   ├── auth_provider.dart        # Authentication state management
│   ├── ideas_provider.dart       # Ideas state management
│   └── theme_provider.dart       # Theme state management
├── screens/
│   ├── add_idea_screen.dart      # Add new startup ideas
│   ├── home_screen.dart          # Main ideas listing
│   ├── idea_detail_screen.dart   # Detailed idea view
│   ├── login_screen.dart         # Authentication screen
│   └── random_idea_screen.dart   # Random idea generator
├── widget/
│   └── startup_idea_card.dart    # Reusable idea card component
└── main.dart                     # App entry point
```

## Key Features Explained

### Startup Idea Model
Each startup idea contains:
- **Title**: Brief name of the idea
- **Description**: Detailed explanation
- **Tags**: Categorization labels
- **Icon**: Visual representation (emoji)
- **Ratings**: Innovation, Feasibility, and Monetization scores (1-5)
- **Average Rating**: Calculated from the three rating categories

### Rating System
Ideas are evaluated on three criteria:
- **Innovation**: How novel and creative the idea is
- **Feasibility**: How realistic the implementation is
- **Monetization**: Revenue generation potential

### Sample Ideas Included
The app comes with pre-loaded sample ideas including:
- AI-Powered Plant Care
- Virtual Co-working Spaces
- Sustainable Fashion Marketplace
- Micro-Learning for Seniors
- Pet Social Network
- Smart City Parking

## Development

### Running Tests
```bash
flutter test
```

### Building for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
