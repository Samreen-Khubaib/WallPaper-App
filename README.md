# 🌌 Aura Themes - Wallpaper App

Aura Themes is a Flutter-based mobile application that allows users to explore, save, and set high-quality wallpapers. The app features smooth animations, category-based browsing, live search, and dynamic wallpapers fetched from APIs and local storage.

---

## 🚀 Features

- **🔒 User Authentication**: Secure login and signup using Firebase Authentication.
  
- **🌐 Splash & Loading Screens**: Animated splash screen with a modern design and app icon animation.
  
- **🎨 Browse Wallpapers**: Explore wallpapers by category or search by keywords.
  
- **🔍 Dynamic Wallpapers**: Support for video wallpapers (MP4) and static images.
  
- **❤️ Favorites**: Save wallpapers to view later.
  
- **📤 Wallpaper Preview**: Full-screen preview with wallpaper details.

- **🌙 Dark Mode**: Toggle between light and dark themes.
  
- **📤 Unsplash & Pexels API Integration**: Fetch high-quality wallpapers dynamically from Unsplash and Pexels.


---


## 💻 Technologies Used

- **Flutter** - Cross-platform UI toolkit
- **Firebase Authentication** - User login/signup management
- **Shared Preferences** - Persistent local storage
- **Video Player** - For dynamic wallpaper playback
- **REST APIs** - Dynamic wallpaper fetching
- **Custom Animations** - Animated splash screen and UI transitions

---

## 🔧 Installation

1. Clone the repository:

   git clone https://github.com/your-username/aura-themes.git

2. Navigate to the project directory:

   cd aura-themes

3. Install dependencies:

   flutter pub get


4. Connect your Firebase project (update google-services.json for Android and GoogleService-Info.plist for iOS).

5. Run the app:

   flutter run


## 📂 Project Structure

- **.dart_tool/** – Auto-generated folder for Dart dependencies and build info.  
- **.idea/** – Project settings/configuration for IDE (like IntelliJ/Android Studio).  
- **android/** – Native Android-specific code and configuration.  
- **assets/** – App resources such as images, fonts, and other static files.  
- **build/** – Generated build output (compiled files).  
- **ios/** – Native iOS-specific code and configuration.  
- **lib/** – Main application source code.  
  - **DynamicWallpaperPage.dart** – Screen for dynamic wallpapers.  
  - **ExploreDetailPage.dart** – Detailed view of explore section items.  
  - **ExplorePage.dart** – Explore wallpapers and categories screen.  
  - **FavouritesPage.dart** – User’s saved favorite wallpapers.  
  - **firebase_options.dart** – Firebase configuration file.  
  - **HomePage.dart** – Main app homepage.  
  - **InstallDynamicPage.dart** – Install screen for dynamic wallpapers.  
  - **InstallWallpaperPage.dart** – Install screen for static wallpapers.  
  - **LoginPage.dart** – User login/authentication screen.  
  - **main.dart** – Entry point of the Flutter app.  
  - **pexels_service.dart** – Service for fetching wallpapers from Pexels API.  
  - **SavedWallpapersPage.dart** – Screen for saved wallpapers.  
  - **SettingsPage.dart** – App settings screen.  
  - **SplashScreen.dart** – Splash/loading screen at app startup.  
  - **StaticWallpaperPage.dart** – Screen for static wallpapers.  
  - **unsplash_service.dart** – Service for fetching wallpapers from Unsplash API.  
  - **VideoDetailPage.dart** – Detailed view for video wallpapers.  
  - **WallpaperDetailPage.dart** – Detailed wallpaper preview and options.  
  - **WallpapersPage.dart** – Main wallpapers listing screen.
    

## 📝 Usage

Browse wallpapers from the Home page.

Tap a wallpaper to preview it in detail.

Save wallpapers to Favorites.

Enable Dark Mode from Settings.

Login/Signup with Firebase for a personalized experience.

