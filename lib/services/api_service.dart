import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hutang_piutang.dart';

class ApiService {
  final String apiUrl = "http://103.196.155.42/api/keuangan/hutang_piutang";
  final String registerUrl = "http://103.196.155.42/api/registrasi";
  final String loginUrl = "http://103.196.155.42/api/login"; 

  // Mendapatkan semua data hutang_piutang
  Future<List<HutangPiutang>> getAllHutangPiutang() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parsing response JSON
      var jsonResponse = json.decode(response.body);

      // Jika respons berupa Map dan berisi key 'data' yang merupakan List
      if (jsonResponse is Map && jsonResponse.containsKey('data')) {
        List jsonData = jsonResponse['data']; // Mengambil List dari key 'data'
        return jsonData.map((data) => HutangPiutang.fromJson(data)).toList();
      }

      // Jika respons langsung berupa List
      else if (jsonResponse is List) {
        return jsonResponse.map((data) => HutangPiutang.fromJson(data)).toList();
      }

      // Jika respons tidak sesuai format yang diharapkan
      else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Membuat data baru
  Future<void> createHutangPiutang(HutangPiutang hutangPiutang) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(hutangPiutang.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create data');
    }
  }

  // Mengupdate data
  Future<void> updateHutangPiutang(int id, HutangPiutang hutangPiutang) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id/update'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(hutangPiutang.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update data');
    }
  }

  // Menghapus data
  Future<void> deleteHutangPiutang(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id/delete'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }

  // Register
  Future<void> registerUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(registerUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 201) {
      var message = jsonDecode(response.body)['message'] ?? 'Failed to register';
      throw Exception('Registration failed: $message');
    }
  }

  // Login
  Future<void> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Jika login berhasil, Anda bisa melakukan apa pun dengan token atau data pengguna
      var jsonResponse = jsonDecode(response.body);
      // Misalnya, menyimpan token di SharedPreferences
      // String token = jsonResponse['token'];
      // Save token logic here (if applicable)
    } else {
      var message = jsonDecode(response.body)['message'] ?? 'Failed to login';
      throw Exception('Login failed: $message');
    }
  }
}
