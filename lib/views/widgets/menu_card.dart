import 'package:flutter/material.dart';
import 'package:hungry/models/core/menu.dart'; // Pastikan Menu class diimport dengan benar

class MenuCard extends StatelessWidget {
  final Menu menu;

  MenuCard({required this.menu});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Image.asset(menu.foto, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(menu.nama),
        subtitle: Text(menu.deskripsi),
        trailing: Text('Rp ${menu.harga.toString()}'),
      ),
    );
  }
}
