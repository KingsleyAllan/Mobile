import 'package:flutter/material.dart';
import 'package:hotel/domain/models/room_model.dart';

class RoomDetails extends StatelessWidget {
  final Room room;

  const RoomDetails({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ROOM DETAILS',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              room.name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            const SizedBox(height: 8.0),
            ClipRRect(
              child: Image.network(
                room.imageUrl,
                height: 216,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Error loading image'));
                },
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Sleeps ${room.capacity} guests',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Divider(
              color: Theme.of(context).primaryColor,
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            const SizedBox(height: 8.0),
            Text(
              room.headline,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'SIZE: ${room.size} square feet',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
              )
            ),
            const SizedBox(height: 8.0),
            Text(
              'LOCATION: floors ${room.location}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
              )
            ),
            const SizedBox(height: 8.0),
            Text(
              'EXTRA BED: ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
              )
            ),
            const SizedBox(height: 16.0,),
            Text(
              room.details,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'SERVICES & AMENITIES',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: room.amenities.split(',').map((amenity) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.check, size: 20, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          amenity.trim(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
