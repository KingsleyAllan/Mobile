import 'package:flutter/material.dart';

class SelectedHotelProvider with ChangeNotifier {
  String? _selectedHotelId;

  String? get selectedHotelId => _selectedHotelId;
  
   void setSelectedHotelId(String id) {
    _selectedHotelId = id;
    notifyListeners();
  }
}
