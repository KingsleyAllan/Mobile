import 'package:flutter/material.dart';

class SelectedHotelProvider with ChangeNotifier {
  String? _selectedHotelId;
  late String _selectedHotelName;

  String? get selectedHotelId => _selectedHotelId;
  String get selectedHotelName => _selectedHotelName;
  
   void setSelectedHotelId(String id) {
    _selectedHotelId = id;
    notifyListeners();
  }

  void setSelectedHotelName(String name) {
    _selectedHotelName = name;
    notifyListeners();
  }
}
