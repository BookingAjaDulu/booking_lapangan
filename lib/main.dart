// main.dart
import 'package:flutter/material.dart';
import 'package:booking_lapangan/controller/booking_controller.dart';
import 'package:booking_lapangan/view/booking_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final BookingController _bookingController = BookingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookingForm(controller: _bookingController),
    );
  }
}