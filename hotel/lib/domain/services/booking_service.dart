import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel/domain/models/booking_model.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBooking(Booking booking) async {
    await _firestore.collection('bookings').add(booking.toJson());
  }
}
