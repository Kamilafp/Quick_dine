import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:quick_dine/models/api_response.dart';
import 'package:quick_dine/models/core/menu.dart';
import 'package:quick_dine/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}
Future<ApiResponse> getAllMenu(int idKantin) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('$baseURL/kantin/$idKantin/menu'), // URL dinamis
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    switch (response.statusCode) {
      case 200:
      // Mapping respons ke model Menu
        apiResponse.data = (jsonDecode(response.body)['menu'] as List)
            .map((p) => Menu.fromJson(p))
            .toList();
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print("Error: $e"); // Debug error
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<int> getTotalMenu(int idKantin) async {
  String token = await getToken();
  try {
    final response = await http.get(
      Uri.parse('$baseURL/kantin/$idKantin/menu/count'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['total_menu'];
    } else {
      throw Exception('Failed to load menu count');
    }
  } catch (e) {
    print("Error: $e");
    throw Exception('Failed to load menu count');
  }
}

