import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController{

  final storage = const FlutterSecureStorage();
  
  Future<void> signup(String name, String email , String password)async{
      final response = await http.post(
        
        Uri.parse('http://192.168.1.4:3000/api/signup'),
        body: jsonEncode({
          'name' : name,
          'email' : email,
          'password' : password,
          'createdAt' : DateTime.now().toString(),
        }),
        headers: {
          'Content-Type' : 'application/json'
        }
        );


        if(response.statusCode == 201){
          final data = jsonDecode(response.body);

          final token = data['token'];

          await storage.write(key: 'token', value: token);
          
        }

  }
}