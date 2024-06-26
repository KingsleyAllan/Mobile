import 'package:flutter/material.dart';
import 'package:hotel/domain/models/booking_model.dart';
import 'package:hotel/presentation/screens/home.dart';
import 'package:hotel/providers/auth_provider.dart';
import 'package:hotel/providers/booking_criteria.dart';
import 'package:hotel/providers/booking_provider.dart';
import 'package:hotel/providers/room_count_provider.dart';
import 'package:hotel/providers/selected_hotel_provider.dart';
import 'package:intl/intl.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class BookingConfirmation extends StatefulWidget {
  final BookingData bookingData;
  final String roomName;
  final double roomRate;
  final double roomCapacity;
  final String roomImage;
  final String roomHeadline;
  final String roomAmenities;

  const BookingConfirmation({
    super.key,
    required this.bookingData,
    required this.roomName,
    required this.roomRate,
    required this.roomCapacity,
    required this.roomImage,
    required this.roomHeadline,
    required this.roomAmenities,
  });

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  void _showRoomDetailsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Room Details",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.roomAmenities.split(',').map((amenity) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.check,
                        size: 20, color: Theme.of(context).primaryColor),
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
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Close",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalGuests = widget.bookingData.guestCount.adults +
        widget.bookingData.guestCount.children;
    final roomCountProvider = Provider.of<RoomCountProvider>(context);
    final nightsPerStay = Duration(
        days: widget.bookingData.endDate
            .difference(widget.bookingData.startDate)
            .inDays);
    final totalCostPerNight = widget.roomRate *
        nightsPerStay.inDays *
        roomCountProvider.roomCount.rooms;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.user?.uid;
    final selectedHotelProvider = Provider.of<SelectedHotelProvider>(context);
    final String hotelName = selectedHotelProvider.selectedHotelName;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).primaryColor,
        leading: const Icon(
          Icons.confirmation_number_sharp,
          color: Colors.white,
          size: 27,
        ),
        title: Text(
          'REVIEW BOOKING',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                children: [
                  Text(
                    'Check-in',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    DateFormat('dd MMM').format(widget.bookingData.startDate),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                  )
                ],
              ),
              Column(children: [
                Text(
                  'Check-out',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  DateFormat('dd MMM').format(widget.bookingData.endDate),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                )
              ]),
              Column(children: [
                Text(
                  'Guests',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  totalGuests.toString(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                )
              ])
            ]),
            const SizedBox(
              height: 8,
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.roomName,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      Text(
                        'USD ${widget.roomRate}/ night',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(children: [
                        const Icon(Icons.bed_sharp, size: 20),
                        const SizedBox(width: 2),
                        const Text(
                          'Extra Bed Available',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.person_outline_sharp, size: 20),
                        const SizedBox(width: 2),
                        Text(
                          'Sleeps ${widget.roomCapacity} guests',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ])
                    ]),
              ),
              Column(children: [
                ClipRRect(
                  child: Image.network(
                    widget.roomImage,
                    height: 80,
                    width: 144,
                    fit: BoxFit.cover,
                  ),
                ),
              ])
            ]),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.roomHeadline,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(children: [
              GestureDetector(
                onTap: _showRoomDetailsDialog,
                child: Text(
                  "WHAT'S INCLUDED",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 8,
              )
            ]),
            const SizedBox(
              height: 8,
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'POLICIES',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Guarantee Policy',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            Text(
              'Credit Card is required at the time of booking.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Cancellation Policy',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            Text(
              'Reservation must be cancelled by 3pm local time 1 day before arrival to avoid penalty of 1 night room and tax.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No. of Rooms',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove,
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      iconSize: 18.0,
                      onPressed: roomCountProvider.decrementRooms,
                    ),
                    SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: Center(
                        child: Text(
                          '${roomCountProvider.roomCount.rooms}',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 16.0,
                                  ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      iconSize: 18.0,
                      onPressed: roomCountProvider.incrementRooms,
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'USD ${widget.roomRate} x ${nightsPerStay.inDays} nights x ${roomCountProvider.roomCount.rooms} room(s)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  'USD $totalCostPerNight',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Taxes and fees',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  'USD 1512.0',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total USD',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  'USD $totalCostPerNight',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
           ElevatedButton(
  onPressed: () async {
    PayWithPayStack().now(
      context: context,
      secretKey: "sk_test_4fee4b862e26f8ba281c62b0fc5110d91895720e",
      customerEmail: authProvider.user!.email.toString(),
      reference: DateTime.now().microsecondsSinceEpoch.toString(),
      amount: "588",
      currency: "KES",
      transactionCompleted: () async {
        var uuid = const Uuid();
        String id = uuid.v4();

        Booking booking = Booking(
          userId: userId ?? "",
          hotelName: hotelName,
          roomName: widget.roomName,
          checkIn: widget.bookingData.startDate,
          checkOut: widget.bookingData.endDate,
          numGuests: totalGuests,
          amountPaid: totalCostPerNight,
          id: id,
        );

        context.read<BookingProvider>().addBooking(booking);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(
              title: '',
            ),
          ),
        );
      },
      transactionNotCompleted: () {
        print("Transaction Not Successful!");
      },
      callbackUrl: '',
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Theme.of(context).primaryColor,
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  ),
  child: Text(
    'PROCEED TO PAYMENT',
    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontSize: 12,
      color: Colors.white,
    ),
  ),
)
          ],
        ),
      ),
    );
  }
}

// var uuid = const Uuid();
//                 String id = uuid.v4();

//                 Booking booking = Booking(
//                     userId: userId ?? "",
//                     hotelName: hotelName,
//                     roomName: widget.roomName,
//                     checkIn: widget.bookingData.startDate,
//                     checkOut: widget.bookingData.endDate,
//                     numGuests: totalGuests,
//                     amountPaid: totalCostPerNight,
//                     id: id);

//                 context.read<BookingProvider>().addBooking(booking);

//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const MyHomePage(
//                         title: '',
//                       ),
//                     ));