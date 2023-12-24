import 'package:booking_lapangan/controller/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:booking_lapangan/controller/invoice_controller.dart';
// import 'package:booking_lapangan/model/invoice_model.dart';
import 'package:booking_lapangan/view/detail_invoice_page.dart';

class BookingInvoice extends StatelessWidget {
  final BookingController controller;

  const BookingInvoice({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Invoice',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            const SizedBox(height: 16),
            for (var i = 0; i < controller.booking.length; i++)
              AnimationConfiguration.staggeredList(
                position: i,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailInvoicePage(
                                ticket: controller.booking[i]),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.indigo.withOpacity(0.8),
                                Colors.indigoAccent.withOpacity(0.6)
                              ],
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              '${controller.booking[i].eventName} - ${controller.booking[i].ticketType}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Date: ${controller.booking[i].eventDate.toLocal()}'),
                                Text(
                                    'Quantity: ${controller.booking[i].quantity}'),
                                Text(
                                    'Booking Price: \$${controller.booking[i].ticketPrice.toStringAsFixed(2)}'),
                                Text(
                                    'Total: \$${(controller.booking[i].quantity * controller.booking[i].bookingPrice).toStringAsFixed(2)}'),
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              'Total Amount: \$${controller.calculateTotalAmount().toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add additional action here if needed
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
