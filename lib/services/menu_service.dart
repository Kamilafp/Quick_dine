import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:quick_dine/models/api_response.dart';
import 'package:quick_dine/models/core/menu.dart';
import 'package:quick_dine/constant.dart';
import 'package:quick_dine/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';




Future<ApiResponse> getAllMenu(int idKantin) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('$kantinURL/$idKantin/menu'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Jika permintaan berhasil, decode data JSON
      final Map<String, dynamic> data = json.decode(response.body);
      print(data);
      // Mengambil daftar menu dari data
      List<dynamic> menuList = data['menu'];
      // Mengembalikan data yang sudah dipetakan ke dalam model Menu
      apiResponse.data = menuList.map((item) => Menu.fromJson(item)).toList();
  } else {
    apiResponse.error= 'Failed to load menu: ${response.statusCode}';
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
      Uri.parse('$kantinURL/$idKantin/menu/count'),
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

Future<File?> pickImage() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    return File(image.path);
  }
  return null;
}

Future<void> uploadImage(File imageFile) async {
  final uri = Uri.parse('https://yourapi.com/upload'); // Replace with your API URL
  var request = http.MultipartRequest('POST', uri);

  // Add the image file to the request
  request.files.add(
    await http.MultipartFile.fromPath(
      'file', // The name of the field in the API
      imageFile.path,
    ),
  );
  var response = await request.send();

  if (response.statusCode == 200) {
    print('Image uploaded successfully');
  } else {
    print('Failed to upload image: ${response.statusCode}');
  }
}

Future<ApiResponse> createMenu(
    int idKantin, Menu menu, File? imageFile) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    var request = http.MultipartRequest(
        'POST', Uri.parse('$kantinURL/$idKantin/menu'));

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
    int idKantin, int id, Menu menu, File? imageFile) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    var request = http.MultipartRequest(
        'PUT', Uri.parse('$kantinURL/$idKantin/menu/${menu.id}'));

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
Future<ApiResponse> deleteMenu(int idKantin, int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(
      Uri.parse('$kantinURL/$idKantin/menu/$id'),
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

Future<List<Map<String, dynamic>>> fetchMenu(int idKantin) async {
  String token = await getToken();
  final response = await http.get(Uri.parse('$kantinURL/$idKantin/menu'), headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });
  if (response.statusCode == 200) {
    final data = json.decode(response.body)['menu'] as List;
    return data.map((item) => Map<String, dynamic>.from(item)).toList();
  } else {
    throw Exception('Failed to load menu');
  }
}



