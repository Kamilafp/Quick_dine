import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quick_dine/views/screens/menu_list_page.dart'; // Import halaman MenuListPage
import 'package:quick_dine/models/core/kantin.dart'; // Model Kantin

class FeaturedKantinCard extends StatelessWidget {
  final Kantin data; // Data Kantin yang akan ditampilkan

  FeaturedKantinCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke MenuListPage dengan mengoper idKantin
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MenuListPage(idKantin: data.id),
        ));
      },
      child: Container(
        width: 180,
        height: 220,
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // image: DecorationImage(
          //   image: AssetImage(data.gambarRuko), // Gambar ruko dari properti data
          //   fit: BoxFit.cover, // Mengatur agar gambar sesuai dengan ukuran card
          color: Colors.blue
          ),
        
        // Informasi Ruko
        
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Ruko
                  Text(
                    data.namaKantin,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'inter',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Metode pembayaran: ${data.metodePembayaran}', // Nama dari ruko
                    // maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'inter',
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Nomor Telepon: ${data.noTelp}', // Nama dari ruko
                    // maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'inter',
                    ),
                  ),
                ],
              ),
            ),
          );  }
}
