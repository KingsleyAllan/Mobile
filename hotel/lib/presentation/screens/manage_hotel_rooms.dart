import 'package:flutter/material.dart';
import 'package:hotel/domain/models/room_model.dart';
import 'package:hotel/providers/room_provider.dart';
import 'package:hotel/providers/selected_hotel_provider.dart';
import 'package:provider/provider.dart';

class ManageHotelRooms extends StatefulWidget {
  const ManageHotelRooms({super.key});

  @override
  State<ManageHotelRooms> createState() => _ManageHotelRoomsState();
}

class _ManageHotelRoomsState extends State<ManageHotelRooms> {
  RoomProvider? roomProvider;

  @override
  void initState() {
    super.initState();
    roomProvider = RoomProvider();

    final selectedHotelProvider = Provider.of<SelectedHotelProvider>(context, listen: false);
    final String? selectedHotel = selectedHotelProvider.selectedHotelId;
    print('Selected Hotel: $selectedHotel');
  }

  DataRow _roomDataRow(Room room) {
    return DataRow(
      cells: [
        DataCell(Text(room.name)),
        DataCell(Text(room.type)),
         DataCell(
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {} // Handle hotel update logic,
                  ),
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {} // Handle hotel deletion logic,
                  ),
            ],
          ),
        ),
      ],
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
          final filteredRooms = roomProvider!.getRoomsForSelectedHotel(selectedHotelId);
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
                'MANAGE HOTEL ROOMS',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            body: filteredRooms.isEmpty
                ? const Center(child: Text('No rooms available'))
                : SingleChildScrollView(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text(''))
                      ],
                      rows: filteredRooms.map((room) => _roomDataRow(room)).toList(),
                    ),
                  ),
          );
        }
      },
    );
  }
}
