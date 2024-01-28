import 'package:flutter/material.dart';
import 'package:booking_lapangan/bloc/lapangan_bloc.dart';
import 'package:booking_lapangan/model/lapangan.dart';
import 'package:booking_lapangan/ui/lapangan_page.dart';
import 'package:booking_lapangan/widget/warning_dialog.dart';

class LapangForm extends StatefulWidget {
  Lapang? lapang;

  LapangForm({Key? key, this.lapang}) : super(key: key);

  @override
  _LapangFormState createState() => _LapangFormState();
}

class _LapangFormState extends State<LapangForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH TRANSAKSI";
  String tombolSubmit = "SIMPAN";

  final _namaLapangTextboxController = TextEditingController();
  final _TanggalTextboxController = TextEditingController();
  final _jamMulaiTextboxController = TextEditingController();
  final _totalJamMainTextboxController = TextEditingController();
  final _nominalTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.lapang != null) {
      setState(() {
        judul = "UBAH BOOKING";
        tombolSubmit = "UBAH";
        _namaLapangTextboxController.text = widget.lapang!.namaLapang!;
        _TanggalTextboxController.text = widget.lapang!.Tanggal!;
        _jamMulaiTextboxController.text = widget.lapang!.jamMulai!;
        _totalJamMainTextboxController.text = widget.lapang!.totalJamMain!;
        _nominalTextboxController.text = widget.lapang!.nominal.toString();
      });
    } else {
      judul = "TAMBAH BOOKING";
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
                _namaLapangTextField(),
                _TanggalTextField(),
                _jamMulaiTextField(),
                _totalJamMainTextField(),
                _nominalTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Membuat Textbox Nama Lapang
  Widget _namaLapangTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Lapang"),
      keyboardType: TextInputType.text,
      controller: _namaLapangTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Lapang harus di isi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Tanggal Lapang
  Widget _TanggalTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Tanggal"),
      keyboardType: TextInputType.text,
      controller: _TanggalTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tanggal harus di isi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Jam Mulai
  Widget _jamMulaiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jam Mulai"),
      keyboardType: TextInputType.text,
      controller: _jamMulaiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jam Mulai harus di isi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Total Jam Main
  Widget _totalJamMainTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Total Jam Main"),
      keyboardType: TextInputType.text,
      controller: _totalJamMainTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Total Jam Main harus di isi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Nominal Lapang

  Widget _nominalTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nominal"),
      keyboardType: TextInputType.number,
      controller: _nominalTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nominal harus di isi";
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
              if (widget.lapang != null) {
                //kondisi update booking
                ubah();
              } else {
                //kondisi tambah booking
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
    Lapang createLapang = Lapang(id: null);
    createLapang.namaLapang = _namaLapangTextboxController.text;
    createLapang.Tanggal = _TanggalTextboxController.text;
    createLapang.jamMulai = _jamMulaiTextboxController.text;
    createLapang.totalJamMain = _totalJamMainTextboxController.text;
    createLapang.nominal =
        int.parse(_nominalTextboxController.text);
    LapangBloc.addLapang(lapang: createLapang).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const LapangPage()));
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
    Lapang updateLapang = Lapang(id: null);
    updateLapang.id = widget.lapang!.id;
    updateLapang.namaLapang = _namaLapangTextboxController.text;
    updateLapang.Tanggal = _TanggalTextboxController.text;
    updateLapang.jamMulai = _jamMulaiTextboxController.text;
    updateLapang.totalJamMain = _totalJamMainTextboxController.text;
    updateLapang.nominal =
        int.parse(_nominalTextboxController.text);
    LapangBloc.updateLapang(lapang: updateLapang).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const LapangPage(),
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
