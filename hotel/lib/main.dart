import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotel/presentation/screens/home.dart';
import 'package:hotel/presentation/screens/login.dart';
import 'package:hotel/presentation/screens/profile.dart';
import 'package:hotel/presentation/screens/register.dart';
import 'package:hotel/theme/theme.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:hotel/providers/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const Hotel(),
    ),
  );
}

class Hotel extends StatelessWidget {
  const Hotel({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      title: 'Hotel Card',
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: ''),
        '/signup': (context) => const SignUpScreen(),
        '/login':(context) => const LoginScreen(),
        '/profile':(context) => const ProfileScreen(),
      },
    );
  }
}