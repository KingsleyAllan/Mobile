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
    final QuerySnapshot = await _firestore
        .collection('hotels')
        .doc(hotelId)
        .collection('rooms')
        .get();
    return QuerySnapshot.docs.map((doc) => Room.fromJson(doc.data())).toList();
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
