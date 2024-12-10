import 'package:hungry/models/core/menu.dart'; // Asumsikan ini adalah file Menu sebelumnya

class MenuHelper {
  // Metode untuk mengonversi JSON ke objek Menu
  static Menu fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'] ?? '',
      idRuko: json['idRuko'] ?? '',
      nama: json['nama'] ?? '',
      harga: (json['harga'] ?? 0).toDouble(),
      deskripsi: json['deskripsi'] ?? '',
      foto: json['foto'] ?? '',
    );
  }

  // Metode untuk mengonversi objek Menu ke Map
  static Map<String, dynamic> toMap(Menu menu) {
    return {
      'id': menu.id,
      'idRuko': menu.idRuko,
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

  static List<Menu> getMenuByRukoId(int idRuko) {
    List<Menu> allMenus = contohMenu();
    print('ID Ruko diterima: $idRuko');
    print('Semua Menu: ${allMenus.map((menu) => menu.toJson()).toList()}');
    
    var filteredMenus = allMenus.where((menu) => menu.idRuko.toString() == idRuko.toString()).toList();
    print('Filtered Menu: ${filteredMenus.map((menu) => menu.toJson()).toList()}');
    
    return filteredMenus;
  }

  // Menambahkan contoh data menu
  static List<Menu> contohMenu() {
    List<Map<String, dynamic>> jsonList = [
      {
        'id': '1',
        'idRuko': '1',
        'nama': 'Nasi Goreng',
        'harga': 15000,
        'deskripsi': 'Nasi goreng spesial dengan telur dan ayam.',
        'foto': 'assets/images/nasgor.jpg',
      },
      {
        'id': '2',
        'idRuko': '2',
        'nama': 'Mie Goreng',
        'harga': 13000,
        'deskripsi': 'Mie goreng pedas dengan sayuran.',
        'foto': 'assets/images/migoreng.jpg',
      },
    ];

    return listFromJson(jsonList);
  }
}