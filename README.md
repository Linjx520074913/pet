# Pet Connect

A modern pet adoption and social networking app built with Flutter. Connect with other pet owners, find playmates for your pets, and schedule fun playdates!

## Features

### Implemented Screens

#### Core Features
1. **Splash Screen** - App launch screen with branding
2. **Onboarding** - Three-screen onboarding flow introducing app features
3. **Authentication**
   - Sign In screen with email/password
   - Social login options (Google, Apple)
   - Verification screen with 4-digit code input
4. **Main Navigation** - Bottom navigation with 4 tabs:
   - Home (Pet Discovery)
   - Messages
   - Favorites
   - Profile
5. **Home/Feed** - Swipeable pet cards with like/dislike actions and animations
6. **Messages** - Chat list with online status indicators
7. **Chat** - Real-time chat interface with message bubbles
8. **Profile** - User profile with stats and pet management
9. **Settings** - App settings with notifications and privacy controls

#### Pet Management Module (NEW!)
10. **My Pets List** - View all your pets with filtering by type (All/Dogs/Cats)
11. **Pet Details** - Comprehensive pet profile with:
    - Photo gallery with Hero animations
    - Basic info (age, weight, gender, vaccination status)
    - Personality traits
    - Quick action buttons for feeding, diary, and health
    - Recent activity timeline
12. **Add/Edit Pet** - Complete pet registration with:
    - Photo upload
    - Basic information (name, breed, type, gender)
    - Birth date picker
    - Health information (vaccination, neutering status)
    - Personality trait selection
13. **Feeding Log** - Track your pet's meals with:
    - Food type and amount tracking
    - Multiple unit support (g, kg, cups, oz)
    - Time-stamped records
    - Notes for each feeding
14. **Pet Diary** - Document your pet's daily life:
    - Rich text entries
    - Mood tracking with emojis
    - Photo attachments
    - Beautiful timeline view
15. **Health Records** - Complete health management:
    - Multiple record types (Checkup, Vaccination, Treatment, Surgery, Dental)
    - Vet information tracking
    - Medication records
    - Next checkup reminders
    - Color-coded by type

### Design Features

- **Premium Dark Theme** - Consistent dark UI with yellow (#FFC107) accent
- **Beautiful Images** - Network images from Unsplash with loading states
- **Smooth Animations** - Card transitions, Hero animations, fade effects
- **Modern UI Components**:
  - Gradient overlays on images
  - Floating action buttons
  - Bottom sheets for forms
  - Custom badges and chips
  - Color-coded health records
  - Mood emojis in diary
- **Responsive Layouts** - Adapts to different screen sizes
- **Material Design 3** - Latest Flutter design patterns

## Getting Started

### Prerequisites

- Flutter SDK (3.38.1 or higher)
- Dart SDK
- iOS Simulator or Android Emulator (or physical device)

### Installation

1. Clone this repository
2. Navigate to the project directory:
   ```bash
   cd pet
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

### Project Structure

```
lib/
├── core/
│   ├── theme/
│   │   ├── app_theme.dart      # App theme configuration
│   │   └── app_colors.dart     # Color constants
│   └── constants/
│       └── app_images.dart     # Image URLs
├── models/
│   └── pet_model.dart          # Pet, FeedingLog, ActivityLog, HealthRecord, PetDiary models
├── screens/
│   ├── splash_screen.dart
│   ├── onboarding_screen.dart
│   ├── auth/
│   │   ├── sign_in_screen.dart
│   │   └── verification_screen.dart
│   ├── main/
│   │   ├── main_screen.dart    # Bottom navigation
│   │   └── home_screen.dart    # Pet discovery with animations
│   ├── messages/
│   │   ├── messages_screen.dart
│   │   └── chat_screen.dart
│   ├── profile/
│   │   └── profile_screen.dart
│   ├── settings/
│   │   └── settings_screen.dart
│   └── pet_management/         # NEW Pet Management Module
│       ├── my_pets_screen.dart       # Pet list with tabs
│       ├── pet_detail_screen.dart    # Pet profile
│       ├── add_pet_screen.dart       # Add/edit pet form
│       ├── feeding_log_screen.dart   # Feeding records
│       ├── pet_diary_screen.dart     # Pet diary
│       └── health_records_screen.dart # Health tracking
└── widgets/
    ├── primary_button.dart
    ├── custom_text_field.dart
    ├── pet_card.dart           # Enhanced with network images & badges
    └── verification_code_input.dart
```

## Color Scheme

- **Primary**: #FFC107 (Yellow)
- **Secondary**: #00BCD4 (Cyan)
- **Background**: #0F1419 (Dark Navy)
- **Card Background**: #1A1F26 (Dark Gray)
- **Text Primary**: #FFFFFF (White)
- **Text Secondary**: #9E9E9E (Gray)

## Technologies Used

- **Flutter** - UI framework
- **Dart** - Programming language
- **Material Design 3** - Design system

## Key Features Highlights

### Pet Management System
- **Complete Pet Profiles** - Store detailed information about each pet
- **Health Tracking** - Monitor vaccinations, checkups, and treatments
- **Feeding Schedule** - Log all meals with amounts and times
- **Daily Diary** - Document special moments and milestones
- **Smart Organization** - Filter pets by type with tab navigation

### User Experience
- **Smooth Animations** - Card swipes, hero transitions, fade effects
- **Beautiful Visuals** - High-quality pet images from Unsplash
- **Intuitive Navigation** - Bottom nav bar and clear hierarchy
- **Form Validation** - Smart input validation throughout
- **Rich Interactions** - Bottom sheets, dialogs, snackbars

### Data Models
- Comprehensive Pet model with all attributes
- FeedingLog for meal tracking
- PetDiary for daily entries
- HealthRecord for medical history
- Fully typed with proper data structure

## Future Enhancements

- **Backend Integration** - Firebase/Supabase for data persistence
- **Photo Upload** - Camera integration for pet photos
- **Location Services** - Real GPS-based pet discovery
- **Push Notifications** - Reminders for feeding, checkups
- **Social Features** - Pet playdates scheduling
- **Analytics** - Pet health and activity insights
- **Export/Import** - Backup and restore pet data
- **Multi-language** - Internationalization support
