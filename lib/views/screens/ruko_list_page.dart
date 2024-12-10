import 'package:flutter/material.dart';
import 'package:hungry/models/core/ruko.dart';
import 'package:hungry/models/helper/ruko_helper.dart'; // Helper untuk mendapatkan data ruko
import 'package:hungry/views/screens//list_ruko_card.dart'; // Widget untuk menampilkan kartu ruko

class RukoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ambil data ruko dari helper atau sumber data lainnya
    List<Ruko> rukoList = RukoHelper.contohRuko();

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Ruko'),
      ),
      body: rukoList.isEmpty
          ? Center(
            child: Text('Belum ada ruko yang tersedia.'),
          )
          : ListView.builder(
            itemCount: rukoList.length,
            padding: EdgeInsets.all(16),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ListRukoCard(data: rukoList[index]), // Menampilkan kartu ruko
              );
        },
      ),
    );
  }
}
