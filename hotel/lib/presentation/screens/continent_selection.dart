// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotel/presentation/screens/hotel_list.dart';
import 'package:hotel/providers/bottom_nav_provider.dart';
import 'package:provider/provider.dart';

class ContinentSelection extends StatelessWidget {
  const ContinentSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 24, 26, 27),
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'ROSEWOOD',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontSize: 30,
                ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text(
                  'FILTER BY REGION',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HotelList(continent: 'The America'),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/americas.png',
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'THE AMERICAS',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HotelList(continent: 'Europe'),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/europe.png',
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'EUROPE',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HotelList(continent: 'Middle East'),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/middle_east.png',
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'MIDDLE EAST',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HotelList(continent: 'Asia and Pacific'),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/asia.png',
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'ASIA AND PACIFIC',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            )),

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
