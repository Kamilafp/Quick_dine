class Order {
  String id;
  String idRuko;
  String idUser;
  String idTransaksi;
  String produk;
  int jumlah;
  String status;
  String catatan;

  Order({
    required this.id,
    required this.idRuko,
    required this.idUser,
    required this.idTransaksi,
    required this.produk,
    required this.jumlah,
    required this.status,
    required this.catatan,
  });

  // Factory untuk membuat objek Order dari JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      idRuko: json['idRuko'] ?? '',
      idUser: json['idUser'] ?? '',
      idTransaksi: json['idTransaksi'] ?? '',
      produk: json['produk'] ?? '',
      jumlah: json['jumlah'] ?? 0,
      status: json['status'] ?? '',
      catatan: json['catatan'] ?? '',
    );
  }

  // Mengonversi objek Order menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idRuko': idRuko,
      'idUser': idUser,
      'idTransaksi': idTransaksi,
      'produk': produk,
      'jumlah': jumlah,
      'status': status,
      'catatan': catatan,
    };
  }

  // Mengonversi objek Order menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idRuko': idRuko,
      'idUser': idUser,
      'idTransaksi': idTransaksi,
      'produk': produk,
      'jumlah': jumlah,
      'status': status,
      'catatan': catatan,
    };
  }
}
