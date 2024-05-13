import 'package:flutter/material.dart';
import 'package:hotel/domain/models/hotel_model.dart';
import 'package:hotel/domain/services/hotel_service.dart';
import 'package:hotel/presentation/screens/add_room.dart';
import 'package:hotel/presentation/screens/manage_hotel_rooms.dart';

class ManageHotel extends StatefulWidget {
  const ManageHotel({super.key});

  @override
  State<ManageHotel> createState() => _ManageHotelState();
}

class _ManageHotelState extends State<ManageHotel> {
  final HotelService _hotelService = HotelService();
  List<Hotel> _hotels = [];

  @override
  void initState() {
    super.initState();
    _fetchHotels();
  }

  Future<void> _fetchHotels() async {
    _hotels = await _hotelService.getHotels();
    setState(() {});//Update UI after fetching hotels
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).primaryColor,
        leading: const Icon(
          Icons.manage_search_sharp,
          color: Colors.white,
          size: 27,
        ),
        title: Text(
          'MANAGE HOTELS',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: _hotels.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator
          : DataTable(
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Continent')),
                DataColumn(label: Text('')), // Add an action column
              ],

              rows: _hotels.map((hotel) => _hotelDataRow(hotel)).toList(),
            ),    
    );
  }

  DataRow _hotelDataRow(Hotel hotel) {
    return DataRow(
      cells: [
        DataCell(Text(hotel.name)),
        DataCell(Text(hotel.continent)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddRoomScreen(hotelId: hotel.id), // Pass the hotel ID to the AddRoomScreen
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.format_list_bulleted_sharp),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageHotelRooms(hotelId: hotel.id), // Pass the hotel ID to the AddRoomScreen
                    ),
                  );
                },
              ),
              // IconButton(
              //   icon: const Icon(Icons.list),
              //   onPressed: () => Navigator.pushNamed(context, '/viewrooms'), // Pass hotel ID for viewing rooms
              // ),
              // IconButton(
              //     icon: const Icon(Icons.edit),
              //     onPressed: () {} // Handle hotel update logic,
              //     ),
              // IconButton(
              //     icon: const Icon(Icons.delete),
              //     onPressed: () {} // Handle hotel deletion logic,
              //     ),
            ],
          ),
        ),
      ],
    );
  }
}