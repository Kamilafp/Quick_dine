import 'dart:convert';

import 'package:quick_dine/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

Future<int> getTotalMenu() async{
  String token = await getToken();
    final response = await http.get(Uri.parse('$menuURL/count'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if(response.statusCode==200){
      return json.decode(response.body)['total_menu'];
    }else{
      throw Exception('Failed to load menu count');
    }
}