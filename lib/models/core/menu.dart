import 'package:quick_dine/constant.dart';

class Menu {
  final int id;
  final int idKantin;
  final String nama;
  final int harga;
  final int stok;
  final String? deskripsi;
  final String? image;

  Menu({
    required this.id,
    required this.idKantin,
    required this.nama,
    required this.harga,
    required this.stok,
    this.deskripsi,
    this.image,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      idKantin: json['id_kantin'],
      nama: json['nama_menu'],
      harga: json['harga'],
      stok: json['stok'],
      deskripsi: json['deskripsi'] ?? '',
      // image: json['image'] != null ? '$baseURL/storage/${json['image']}' : null,
      image: json['image']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_kantin': idKantin,
      'nama_menu': nama,
      'stok': stok,
      'harga': harga,
      'deskripsi': deskripsi,
      'image': image,
    };
  }
}
