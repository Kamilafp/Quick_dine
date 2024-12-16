import 'package:quick_dine/models/core/ruko.dart';

class RukoHelper {
  // Metode untuk mengonversi JSON ke objek Ruko
  static Ruko fromJson(Map<String, dynamic> json) {
    return Ruko(
      id: json['id'] ?? '',
      namaRuko: json['namaRuko'] ?? '',
      metodePembayaran: json['metodePembayaran'] ?? '',
      noTelp: json['noTelp'] ?? '',
      gambarRuko: json['gambarRuko'] ?? '',
    );
  }

  // Metode untuk mengonversi objek Ruko ke Map
  static Map<String, dynamic> toMap(Ruko ruko) {
    return {
      'id': ruko.id,
      'namaRuko': ruko.namaRuko,
      'metodePembayaran': ruko.metodePembayaran,
      'noTelp': ruko.noTelp,
      'gambarRuko': ruko.gambarRuko,
    };
  }

  // Metode untuk mengonversi daftar JSON ke daftar objek Ruko
  static List<Ruko> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }

  // Metode untuk mengonversi daftar objek Ruko ke daftar Map
  static List<Map<String, dynamic>> listToMap(List<Ruko> rukoList) {
    return rukoList.map((ruko) => toMap(ruko)).toList();
  }

  // Menambahkan contoh data ruko
  static List<Ruko> contohRuko() {
    List<Map<String, dynamic>> jsonList = [
      {
        'id': '1',
        'namaRuko': 'Ruko Serba Ada',
        'metodePembayaran': 'Tunai, Kartu Kredit',
        'noTelp': '081234567890',
        'gambarRuko': 'assets/images/kantin2.png'
      },
      {
        'id': '2',
        'namaRuko': 'Ruko Sinar Jaya',
        'metodePembayaran': 'Tunai, Transfer Bank',
        'noTelp': '082345678901',
        'gambarRuko': 'assets/images/kantin2.png',
      },
    ];

    return listFromJson(jsonList);
  }
}
