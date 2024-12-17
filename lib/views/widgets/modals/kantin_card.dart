import 'package:flutter/material.dart';
import 'package:quick_dine/models/core/kantin.dart'; // Pastikan Ruko class diimport dengan benar

class KantinCard extends StatelessWidget {
  final Kantin kantin;

  KantinCard({required this.kantin});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(Icons.store, size: 50), // Placeholder icon untuk kantin
        title: Text(kantin.namaKantin),
        subtitle: Text('Metode Pembayaran: ${kantin.metodePembayaran}\nNo. Telp: ${kantin.noTelp}'),
        isThreeLine: true, // Mengatur teks subtitle agar bisa memuat lebih dari 1 baris
      ),
    );
  }
}
