import 'package:flutter/material.dart';
import 'package:hotel/presentation/screens/hotel_list.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'images/profile.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 240,
                ),
                Positioned(
                  bottom: 16.0,
                  left: 16.0,
                  child: Text(
                     'Welcome,\n${user != null ? user.fname ?? 'Guest' : 'Guest'} ${user != null ? user.lname ?? '' : ''}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      shadows: const [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (user != null) // Show content only if user is logged in
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    const SizedBox(height: 24,),
                    Text(
                      'RECOMMENDED DESTINATIONS',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const HotelList(continent: 'Asia and Pacific'),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, //Align text to the left
                          children: [
                            // Image at the top
                            ClipRRect(
                              child: Image.asset(
                                'images/hongkong.jpg',
                                width: double.infinity,
                                height: 240,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Hong Kong SAR',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 15, fontWeight: FontWeight.w600
                              )
                            ),
                            Text(
                              'ROSEWOOD HONG KONG',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    SizedBox(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const HotelList(continent: 'The America'),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, //Align text to the left
                          children: [
                            // Image at the top
                            ClipRRect(
                              child: Image.asset(
                                'images/dix.jpg',
                                width: double.infinity,
                                height: 240,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Virgin Gorda, British Virgin Islands',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 15, fontWeight: FontWeight.w600
                              )
                            ),
                            Text(
                              'ROSEWOOD LITTLE DIX BAY',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    ElevatedButton(
                       onPressed: () {
                        authProvider.signOut(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade900,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'LOGOUT',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 12, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            if (user == null) // Show login button if not logged in
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'LOGIN',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 12, color: Colors.white),
                  ),
                ),
              )
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
                icon: Icon(Icons.home_sharp),
                label: 'Home',
              ),
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
        },
      ),
    );
  }
}



// Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/adminlogin');
//                     },
//                     child: const Text('Login'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/signup');
//                     },
//                     child: const Text('Sign up'),
//                   ),
//                 ],
//               ),