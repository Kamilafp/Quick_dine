import 'package:flutter/material.dart';
import 'package:hungry/models/core/ruko.dart';

class ListRukoCard extends StatelessWidget {
  final Ruko data; // Data ruko yang akan ditampilkan

  ListRukoCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Ruko
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                data.gambarRuko, // Path ke gambar
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12), // Jarak antara gambar dan teks
            // Informasi Ruko
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Ruko
                  Text(
                    data.namaRuko,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8), // Jarak antar elemen
                  // Detail tambahan
                  Text(
                    'Metode Pembayaran: ${data.metodePembayaran}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'No Telp: ${data.noTelp}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
