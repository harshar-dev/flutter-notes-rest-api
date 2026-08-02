import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;





class DetailController extends GetxController{

 
    final storage = const FlutterSecureStorage();
  
    Future<void> deletenote(String id)async{

       final token = await storage.read(key: 'token');

         if(token == null){
          Get.offAllNamed('signup');
         }


      final response = await http.delete(

        Uri.parse('http://192.168.1.4:3000/api/delete_note/$id'),
         headers: {
          'Content-Type' : 'application/json',
          'Authorization' : 'Bearer $token'
        },
        );

        if(response.statusCode == 200){
            return Get.back();
        }else{
          Get.snackbar('error','something wnet wrong');
        }   
  }





  Future<void> updatenote(String title , String incidents ,String id)async{
    final token = await storage.read(key: 'token');

         if(token == null){
          Get.offAllNamed('signup');
         }

    final response = await http.put(
      Uri.parse('http://192.168.1.4:3000/api/edit_note/$id'),
        headers: {
          'Content-Type' : 'application/json',
          'Authorization' : 'Bearer $token'
        },
      body: jsonEncode({
        'title' : title,
        'incidents' : incidents,
        'createdAt' : DateTime.now().toString()
      }),
 
      
      );

      if(response.statusCode == 200){
        return Get.back();
      }else{
          Get.snackbar('error','something wnet wrong');
        }   
  }






}