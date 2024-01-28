import 'package:flutter/material.dart';
import 'package:booking_lapangan/model/lapangan.dart';
import 'package:booking_lapangan/ui/lapangan_detail.dart';
import 'package:booking_lapangan/ui/lapangan_form.dart';

import '../bloc/logout_bloc.dart';
import '../bloc/lapangan_bloc.dart';
import 'login_page.dart';

class LapangPage extends StatefulWidget {
  const LapangPage({Key? key}) : super(key: key);

  @override
  _LapangPageState createState() => _LapangPageState();
}

class _LapangPageState extends State<LapangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Booking Lapang'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LapangForm()));
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
        future: LapangBloc.getLapangs(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListLapang(
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

class ListLapang extends StatelessWidget {
  final List? list;

  const ListLapang({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemLapang(
            lapang: list![i],
          );
        });
  }
}

class ItemLapang extends StatelessWidget {
  final Lapang lapang;

  const ItemLapang({Key? key, required this.lapang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LapangDetail(
                      lapang: lapang,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(lapang.namaLapang!),
          subtitle: Text(lapang.nominal.toString()),
        ),
      ),
    );
  }
}
