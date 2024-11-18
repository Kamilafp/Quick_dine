import 'package:hungry/models/core/menu.dart'; // Asumsikan ini adalah file Menu sebelumnya

class MenuHelper {
  // Metode untuk mengonversi JSON ke objek Menu
  static Menu fromJson(Map<String, dynamic> json) {
    return Menu(
      nama: json['nama'] ?? '',
      harga: (json['harga'] ?? 0).toDouble(),
      deskripsi: json['deskripsi'] ?? '',
      foto: json['foto'] ?? '',
    );
  }

  // Metode untuk mengonversi objek Menu ke Map
  static Map<String, dynamic> toMap(Menu menu) {
    return {
      'nama': menu.nama,
      'harga': menu.harga,
      'deskripsi': menu.deskripsi,
      'foto': menu.foto,
    };
  }

  // Metode untuk mengonversi daftar JSON ke daftar objek Menu
  static List<Menu> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }

  // Metode untuk mengonversi daftar objek Menu ke daftar Map
  static List<Map<String, dynamic>> listToMap(List<Menu> menuList) {
    return menuList.map((menu) => toMap(menu)).toList();
  }

  // Menambahkan contoh data menu
  static List<Menu> contohMenu() {
    List<Map<String, dynamic>> jsonList = [
      {
        'nama': 'Nasi Goreng',
        'harga': 15000,
        'deskripsi': 'Nasi goreng spesial dengan telur dan ayam.',
        'foto': 'assets/images/nasgor.jpg',
      },
      {
        'nama': 'Mie Goreng',
        'harga': 13000,
        'deskripsi': 'Mie goreng pedas dengan sayuran.',
        'foto': 'assets/images/migoreng.jpg',
      },
    ];

    return listFromJson(jsonList);
  }
}
