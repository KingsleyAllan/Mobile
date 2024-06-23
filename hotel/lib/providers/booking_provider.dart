import 'package:firebase_auth/firebase_auth.dart';
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

  Future<List<Booking>> getBookingByUser(String userId) async {
    try {
      _booking = await _bookingService.getBookingByUser(userId);
      notifyListeners();
      return _booking; // Return the list of bookings
    } catch (e) {
      print('Error getting booking by user: $e');
      return []; // Return an empty list on error
    }
  }

  List<Booking> getBookingsForCurrentUser() {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId != null && _booking.isNotEmpty) {
      return _booking.where((booking) => booking.userId == currentUserId).toList();
    } else {
      return []; // Return empty list if no user ID or no bookings available
    }
  }
}
