import 'package:flutter/material.dart';
import 'package:hotel/domain/models/room_model.dart';
import 'package:hotel/presentation/screens/room_details.dart';
import 'package:hotel/providers/booking_criteria.dart';
import 'package:hotel/providers/bottom_nav_provider.dart';
import 'package:hotel/providers/room_provider.dart';
import 'package:hotel/providers/selected_hotel_provider.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  final BookingData bookingData;

  const BookingScreen({super.key, required this.bookingData});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  Room? _selectedRoom;
  RoomProvider? roomProvider;

  @override
  void initState() {
    super.initState();
    roomProvider = RoomProvider(); // Initialize roomProvider
  }

  void _showRoomDetailsDialog(Room room) {
    showDialog(
      context: context,
      builder: (context) {
        return RoomDetails(room: room);
      },
      useRootNavigator: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedHotelProvider = Provider.of<SelectedHotelProvider>(context);
    final String? selectedHotelId = selectedHotelProvider.selectedHotelId;

    if (selectedHotelId == null || selectedHotelId.isEmpty) {
      return const Center(child: Text('Please select a hotel first'));
    }

    return FutureBuilder<void>(
      future: roomProvider!.getRoomsByHotel(selectedHotelId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final filteredRooms = roomProvider!.getRoomsForSelectedHotel(selectedHotelId!);
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              backgroundColor: Theme.of(context).primaryColor,
              leading: const Icon(
                Icons.door_sliding_sharp,
                color: Colors.white,
                size: 27,
              ),
              title: Text(
                'ROOMS',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            body: filteredRooms.isEmpty
                ? const Center(child: Text('No rooms available'))
                : ListView.builder(
                    itemCount: filteredRooms.length,
                    itemBuilder: (context, index) {
                      final room = filteredRooms[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  child: Image.network(
                                    room.imageUrl,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    room.name,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontSize: 20,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    room.headline,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () => _showRoomDetailsDialog(room),
                                    child: Text(
                                      'Room details',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            decoration: TextDecoration.underline,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'BEST AVAILABLE RATE',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontSize: 16,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${room.rate}',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontSize: 20,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Average per night, before taxes and fees',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.bed_sharp, size: 20),
                                      const SizedBox(width: 4),
                                      const Text('1 Bed / Extra Bed Available'),
                                      const SizedBox(width: 16),
                                      const Icon(Icons.person_outline_sharp, size: 20),
                                      const SizedBox(width: 4),
                                      Text('Sleeps ${room.capacity} guests'),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  ElevatedButton(
                                    onPressed: () async {
                                      // Check if user
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).primaryColor,
                                      minimumSize: const Size(double.infinity, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child:  Text(
                                      'BOOK',
                                     style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
              },
            ),
          );
        }
      },
    );
  }
}
