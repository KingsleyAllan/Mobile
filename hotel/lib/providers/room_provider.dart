import 'package:flutter/material.dart';
import 'package:hotel/domain/models/room_model.dart';
import 'package:hotel/domain/services/room_service.dart';

class RoomProvider extends ChangeNotifier {
  final RoomService _roomService = RoomService();

  // Initialize an empty list of rooms (consider state management solution for large apps)
  List<Room> _rooms = [];
  Room? _selectedRoom;
  String? selectedRoomId;

  // Getter for room list (consider using an unmodifiable list for safety)
  List<Room> get rooms => _rooms;
  Room? get selectedRoom => _selectedRoom;

  // Add a room
  Future<void> addRoom(Room room) async {
    try {
      await _roomService.addRoom(room);
      _rooms.add(room);
      notifyListeners();
    } catch (e) {
      print('Error adding hotel: $e');
    }
  }

  // Fetch all rooms for a specific hotel ID (consider using a state management solution and streams for real-time updates)
  Future<void> getRoomsByHotel(String hotelId) async {
    try {
      _rooms = await _roomService.getRoomsByHotel(hotelId);
      notifyListeners();
    } catch (e) {
      print('Error fetching rooms: $e');
    }
  }

  List<Room> getRoomsForSelectedHotel(String selectedHotelId) {
    return _rooms.where((room) => room.hotelId == selectedHotelId).toList();
  }

  // Future<void> getRoomDetails(String id) async {
  //   try {
  //     _rooms = await _roomService.getRoomDetails(id);
  //   } catch (e) {}
  // }
  // Update a room
  // Future<void> updateRoom(Room room) async {
  //   try {
  //     await _roomService.updateRoom(room);
  //     int index = _rooms.indexWhere((h) => h.id == room.id);
  //     if (index != -1) {
  //       _rooms[index] =
  //           room; // Update local list if found (optional if using state management)
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     print('Error updating room: $e');
  //   }
  // }

  // Delete a room
  // Future<void> deleteRoom(String roomId) async {
  //   try {
  //     await _roomService.deleteRoom(roomId);
  //     int index = _rooms.indexWhere((h) => h.id == roomId);
  //     if (index != -1) {
  //       _rooms.removeAt(
  //           index); // Remove from local list if found (optional if using state management)
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     print('Error deleting room: $e');
  //   }
  // }
}
