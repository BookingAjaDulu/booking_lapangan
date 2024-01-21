import 'package:flutter/material.dart';
import 'package:booking_lapangan/model/booking_model.dart';

class DetailInvoicePage extends StatelessWidget {
  final Booking booking;

  const DetailInvoicePage({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Details',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Event Name', booking.eventName),
            _buildDetailRow(
                'Event Date', booking.eventDate.toLocal().toString()),
            const SizedBox(height: 16),
            Text(
              'Booking Details',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Booking Type', booking.bookingType),
            _buildDetailRow('Quantity', booking.quantity.toString()),
            _buildDetailRow('Booking Price',
                '\$${booking.bookingPrice.toStringAsFixed(2)}'),
            _buildDetailRow('Total Amount',
                '\$${(booking.quantity * booking.bookingPrice).toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
