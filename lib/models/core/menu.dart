class Menu {
  String id;
  String idKantin;
  String nama;
  int? harga;
  int? stok;
  String? deskripsi;
  String? image;

  Menu({
    required this.id,
    required this.idKantin,
    required this.nama,
    this.harga,
    this.stok,
    this.deskripsi,
    this.image,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      idKantin: json['id_kantin'],
      nama: json['nama_menu'],
      harga: (json['harga']),
      stok: (json['stok']),
      deskripsi: json['deskripsi'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
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
