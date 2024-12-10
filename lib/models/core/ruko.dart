class Ruko {
  String id; // Tambahkan idRuko
  String namaRuko;
  String metodePembayaran;
  String noTelp;
  String gambarRuko;

  Ruko({
    required this.id, // Tambahkan id sebagai parameter yang diperlukan
    required this.namaRuko,
    required this.metodePembayaran,
    required this.noTelp,
    required this.gambarRuko,
  });

  factory Ruko.fromJson(Map<String, dynamic> json) {
    return Ruko(
      id: json['id'] ?? '', // Ambil nilai id dari JSON
      namaRuko: json['namaRuko'] ?? '',
      metodePembayaran: json['metodePembayaran'] ?? '',
      noTelp: json['noTelp'] ?? '',
      gambarRuko: json['gambarRUko'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Sertakan id di dalam Map
      'namaRuko': namaRuko,
      'metodePembayaran': metodePembayaran,
      'noTelp': noTelp,
      'gambarRuko': gambarRuko,
    };
  }
}
