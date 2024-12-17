import 'dart:convert';

import 'package:quick_dine/constant.dart';
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