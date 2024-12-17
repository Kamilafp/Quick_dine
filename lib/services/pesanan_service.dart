import 'dart:convert';

import 'package:quick_dine/constant.dart';
import 'package:quick_dine/models/core/detail_pesanan.dart';
import 'package:quick_dine/models/core/pesanan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

Future<int> getTotalPesanan(int idKantin) async {
  String token = await getToken();
  try {
    final response = await http.get(
      Uri.parse('$baseURL/kantin/$idKantin/pesanan/count'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['total_pesanan'];
    } else {
      throw Exception('Failed to load menu count');
    }
  } catch (e) {
    print("Error: $e");
    throw Exception('Failed to load menu count');
  }
}

Future<void> addPesanan(Pesanan pesanan, List<DetailPesanan> detailPesanan) async {
  String token = await getToken();
  final response = await http.post(
    Uri.parse(pesananURL),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode({
      // 'id_user': idUser,
      // 'id_kantin': idKantin,
      // 'total': total,
      // 'status': status,
      // 'diantar_diambil': diantarDiambil,
      // 'lok_pengantaran': lokPengantaran,
      // 'metode_pembayaran': metodePembayaran,
      pesanan
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['message'];
  } else {
    throw Exception('Failed to add Pesanan');
  }
}