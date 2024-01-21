import 'package:flutter/material.dart';
import 'package:booking_lapangan/bloc/lapangan_bloc.dart';
import 'package:booking_lapangan/model/lapangan.dart';
import 'package:booking_lapangan/ui/lapangan_page.dart';
import 'package:booking_lapangan/widget/warning_dialog.dart';

class LapanganForm extends StatefulWidget {
  Lapangan? lapangan;

  LapanganForm({Key? key, this.lapangan}) : super(key: key);

  @override
  _LapanganFormState createState() => _LapanganFormState();
}

class _LapanganFormState extends State<LapanganForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH TRANSAKSI";
  String tombolSubmit = "SIMPAN";

  final _kodeLapanganTextboxController = TextEditingController();
  final _namaLapanganTextboxController = TextEditingController();
  final _nominalLapanganTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.lapangan != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _kodeLapanganTextboxController.text = widget.lapangan!.kodeLapangan!;
        _namaLapanganTextboxController.text = widget.lapangan!.namaLapangan!;
        _nominalLapanganTextboxController.text =
            widget.lapangan!.nominalLapangan.toString();
      });
    } else {
      judul = "TAMBAH TRANSAKSI";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeLapanganTextField(),
                _namaLapanganTextField(),
                _nominalLapanganTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Membuat Textbox Kode Lapangan
  Widget _kodeLapanganTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kode Lapangan"),
      keyboardType: TextInputType.text,
      controller: _kodeLapanganTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Lapangan harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Nama Lapangan
  Widget _namaLapanganTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Lapangan"),
      keyboardType: TextInputType.text,
      controller: _namaLapanganTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Lapangan harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Nominal Lapangan

  Widget _nominalLapanganTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nominal"),
      keyboardType: TextInputType.number,
      controller: _nominalLapanganTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nominal harus diisi";
        }

        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.lapangan != null) {
                //kondisi update produk
                ubah();
              } else {
                //kondisi tambah produk
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Lapangan createLapangan = Lapangan(id: null);
    createLapangan.kodeLapangan = _kodeLapanganTextboxController.text;
    createLapangan.namaLapangan = _namaLapanganTextboxController.text;
    createLapangan.nominalLapangan =
        int.parse(_nominalLapanganTextboxController.text);
    LapanganBloc.addLapangan(lapangan: createLapangan).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const LapanganPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Lapangan updateLapangan = Lapangan(id: null);
    updateLapangan.id = widget.lapangan!.id;
    updateLapangan.kodeLapangan = _kodeLapanganTextboxController.text;
    updateLapangan.namaLapangan = _namaLapanganTextboxController.text;
    updateLapangan.nominalLapangan =
        int.parse(_nominalLapanganTextboxController.text);
    LapanganBloc.updateLapangan(lapangan: updateLapangan).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const LapanganPage(),
      ));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
}
