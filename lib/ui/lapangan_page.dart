import 'package:flutter/material.dart';
import 'package:booking_lapangan/model/lapangan.dart';
import 'package:booking_lapangan/ui/lapangan_detail.dart';
import 'package:booking_lapangan/ui/lapangan_form.dart';

import '../bloc/logout_bloc.dart';
import '../bloc/lapangan_bloc.dart';
import 'login_page.dart';

class LapanganPage extends StatefulWidget {
  const LapanganPage({Key? key}) : super(key: key);

  @override
  _LapanganPageState createState() => _LapanganPageState();
}

class _LapanganPageState extends State<LapanganPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Lapangan Keuangan'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LapanganForm()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()))
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: LapanganBloc.getLapangans(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListLapangan(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListLapangan extends StatelessWidget {
  final List? list;

  const ListLapangan({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemLapangan(
            lapangan: list![i],
          );
        });
  }
}

class ItemLapangan extends StatelessWidget {
  final Lapangan lapangan;

  const ItemLapangan({Key? key, required this.lapangan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LapanganDetail(
                      lapangan: lapangan,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(lapangan.namaLapangan!),
          subtitle: Text(lapangan.nominalLapangan.toString()),
        ),
      ),
    );
  }
}
