import 'package:flutter/material.dart';

class SelectedDate extends ChangeNotifier {
  DateTime? selectedDate;

  SelectedDate({this.selectedDate});

  Future<void> setSelectedDate(DateTime newDate) async {
    selectedDate = newDate;
    notifyListeners(); // Notify listeners about the change
  }
}
