import 'package:flutter/material.dart';
import 'package:booking_lapangan/bloc/lapangan_bloc.dart';
import 'package:booking_lapangan/model/lapangan.dart';
import 'package:booking_lapangan/ui/lapangan_form.dart';
import 'package:booking_lapangan/ui/lapangan_page.dart';
import 'package:booking_lapangan/widget/warning_dialog.dart';

class LapangDetail extends StatefulWidget {
  Lapang? lapang;

  LapangDetail({Key? key, this.lapang}) : super(key: key);

  @override
  _LapangDetailState createState() => _LapangDetailState();
}

class _LapangDetailState extends State<LapangDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Lapang'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Nama : ${widget.lapang!.namaLapang}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Tanggal : ${widget.lapang!.Tanggal}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "JamMulai : ${widget.lapang!.jamMulai}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "TotalJamMain : ${widget.lapang!.totalJamMain}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Nominal : Rp. ${widget.lapang!.nominal.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Tombol Edit
        OutlinedButton(
            child: const Text("EDIT"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LapangForm(
                            lapang: widget.lapang,
                          )));
            }),
        //Tombol Hapus
        OutlinedButton(
            child: const Text("DELETE"), onPressed: () => confirmHapus()),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Anda Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            int lapangId = widget.lapang!.id!;
            hapus(lapangId);
            Navigator.pop(context);
          },
        ),
        //tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }

  hapus(int id) {
    LapangBloc.deleteLapang(id: id).then((bool success) {
      if (success) {
        // Jika penghapusan berhasil, bisa tambahkan logika atau tindakan lainnya
        print("Booking berhasil dihapus");

        // Contoh: Navigasi ke halaman lain setelah penghapusan
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const LapangPage()));
      } else {
        // Jika penghapusan gagal, tampilkan pesan kesalahan
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Hapus gagal, silahkan coba lagi",
          ),
        );
      }
    });
  }
}
