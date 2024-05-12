import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel/domain/models/hotel_model.dart';

// Class that will handle hotel data
class HotelService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetching Hotels data from the firestore database
  Future<List<Hotel>> getHotels() async {
    QuerySnapshot snapshot = await _firestore.collection('hotels').get();

    return snapshot.docs.map((doc) => Hotel.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  //add a new hotel to the Firestore database
  Future<void> addHotel(Hotel hotel) async {
    await _firestore.collection('hotels').add(hotel.toJson());
  }

  //update a hotel in the Firestore database by passing the hotel object with a matching id
  Future<void> updateHotel(Hotel hotel) async {
    await _firestore
        .collection('hotels')
        .doc(hotel.id.toString())
        .update(hotel.toJson());
  }

  //delete a hotel from the Firestore database by passing the hotel id
  Future<void> deleteHotel(String hotelId) async {
    await _firestore.collection('hotels').doc(hotelId).delete();
  }

//set the hotels in the Firestore database by passing a list of hotels
//similar to seeding a db in Laravel using a factory class
  Future<void> setHotels(List<Hotel> hotels) async {
    // Clear existing data
    QuerySnapshot snapshot = await _firestore.collection('hotels').get();
    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }

    // Add dummy data
    for (Hotel hotel in hotels) {
      await _firestore.collection('hotels').add(hotel.toJson());
    }
  }
}
