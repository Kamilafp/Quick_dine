class Kantin {
  final int id;
  final String namaKantin;
  final int idKaryawan;
  final String namaKaryawan;

  Kantin({
    required this.id,
    required this.namaKantin,
    required this.idKaryawan,
    required this.namaKaryawan
  });

  factory Kantin.fromJson(Map<String, dynamic> json) {
    return Kantin(
      id: json['id'],
      namaKantin: json['nama_kantin'],
      idKaryawan: json['id_karyawan'],
      namaKaryawan: json['user']['name']
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_kantin': namaKantin,
      'id_karyawan': idKaryawan,
      'nama_karyawan': namaKaryawan,
    };
  }
}

