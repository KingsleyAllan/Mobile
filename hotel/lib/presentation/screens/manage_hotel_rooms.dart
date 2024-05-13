import 'package:flutter/material.dart';
import 'package:hotel/domain/models/room_model.dart';
// import 'package:hotel/domain/services/room_service.dart';
import 'package:hotel/providers/room_provider.dart';
import 'package:provider/provider.dart';

class ManageHotelRooms extends StatefulWidget {
  final String hotelId;

  const ManageHotelRooms({super.key, required this.hotelId});

  @override
  State<ManageHotelRooms> createState() => _ManageHotelRoomsState();
}

class _ManageHotelRoomsState extends State<ManageHotelRooms> {
  // final RoomService _roomService = RoomService();
  // List<Room> _rooms = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _getRoomsByHotelId();
  // }

  // Future<void> _getRoomsByHotelId() async {
  //   _rooms = await _roomService.getRoomsByHotel(widget.hotelId);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    List<Room> rooms = Provider.of<RoomProvider>(context).rooms;
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
      body: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Actions')),
          ],
          rows: rooms.map((room) => _buildHotelDataRow(room)).toList(),
        ),
      ),
    );
  }

  DataRow _buildHotelDataRow(Room room) {
    return DataRow(
      cells: [
        DataCell(Text(room.name)),
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
}
