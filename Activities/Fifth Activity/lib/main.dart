import 'package:flutter/material.dart';
import 'screens/authentication_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/home_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/reservations_screen.dart';
import 'screens/about_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/push_a_screen.dart';
import 'screens/push_b_screen.dart';
import 'screens/chats_screen.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/todo_provider.dart';
import 'screens/cart_screen.dart';
import 'screens/todo_screen.dart';
import 'screens/media_demo_screen.dart';
import 'screens/media_player_screen.dart';
import 'screens/profile_card_screen.dart';
import 'screens/icons_demo_screen.dart';
import 'screens/gallery_carousel_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ToDoProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) => MaterialApp(
          title: 'Hotel Booking App',
          theme: ThemeData(
            // Create a light color scheme and let ThemeData infer brightness
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            // Create a dark color scheme and let ThemeData infer brightness
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          themeMode: theme.themeMode,
          home: const AuthenticationScreen(),
          routes: {
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegistrationScreen(),
            '/home': (context) => const HomeScreen(),
            '/booking': (context) => const BookingScreen(),
            '/payment': (context) => const PaymentScreen(),
            '/reservations': (context) => const ReservationsScreen(),
            // Named routes for navigation tasks
            '/about': (context) => const AboutScreen(),
            '/contact': (context) => const ContactScreen(),
            '/pushA': (context) => const PushAScreen(),
            '/pushB': (context) => const PushBScreen(),
            '/chats': (context) => const ChatsScreen(),
            '/cart': (context) => const CartScreen(),
            '/todo': (context) => const TodoScreen(),
            '/media': (context) => const MediaDemoScreen(),
            '/player': (context) => const MediaPlayerScreen(),
            '/profileCard': (context) => const ProfileCardScreen(),
            '/icons': (context) => const IconsDemoScreen(),
            '/gallery': (context) => const GalleryCarouselScreen(),
          },
        ),
      ),
    );
  }
}
