import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  @override
  void onInit() {
    fetchnotes();
    super.onInit();
  }

  final notes = [].obs;
  final storage = const FlutterSecureStorage();

  Future<void> fetchnotes() async {
    try {
      final token = await storage.read(key: 'token');

         if(token == null){
          Get.offAllNamed('signup');
         }
      final response = await http.get(
        Uri.parse('http://192.168.1.4:3000/api/get_notes'),
        headers: {
          'Authorization' : 'Bearer $token',
          'Content-Type' : 'application/json'
        }
      );

      final body = jsonDecode(response.body);

      notes.value = body;
    } catch (e) {
      print(e);
    }
  }



  Future<void> searchnotes(String searchtext)async{
      final token = await storage.read(key: 'token');

         if(token == null){
          Get.offAllNamed('signup');
         }
      final response = await http.get(

        Uri.parse('http://192.168.1.4:3000/api/get_notes_bysearch?name=$searchtext'),
        headers: {
          'Authorization' : 'Bearer $token',
          'Content-Type' : 'application/json'
        }
        );

        final data = jsonDecode(response.body);

        notes.value = data;
  }

  Future<void> logout()async{
    await storage.delete(key: 'token');
  }
}
