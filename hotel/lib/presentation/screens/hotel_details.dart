// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:hotel/presentation/screens/select_date.dart';
import 'package:hotel/providers/bottom_nav_provider.dart';
import 'package:hotel/providers/hotel_provider.dart';
import 'package:provider/provider.dart';

class HotelDetails extends StatefulWidget {
  final String id;

  const HotelDetails({super.key, required this.id});

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  @override
  void initState() {
    super.initState();
    Future<void> getHotelData() async {
      try {
        await Provider.of<HotelProvider>(context, listen: false)
          .getHotelDetails(widget.id);
      } catch (e) {
        print(e); // Or display an error message to the user
      }
    }

    getHotelData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        flexibleSpace: const Image(
          image: AssetImage('assets/images/home page header.png'),
          fit: BoxFit.cover,
        ),
      ),
      body: Consumer<HotelProvider>(builder: (context, hotelProvider, child) {
        // Use the widget.id to access the selected hotel details
        final hotel = hotelProvider.hotels.firstWhere((hotel) => hotel.id == widget.id);

        if (hotel != null) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (hotel.imageUrl != null && hotel.imageUrl.isNotEmpty)
                  // Image.network(hotel.imageUrl),
                  Image.asset(
                    'images/georgia.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on_sharp,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          hotel.location, 
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ), 

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(hotel.name, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 30, fontWeight: FontWeight.w900)
                        ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(hotel.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith( fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,)
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelectDate()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'BOOK A ROOM',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  )
                     
              ],
            ),
          );
        } else {
          // Handle case where hotel with the provided id is not found
          return Text('Hotel not found'); // Or display a more informative message
        }
      }),

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
