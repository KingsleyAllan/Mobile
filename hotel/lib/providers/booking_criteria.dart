import 'package:hotel/providers/guest_count.dart';

class BookingData {
  final DateTime startDate;
  final DateTime endDate;
  final GuestCount guestCount;

  BookingData(this.startDate, this.endDate, this.guestCount);
}
