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
      Uri.parse('$baseURL/kantin/$idKantin/menu'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    switch (response.statusCode) {
      case 200:
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
Future<ApiResponse> createMenu(
    int idKantin, Menu menu, File? imageFile) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseURL/kantin/$idKantin/menu'));

    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    request.fields['nama_menu'] = menu.nama;
    request.fields['deskripsi'] = menu.deskripsi ?? '';
    request.fields['harga'] = menu.harga.toString();
    request.fields['stok'] = menu.stok.toString();

    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print("Error: $e");
    apiResponse.error = serverError;
  }
  return apiResponse;
}
Future<ApiResponse> updateMenu(
    int idKantin, Menu menu, File? imageFile) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    var request = http.MultipartRequest(
        'PUT', Uri.parse('$baseURL/kantin/$idKantin/menu/${menu.id}'));

    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    request.fields['nama_menu'] = menu.nama;
    request.fields['deskripsi'] = menu.deskripsi ?? '';
    request.fields['harga'] = menu.harga.toString();
    request.fields['stok'] = menu.stok.toString();

    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print("Error: $e");
    apiResponse.error = serverError;
  }
  return apiResponse;
}
Future<ApiResponse> deleteMenu(int idKantin, String menuId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(
      Uri.parse('$baseURL/kantin/$idKantin/menu/$menuId'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print("Error: $e");
    apiResponse.error = serverError;
  }
  return apiResponse;
}


