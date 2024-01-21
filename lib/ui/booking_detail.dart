import 'package:flutter/material.dart';
import 'package:booking_lapangan/model/booking_model.dart';
import 'package:booking_lapangan/view/booking_form_form.dart';

class BookingDetail extends StatefulWidget {
  BookingDetails? bookingdetails;

  BookingDetail({Key? key, this.bookingdetails}) : super(key: key);

  @override
  _BookingDetailState createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tiket'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Kode : ${widget.bookingdetails!.namalapangan}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.bookingdetails!.tanggal}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${widget.bookingdetails!.jamMulai}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Keterangan : ${widget.bookingdetails!.totalJamMain}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Keterangan : ${widget.bookingdetails!.harga.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingForm(
                  produk: widget.produk!,
                ),
              ),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {},
        ),
        // Tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}