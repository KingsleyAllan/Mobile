import 'package:flutter/material.dart';
import 'package:hotel/providers/guest_count.dart';

class GuestCountProvider extends ChangeNotifier {
  GuestCount _guestCount = const GuestCount(adults: 1, children: 0);

  GuestCount get guestCount => _guestCount;

  void setGuestCount(int adults, int children) {
    _guestCount = GuestCount(adults: adults, children: children);
    notifyListeners();
  }

  void incrementAdults() {
    _guestCount = GuestCount(
        adults: _guestCount.adults + 1, children: _guestCount.children);
    notifyListeners();
  }

  void decrementAdults() {
    if (_guestCount.adults > 1) {
      _guestCount = GuestCount(
          adults: _guestCount.adults - 1, children: _guestCount.children);
      notifyListeners();
    }
  }

  void incrementChildren() {
    _guestCount = GuestCount(
        adults: _guestCount.adults, children: _guestCount.children + 1);
    notifyListeners();
  }

  void decrementChildren() {
    if (_guestCount.children > 0) {
      _guestCount = GuestCount(
          adults: _guestCount.adults, children: _guestCount.children - 1);
      notifyListeners();
    }
  }
}
