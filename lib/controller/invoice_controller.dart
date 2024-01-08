import 'package:booking_lapangan/model/booking_model.dart';
import 'package:booking_lapangan/Data/data_booking.dart';

class InvoiceController {
  List<Ticket> tickets = [];
  final TicketRepository ticketRepository = TicketRepository();

  void loadTickets() {
    tickets = ticketRepository.getTickets();
  }

  double calculateTotalAmount() {
    double total = 0;
    for (var ticket in tickets) {
      total += ticket.quantity * ticket.ticketPrice;
    }
    return total;
  }
}
