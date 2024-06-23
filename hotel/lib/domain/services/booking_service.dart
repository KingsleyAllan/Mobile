import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel/domain/models/booking_model.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBooking(Booking booking) async {
    await _firestore.collection('bookings').add(booking.toJson());
  }

  Future<List<Booking>> getBookingByUser( userId) async {
     // ignore: unnecessary_null_comparison
    if (userId == null || userId.isEmpty) {
      throw Exception('Invalid hotel ID (empty string)');
    }

    try {
      DocumentSnapshot bookingSnapshot = await _firestore.collection('users').doc(userId).get();

      String bookingDocId = bookingSnapshot.id;

      QuerySnapshot snapshot = await _firestore
      .collection('bookings')
      .where('userId', isEqualTo: bookingDocId)
      .get();

      return snapshot.docs
      .map((doc) => Booking.fromJson(doc.data() as Map<String, dynamic>))
      .toList();

    } catch (e) {
      print('Error fetching bookings: $e');
      return []; 
    }
  }
}
