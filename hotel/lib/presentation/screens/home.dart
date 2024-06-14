import 'package:flutter/material.dart';
import 'package:hotel/presentation/screens/hotel_list.dart';
import 'package:hotel/providers/bottom_nav_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          flexibleSpace: const Image(
            image: AssetImage('assets/images/home page header.png'),
            fit: BoxFit.cover,
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/rosewood.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 240,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Discover a global collection of one-of-a-kind luxury hotels, resorts and residences, each inspired by our A Sense of Place® philosophy to reflect the local culture and spirit of a destination.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w600
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.all(8.0), // Adjust the value as needed
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'UNITED STATES / CANADA',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0), // Adjust the value as needed
                child: SizedBox(
                  height: 200, // Adjust height as needed
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      SizedBox(
                        width: 200,
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
                                  'images/littledixbay.png',
                                  width: double.infinity,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Virgin Gorda, BVI',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 11, fontWeight: FontWeight.w600
                                )
                              ),
                              Text(
                                'ROSEWOOD LITTLE DIX BAY',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      SizedBox(
                        width: 200,
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
                                  'images/miramar.png',
                                  width: double.infinity,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Montecito, CA. USA',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 11, fontWeight: FontWeight.w600
                                )
                              ),
                              Text(
                                'ROSEWOOD MIRAMAR BEACH',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 15,),
                      SizedBox(
                        width: 200,
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
                                  'images/georgia.png',
                                  width: double.infinity,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Vancouver, BC. Canada',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 11, fontWeight: FontWeight.w600
                                )
                              ),
                              Text(
                                'ROSEWOOD HOTEL GEORGIA',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
