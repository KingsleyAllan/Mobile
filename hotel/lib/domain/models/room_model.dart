class Room {
  final String id;
  final String hotelId;// Reference to the hotel it belongs to
  final String name;
  final String type;
  final String headline;
  final String details;
  final int size;
  final double capacity;
  final String location;
  final bool extraBed;
  final String amenities;
  final double rate;
  final bool isAvailable;
  final String imageUrl;

  Room({
    required this.id,
    required this.hotelId,
    required this.name,
    required this.type,
    required this.headline,
    required this.details,
    required this.size,
    required this.capacity,
    required this.location,
    required this.extraBed,
    required this.amenities,
    required this.rate,
    required this.isAvailable,
    required this.imageUrl,
  });

  //serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hotel_id': hotelId,
      'name': name,
      'type': type,
      "headline": headline,
      "details": details,
      "size": size,
      "capacity": capacity,
      "location": location,
      "extra_bed": extraBed,
      "amenities": amenities,
      'rate': rate,
      'isAvailable': isAvailable,
      'image': imageUrl,
    };
  }

  //deserialize to data
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      hotelId: json['hotel_id'],
      name: json['name'],
      type: json['type'],
      headline: json['headline'],
      details: json['details'],
      size: json['size'] as int,
      capacity: json['capacity'] as double,
      location: json['location'],
      extraBed: json['extra_bed'],
      amenities: json['amenities'],
      rate: json['rate'] as double,
      isAvailable: json['isAvailable'],
      imageUrl: json['image'],
    );
  }
}
