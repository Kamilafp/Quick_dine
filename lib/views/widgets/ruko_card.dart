import 'package:flutter/material.dart';
import 'package:hungry/models/core/ruko.dart'; // Pastikan Ruko class diimport dengan benar

class RukoCard extends StatelessWidget {
  final Ruko ruko;

  RukoCard({required this.ruko});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(Icons.store, size: 50), // Placeholder icon untuk ruko
        title: Text(ruko.namaRuko),
        subtitle: Text('Metode Pembayaran: ${ruko.metodePembayaran}\nNo. Telp: ${ruko.noTelp}'),
        isThreeLine: true, // Mengatur teks subtitle agar bisa memuat lebih dari 1 baris
      ),
    );
  }
}
