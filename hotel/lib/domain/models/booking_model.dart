import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String hotelName;
  final String roomName;
  final DateTime checkIn;
  final DateTime checkOut;
  final int numGuests;
  final double amountPaid;
  final DateTime timestamp;

  Booking({
    required this.hotelName,
    required this.roomName,
    required this.checkIn,
    required this.checkOut,
    required this.numGuests,
    required this.amountPaid,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'hotelName': hotelName,
      'roomName': roomName,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'numGuests': numGuests,
      'amountPaid': amountPaid,
      'timestamp': timestamp,
    };
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      hotelName: ['hotelName'] as String,
      roomName: ['roomName'] as String,
      checkIn: (['checkIn'] as Timestamp).toDate(),
      checkOut: (['checkOut'] as Timestamp).toDate(),
      numGuests: ['numGuests'] as int,
      amountPaid: ['amountPaid'] as double,
      timestamp: (['timestamp'] as Timestamp).toDate(),
    );
  }
}