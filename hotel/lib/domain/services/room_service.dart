import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel/domain/models/room_model.dart';

class RoomService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a room to a hotel
  Future<void> addRoom(Room room) async {
    await _firestore.collection('rooms').add(room.toJson());
  }

  // Fetching rooms from Firestore database
  Future<List<Room>> getRoomsByHotel(String hotelId) async {
    // Check for empty or null hotelId
    // ignore: unnecessary_null_comparison
    if (hotelId == null || hotelId.isEmpty) {
      throw Exception('Invalid hotel ID (empty string)');
    }

    try {
      // Fetch Hotel document based on hotelId
      DocumentSnapshot hotelSnapshot = await _firestore.collection('hotels').doc(hotelId).get();

      // // Check if the hotel document exists
      // if (!hotelSnapshot.exists) {
      //   throw Exception('Hotel does not exist');
      // }

      // // Extract the hotelId
      String hotelDocId = hotelSnapshot.id;

      // Fetch rooms based on hotelId
      QuerySnapshot snapshot = await _firestore
      .collection('rooms')
      .where('hotel_id', isEqualTo: hotelDocId)
      .get();

      // Convert documents to Room objects
      return snapshot.docs
      .map((doc) => Room.fromJson(doc.data() as Map<String, dynamic>))
      .toList();
    } catch (e) {
      // Handle potential exceptions (e.g., network errors)
      print('Error fetching rooms: $e');
      return []; // Or throw a specific exception based on the error type
    }
  }

  // Future<List<Room>> getRoomDetails(String id) async {
  //   try {
  //     DocumentSnapshot snapshot = await _firestore.collection('rooms').doc(id).get();
  //     if (snapshot.exists) {
  //       return Room.fromJson(snapshot.data() as Map<String, dynamic>);
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching room details: $e');
  //   }
  // }

  // Update a room in Firestore by passing the room object with a matching id
  // Future<void> updateRoom(Room room) async {
  //   await _firestore.collection('rooms').doc(room.id).update(room.toJson());
  // }

  // Delete a room from Firestore by passing the room ID
  // Future<void> deleteRoom(String roomId) async {
  //   await _firestore.collection('rooms').doc(roomId).delete();
  // }
}