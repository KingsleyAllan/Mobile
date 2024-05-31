import 'package:flutter/material.dart';
import 'package:hotel/providers/bottom_nav_provider.dart';
import 'package:provider/provider.dart';
import 'package:hotel/providers/auth_provider.dart';
import 'package:hotel/domain/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final UserModel? user = authProvider.user;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        flexibleSpace: const Image(
          image: AssetImage('assets/images/home page header.png'),
          fit: BoxFit.cover,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${user?.fname ?? 'Guest'}',
              style: const TextStyle(fontSize: 20),
            ),

            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/adminlogin');
                    },
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text('Sign up'),
                  ),
                ],
              ),
          ],
        ),
      ),

      bottomNavigationBar: Consumer<BottomNavigationBarProvider>(
          builder: (context, provider, child) {
            return BottomNavigationBar(
              backgroundColor: Colors.black,
              showSelectedLabels: false,
              selectedItemColor: Colors.grey,
              unselectedItemColor: Colors.grey,
              iconSize: 30,
              currentIndex: provider.currentIndex,
              onTap: (int index) {
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, '/home');
                    provider.currentIndex = index;
                    break;
                  case 1:
                    Navigator.pushNamed(context, '/bookings');
                    provider.currentIndex = index;
                    break;
                  case 2:
                    Navigator.pushNamed(context, '/trips');
                    provider.currentIndex = index;
                    break;
                  case 3:
                    Navigator.pushNamed(context, '/profile');
                    provider.currentIndex = index;
                    break;
                }
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_sharp), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bed_sharp),
                  label: 'Bookings',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline_sharp),
                  label: 'Trips',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_sharp),
                  label: 'Profile',
                ),
              ],
            );
          }
        )
    );
  }
}