class Room {
  final String id;
  final String hotelId; // Reference to the hotel it belongs to
  final String type;
  final double rate;
  final bool isAvailable;

  Room({
    required this.id,
    required this.hotelId,
    required this.type,
    required this.rate,
    required this.isAvailable,
  });
  //serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hotel_id': hotelId,
      'type': type,
      'rate': rate,
      'isAvailable': isAvailable,
    };
  }

  //deserialize to data
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      hotelId: json['hotel_id'],
      type: json['type'],
      rate: json['rate'],
      isAvailable: json['isAvailable'],
    );
  }
}
