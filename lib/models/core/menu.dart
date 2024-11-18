class Menu {
  String nama;
  double harga;
  String deskripsi;
  String foto;

  Menu({
    required this.nama,
    required this.harga,
    required this.deskripsi,
    required this.foto,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      nama: json['nama'] ?? '',
      harga: (json['harga'] ?? 0).toDouble(),
      deskripsi: json['deskripsi'] ?? '',
      foto: json['foto'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'harga': harga,
      'deskripsi': deskripsi,
      'foto': foto,
    };
  }
}
