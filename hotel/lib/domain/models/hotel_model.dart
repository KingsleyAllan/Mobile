class Hotel {
  final String id;
  final String name;
  final String continent;
  final String location;
  final String description;
  final double rating;
  final String imageUrl;

  Hotel({
    required this.id,
    required this.name,
    required this.continent,
    required this.location,
    required this.description,
    required this.rating,
    required this.imageUrl,
  });

  // Serialize data to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'name': name,
      'continent': continent,
      'location': location,
      'description': description,
      'rating': rating,
      'image': imageUrl,
    };
  }

  // Deserialize JSON to data
  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      continent: json['continent'],
      location: json['location'],
      description: json['description'] ?? "",
      rating: json['rating'],
      imageUrl: json['image'],
    );
  }
}
