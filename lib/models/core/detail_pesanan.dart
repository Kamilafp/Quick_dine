class DetailPesanan {
  final int id;
  final int idPesanan;
  final int idMenu;
  final int jumlah;
  final int subtotal;

  DetailPesanan({
    required this.id,
    required this.idPesanan,
    required this.idMenu,
    required this.jumlah,
    required this.subtotal,
  });

  factory DetailPesanan.fromJson(Map<String, dynamic> json) {
    return DetailPesanan(
      id: json['id'],
      idPesanan: json['id_pesanan'],
      idMenu: json['id_menu'],
      jumlah: json['jumlah'],
      subtotal: json['subtotal'],
    );
  }
}