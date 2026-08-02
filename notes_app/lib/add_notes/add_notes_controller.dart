import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class AddNotesController extends GetxController{

  final storage = const FlutterSecureStorage();


    Future<void> addnotes (String title , String incidents)async{

     

      try {
         final token = await storage.read(key: 'token');

         if(token == null){
          Get.offAllNamed('signup');
         }

        final response = await http.post(
        Uri.parse("http://192.168.1.4:3000/api/add_notes"),
        headers: {
          'Content-Type' : 'application/json',
          'Authorization' : 'Bearer $token'
        },
        body: jsonEncode({
          'title' : title,
          'incidents' : incidents,
          'createdAt' : DateTime.now().toString(),
        })
        );
        if(response.statusCode == 201){
           Get.snackbar('Success', 'Notes Added Successfully',duration: Duration(milliseconds: 800));
          
        }else if(response.statusCode == 500){
           Get.snackbar('Error', 'Something Went Wrong',duration: Duration(milliseconds: 800));
        }
      } catch (e) {
        print(e);
        Get.snackbar('Error', 'Unable to Connect To server');
      }
      
    }


}