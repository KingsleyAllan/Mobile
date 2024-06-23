import 'package:flutter/material.dart';
import 'package:hotel/domain/models/booking_model.dart';
import 'package:hotel/providers/auth_provider.dart';
import 'package:hotel/providers/booking_provider.dart';
import 'package:provider/provider.dart';

class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  BookingProvider? bookingProvider;

  @override
  void initState() {
    super.initState();
    bookingProvider = BookingProvider();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String? userId = authProvider.user?.uid;

    // Update FutureBuilder to use List<Booking>
 return FutureBuilder<List<Booking>>(
  future: bookingProvider?.getBookingByUser(userId!),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final booking = snapshot.data![index];
            return ListTile(
              title: Text(booking.hotelName),
            );
          },
        );
      } else {
        return const Text('No Bookings Found');
      }
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  },
);


  }
}
