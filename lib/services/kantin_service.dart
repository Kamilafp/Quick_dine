import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quick_dine/models/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quick_dine/constant.dart';
import '../models/core/kantin.dart';

Future<ApiResponse> getKantin() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(kantinURL),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
        if (response.statusCode == 200) {
      List<dynamic> dataKantin = jsonDecode(response.body)['kantin'];
      apiResponse.data = dataKantin.map((k) => Kantin.fromJson(k)).toList();
    } else if (response.statusCode == 401) {
      apiResponse.error = unauthorized;
    } else {
      apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> editKantin(int id, String namaKantin, int idKaryawan, String metodePembayaran, String noTelp) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(Uri.parse('$kantinURL/$id'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'nama_kantin': namaKantin,
      'id_karyawan': idKaryawan.toString(),
      'metode_pembayaran' : metodePembayaran,
      'no_telp' : noTelp,
    });
    print('Nama Kantin: $namaKantin');
    print('ID Karyawan: $idKaryawan');
    print('Metode Pembayaran: $metodePembayaran');
    print('No Telp: $noTelp');

    print('Status Code: ${response.statusCode}');

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch (e){
    apiResponse.error = serverError;
  }
  return apiResponse;
}


// Delete kantin
Future<ApiResponse> deleteKantin(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(Uri.parse('$kantinURL/$id'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch (e){
    apiResponse.error = serverError;
  }
  return apiResponse;
}


// Mengambil token dari SharedPreferences
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

Future<String> addKantin(String namaKantin, int idKaryawan, String metodePembayaran, String noTelp) async {
  String token = await getToken();
  final response = await http.post(
    Uri.parse(kantinURL),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode({
      'nama_kantin': namaKantin,
      'id_karyawan': idKaryawan,
      'metode_pembayaran' : metodePembayaran,
      'no_telp' : noTelp,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['message'];
  } else {
    throw Exception('Failed to add Kantin');
  }
}


// Future<List<dynamic>> fetchUsers() async {
//   final response = await http.get(Uri.parse(userURL));
//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     return data['users'];
//   } else {
//     throw Exception('Failed to load users');
//   }
// }

// Future<void> fetchKantin() async {
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     String token=await getToken();
//     final response = await http.get(Uri.parse(kantinURL),
//         headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
//         if (response.statusCode == 200) {
//         final data = json.decode(response.body)['kantin'] as List;
//         setState(() {
//           kantins = data.map((item) => Map<String, dynamic>.from(item)).toList();
//           isLoading = false;
//         });
//       } else {
//         throw Exception('Failed to load kantin');
//       }
//   } catch (e) {
//     apiResponse.error = serverError;
//   }
// }

Future<int> getTotalkantin() async{
  String token = await getToken();
    final response = await http.get(Uri.parse('$kantinURL/count'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if(response.statusCode==200){
      return json.decode(response.body)['total_kantin'];
    }else{
      throw Exception('Failed to load kantin count');
    }
}

Future<List<Map<String, dynamic>>> fetchKantin() async {
  String token = await getToken();
  final response = await http.get(Uri.parse(kantinURL), headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });
  if (response.statusCode == 200) {
    final data = json.decode(response.body)['kantin'] as List;
    return data.map((item) => Map<String, dynamic>.from(item)).toList();
  } else {
    throw Exception('Failed to load kantin');
  }
}

