class Menu {
  String id;
  String idRuko;
  String nama;
  double harga;
  String deskripsi;
  String foto;

  Menu({
    required this.id,
    required this.idRuko,
    required this.nama,
    required this.harga,
    required this.deskripsi,
    required this.foto,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'] ?? '',
      idRuko: json['idRuko'] ?? '',
      nama: json['nama'] ?? '',
      harga: (json['harga'] ?? 0).toDouble(),
      deskripsi: json['deskripsi'] ?? '',
      foto: json['foto'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idRuko': idRuko,
      'nama': nama,
      'harga': harga,
      'deskripsi': deskripsi,
      'foto': foto,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idRuko': idRuko,
      'nama': nama,
      'harga': harga,
      'deskripsi': deskripsi,
      'foto': foto,
    };
  }
}
