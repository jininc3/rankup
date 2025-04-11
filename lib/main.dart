import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const PlayerCardApp());
}

class PlayerCardApp extends StatelessWidget {
  const PlayerCardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlayerCard App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF1E1E1E), // grey
        scaffoldBackgroundColor: const Color(0xFF121212), // very dark grey
        cardColor: const Color(0xFF2A2A2A), // medium grey
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF1E1E1E), // grey
          secondary: Color(0xFF2996F8), // Valorant blue
          surface: Color(0xFF1E1E1E),
          background: Color(0xFF121212),
          error: Color(0xFFFF4655), // Valorant red
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
          elevation: 1,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          selectedItemColor: Color(0xFF2996F8),
          unselectedItemColor: Color(0xFF888888),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2996F8), // Valorant blue
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF2996F8),
            side: const BorderSide(color: Color(0xFF2996F8)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            color: Colors.white70,
          ),
          labelLarge: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF2996F8), // Valorant blue
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: Colors.white70),
          hintStyle: const TextStyle(color: Colors.white38),
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF2996F8), width: 2),
          ),
        ),
      ),
      home: const LoginScreen(), // Start with the login screen instead of home
    );
  }
}