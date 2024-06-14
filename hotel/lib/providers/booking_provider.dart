import 'package:flutter/material.dart';
import 'package:hotel/domain/models/booking_model.dart';
import 'package:hotel/domain/services/booking_service.dart';

class BookingProvider extends ChangeNotifier {
  final BookingService _bookingService = BookingService();

  List<Booking> _booking = [];

  List<Booking> get booking => _booking;

  Future<void> addBooking(Booking booking) async {
    try {
      await _bookingService.addBooking(booking);
      _booking.add(booking);
      notifyListeners();
    } catch (e) {
      print('Error booking a hotel: $e');
    }
  }
}
