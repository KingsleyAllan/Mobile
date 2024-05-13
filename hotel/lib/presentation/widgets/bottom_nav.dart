import 'package:flutter/material.dart';
import 'package:hotel/presentation/screens/home.dart';
import 'package:hotel/presentation/screens/profile.dart';
import 'package:hotel/providers/bottom_nav_provider.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final List<Widget> currentTab = [
    const MyHomePage(title: 'Hotel Page'),
    // const SearchScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> BottomNavigationBarProvider()),
      ],
      child: Consumer<BottomNavigationBarProvider>(
        builder:(context, provider, child) {
          return Scaffold(
            body: currentTab[provider.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: provider.currentIndex,
              onTap: (index) {
                provider.currentIndex = index;
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        }
      )
    );    
  }
}