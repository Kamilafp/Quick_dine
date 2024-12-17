class Pesanan {
  final int id;
  final int idUser ;
  final int idKantin;
  final int total;
  final String status;
  final String diantarDiambil;
  final String? lokPengantaran;
  final String metodePembayaran;

  Pesanan({
    required this.id,
    required this.idUser ,
    required this.idKantin,
    required this.total,
    required this.status,
    required this.diantarDiambil,
    this.lokPengantaran,
    required this.metodePembayaran,
  });

  factory Pesanan.fromJson(Map<String, dynamic> json) {
    return Pesanan(
      id: json['id'],
      idUser:  json['user']['id_user'],
      idKantin: json['kantin']['id_kantin'],
      total: json['total'],
      status: json['status'],
      diantarDiambil: json['diantar_diambil'],
      lokPengantaran: json['lok_pengantaran'],
      metodePembayaran: json['metode_pembayaran'],
    );
  }
}

// class Order {
//   String id;
//   String idRuko;
//   String idUser;
//   String idTransaksi;
//   String produk;
//   int jumlah;
//   String status;
//   String catatan;

//   Order({
//     required this.id,
//     required this.idRuko,
//     required this.idUser,
//     required this.idTransaksi,
//     required this.produk,
//     required this.jumlah,
//     required this.status,
//     required this.catatan,
//   });

//   // Factory untuk membuat objek Order dari JSON
//   factory Order.fromJson(Map<String, dynamic> json) {
//     return Order(
//       id: json['id'] ?? '',
//       idRuko: json['idRuko'] ?? '',
//       idUser: json['idUser'] ?? '',
//       idTransaksi: json['idTransaksi'] ?? '',
//       produk: json['produk'] ?? '',
//       jumlah: json['jumlah'] ?? 0,
//       status: json['status'] ?? '',
//       catatan: json['catatan'] ?? '',
//     );
//   }

//   // Mengonversi objek Order menjadi Map
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'idRuko': idRuko,
//       'idUser': idUser,
//       'idTransaksi': idTransaksi,
//       'produk': produk,
//       'jumlah': jumlah,
//       'status': status,
//       'catatan': catatan,
//     };
//   }

//   // Mengonversi objek Order menjadi JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'idRuko': idRuko,
//       'idUser': idUser,
//       'idTransaksi': idTransaksi,
//       'produk': produk,
//       'jumlah': jumlah,
//       'status': status,
//       'catatan': catatan,
//     };
//   }
// }
