// booking_view.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:booking_lapangan/model/booking_model.dart';
import 'package:booking_lapangan/controller/booking_controller.dart';

class BookingForm extends StatefulWidget {
  final BookingController controller;

  BookingForm({required this.controller});

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final TextEditingController _namaLapanganController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _jamMulaiController = TextEditingController();
  int _totalJamMain = 1;
  double _harga = 100000.0;

  @override
  void initState() {
    super.initState();
    _tanggalController.text = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _namaLapanganController,
              decoration: InputDecoration(
                labelText: 'Nama Lapangan',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _tanggalController,
              decoration: InputDecoration(
                labelText: 'Tanggal',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _jamMulaiController,
              decoration: InputDecoration(
                labelText: 'Jam Mulai',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text('Total Jam Main:'),
            Slider(
              value: _totalJamMain.toDouble(),
              onChanged: (value) {
                setState(() {
                  _totalJamMain = value.toInt();
                  _updateHarga();
                });
              },
              min: 1,
              max: 5,
              divisions: 4,
              label: '$_totalJamMain Jam',
            ),
            SizedBox(height: 16.0),
            Text('Harga: ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(_harga)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _saveBookingDetails();
              },
              child: Text('Save Booking Details'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateHarga() {
  if (_totalJamMain == 1) {
    _harga = 100000.0;
  } else if (_totalJamMain == 2) {
    _harga = 200000.0;
  } else if (_totalJamMain == 3) {
    _harga = 300000.0; // Harga untuk 3 jam main
  } else if (_totalJamMain == 4) {
    _harga = 400000.0; // Harga untuk 4 jam main
  } else if (_totalJamMain == 5) {
    _harga = 500000.0; // Harga untuk 5 jam main
  } else {
    _harga = 0.0; // Logika khusus untuk kasus lain
  }
}


  void _saveBookingDetails() {
    BookingDetails bookingDetails = BookingDetails(
      namaLapangan: _namaLapanganController.text,
      tanggal: DateTime.parse(_tanggalController.text),
      jamMulai: _jamMulaiController.text,
      totalJamMain: _totalJamMain,
      harga: _harga,
    );

    widget.controller.setBookingDetails(bookingDetails);

    _showConfirmationDialog();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Confirmation'),
          content: Text('Booking details saved successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}