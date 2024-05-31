import 'package:flutter/material.dart';
import 'package:hotel/providers/room_count.dart';

class RoomCountProvider extends ChangeNotifier {
  RoomCount _roomCount = const RoomCount(rooms: 1);


  RoomCount get roomCount => _roomCount;

  void setRoomCount(int rooms) {
    _roomCount = RoomCount(rooms: rooms);
    notifyListeners();
  }

  void incrementRooms() {
    _roomCount = RoomCount(rooms: _roomCount.rooms + 1);
    notifyListeners();
  }

  void decrementRooms() {
    if (_roomCount.rooms > 1) {
      _roomCount = RoomCount(rooms: _roomCount.rooms - 1);
    };
    notifyListeners();
  }
}
