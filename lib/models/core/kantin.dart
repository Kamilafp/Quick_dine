class Kantin {
  final int id;
  final String namaKantin;
  final int idKaryawan;
  final String namaKaryawan;
  final String metodePembayaran;
  final String noTelp;

  Kantin({
    required this.id,
    required this.namaKantin,
    required this.idKaryawan,
    required this.namaKaryawan,
    required this.metodePembayaran,
    required this.noTelp,
  });

  factory Kantin.fromJson(Map<String, dynamic> json){
    return Kantin(
      id: json['id'],
      namaKantin: json['nama_kantin'],
      idKaryawan: json['id_karyawan'],
      namaKaryawan: json['user']['name'],
      metodePembayaran: json['metode_pembayaran'],
      noTelp: json['no_telp']
    );
  }
}

