import 'package:flutter/material.dart';

class SelectedHotelProvider with ChangeNotifier {
  String? _selectedHotelId;

  String? get selectedHotelId => _selectedHotelId;
  
   void setSelectedHotelId(String id) {
    _selectedHotelId = id;
    notifyListeners(); // Notify listeners of the change
  }

  // void setSelectedHotelId(String? id) async {
  //   try {
  //     _selectedHotelId = id;
  //     notifyListeners();
  //   } catch (e) {
  //      print('Error setting selected hotel id: $e');
  //   }
  // }
}
