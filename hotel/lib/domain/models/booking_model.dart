import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String id;
  final String userId;
  final String hotelName;
  final String roomName;
  final DateTime checkIn;
  final DateTime checkOut;
  final int numGuests;
  final double amountPaid;

  Booking({
    required this.id,
    required this.userId,
    required this.hotelName,
    required this.roomName,
    required this.checkIn,
    required this.checkOut,
    required this.numGuests,
    required this.amountPaid,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      'hotelName': hotelName,
      'roomName': roomName,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'numGuests': numGuests,
      'amountPaid': amountPaid,
    };
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['userId'],
      hotelName: ['hotelName'] as String,
      roomName: ['roomName'] as String,
      checkIn: (['checkIn'] as Timestamp).toDate(),
      checkOut: (['checkOut'] as Timestamp).toDate(),
      numGuests: ['numGuests'] as int,
      amountPaid: ['amountPaid'] as double,
    );
  }
}