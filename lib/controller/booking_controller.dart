// controller.dart
import 'package:booking_lapangan/model/booking_model.dart';
import 'package:meta/meta.dart';

@immutable
class BookingController {
  late BookingDetails _bookingDetails;

  void setBookingDetails(BookingDetails bookingDetails) {
    _bookingDetails = bookingDetails;
  }

  BookingDetails getBookingDetails() {
    return _bookingDetails;
  }
}