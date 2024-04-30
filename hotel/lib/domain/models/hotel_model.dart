import 'package:hotel/domain/models/room_model.dart';

class Hotel {
  final String id;
  final String name;
  final String location;
  final String rating;
  final String imageUrl;
  final List<Room> rooms;

  Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.imageUrl,
    required this.rooms,
  });

  // Serialize data to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'name': name,
      'location': location,
      'rating': rating,
      'image': imageUrl,
      'rooms': rooms.map((room) => room.toJson()).toList(),
    };
  }

  // Deserialize JSON to data
  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      rating: json['rating'].toString(),
      imageUrl: json['image'],
      rooms: List<Room>.from(json['rooms']?.map((room) => Room.fromJson(room))),
    );
  }
}
