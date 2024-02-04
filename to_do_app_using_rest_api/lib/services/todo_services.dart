import 'dart:convert';

import 'package:http/http.dart' as http;

class TodoService {
  static Future<bool> deleteById(String id) async {
    final url = "http://127.0.0.1:8000/api/users/delete/$id";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);    

    return response.statusCode == 200;
  }

  static Future<List<dynamic>> fetchTodo() async {
    const url = 'http://127.0.0.1:8000/api/users';
    final uri = Uri.parse(url);
    final headers = {
      'accept': 'application/json'
    };
    final response = await http.get(
      uri,
      headers: headers
    );

    return response.statusCode == 200 
      ? (jsonDecode(response.body) as List<dynamic>) 
      : [];
  }

  static Future<bool> submitData(Map data) async {
    const url = 'http://127.0.0.1:8000/api/users/create';
    final uri = Uri.parse(url);

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: headers
    );
    final json = jsonDecode(response.body);
    return json['statusCode'] == 201;
  }

  static Future<bool> updateData(Map data, String id) async {
    final url = 'http://127.0.0.1:8000/api/users/update/${id}';
    final uri = Uri.parse(url);

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.put(uri, body: jsonEncode(data), headers: headers);
    return response.statusCode == 200;
  }

}