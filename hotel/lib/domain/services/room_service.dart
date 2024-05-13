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
     QuerySnapshot snapshot = await _firestore
        .collection('rooms')
        .where('hotelId', isEqualTo: hotelId)
        .get();
    return snapshot.docs.map((doc) => Room.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  // Update a room in Firestore by passing the room object with a matching id
  // Future<void> updateRoom(Room room) async {
  //   await _firestore.collection('rooms').doc(room.id).update(room.toJson());
  // }

  // Delete a room from Firestore by passing the room ID
  // Future<void> deleteRoom(String roomId) async {
  //   await _firestore.collection('rooms').doc(roomId).delete();
  // }
}
