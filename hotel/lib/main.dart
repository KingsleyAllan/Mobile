import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotel/presentation/screens/add_hotel.dart';
import 'package:hotel/presentation/screens/admin_login.dart';
import 'package:hotel/presentation/screens/dashboard.dart';
import 'package:hotel/presentation/screens/home.dart';
import 'package:hotel/presentation/screens/login.dart';
import 'package:hotel/presentation/screens/manage_hotels.dart';
import 'package:hotel/presentation/screens/profile.dart';
import 'package:hotel/presentation/screens/register.dart';
import 'package:hotel/presentation/widgets/bottom_nav.dart';
import 'package:hotel/providers/admin_provider.dart';
import 'package:hotel/providers/bottom_nav_provider.dart';
import 'package:hotel/providers/hotel_provider.dart';
import 'package:hotel/theme/theme.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:hotel/providers/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => AdminProvider()),
      ChangeNotifierProvider(create: (context) => HotelProvider()),
      ChangeNotifierProvider(create: (context) => BottomNavigationBarProvider()),
    ],
    child: const Hotel(),
  ));
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (context) => AuthProvider(),
  //     child: const Hotel(),
  //   ),
  // );
}

class Hotel extends StatelessWidget {
  const Hotel({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      title: 'RoseWood Hotel Group',
      home: authProvider.isLoggedIn ? BottomBar() : const MyHomePage(title: ''),
      
      routes: {
        '/home': (context) => const MyHomePage(title: ''),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/adminlogin': (context) => AdminScreen(),
        '/dashboard':(context) => const Dashboard(title: '',),
        '/addhotel':(context) => const AddHotelScreen(),
        '/manegehotel':(context) =>  const ManageHotel(title: '',),
      },
    );
  }
}
