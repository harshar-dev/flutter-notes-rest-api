import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class LoginController extends GetxController{

  final storage = const FlutterSecureStorage();

  Future<void> login(String email , String password)async{
    
    final response = await http.post(
      
      Uri.parse('http://192.168.1.4:3000/api/login'),
      body: jsonEncode({
        'email' : email,
        'password' : password
      }),
      headers: {
        'Content-Type' : 'application/json'
      }
      );

        if(response.statusCode == 200){
          final data = jsonDecode(response.body);

          final token = data['token'];

          await storage.write(key: 'token', value: token);
          
        }


  }
}