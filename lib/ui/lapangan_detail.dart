import 'package:flutter/material.dart';
import 'package:booking_lapangan/bloc/lapangan_bloc.dart';
import 'package:booking_lapangan/model/lapangan.dart';
import 'package:booking_lapangan/ui/lapangan_form.dart';
import 'package:booking_lapangan/ui/lapangan_page.dart';
import 'package:booking_lapangan/widget/warning_dialog.dart';

class LapanganDetail extends StatefulWidget {
  Lapangan? lapangan;

  LapanganDetail({Key? key, this.lapangan}) : super(key: key);

  @override
  _LapanganDetailState createState() => _LapanganDetailState();
}

class _LapanganDetailState extends State<LapanganDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Lapangan'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Kode : ${widget.lapangan!.kodeLapangan}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.lapangan!.namaLapangan}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Nominal : Rp. ${widget.lapangan!.nominalLapangan.toString()}",
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
                      builder: (context) => LapanganForm(
                            lapangan: widget.lapangan,
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
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            int lapanganId = widget.lapangan!.id!;
            hapus(lapanganId);
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
    LapanganBloc.deleteLapangan(id: id).then((bool success) {
      if (success) {
        // Jika penghapusan berhasil, bisa tambahkan logika atau tindakan lainnya
        print("Lapangan berhasil dihapus");

        // Contoh: Navigasi ke halaman lain setelah penghapusan
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const LapanganPage()));
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
