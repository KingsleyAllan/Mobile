import 'package:flutter/material.dart';
import 'package:hotel/domain/models/room_model.dart';
import 'package:hotel/domain/services/room_service.dart';

class RoomProvider extends ChangeNotifier {
  final RoomService _roomService = RoomService();

  // Initialize an empty list of rooms (consider state management solution for large apps)
  final List<Room> _rooms = [];

  // Getter for room list (consider using an unmodifiable list for safety)
  List<Room> get rooms => _rooms;

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
      final fetchedRooms = await _roomService.getRoomsByHotel(hotelId);
      _rooms.replaceRange(0, 0, fetchedRooms); // Update local list
      notifyListeners();
    } catch (e) {
      print('Error fetching rooms: $e');
    }
  }

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
