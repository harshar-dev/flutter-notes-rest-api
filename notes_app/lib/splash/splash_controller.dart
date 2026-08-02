import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  final storage = const FlutterSecureStorage();

  @override
  void onInit() {
    checkToken();
    super.onInit();
  }


  Future<void> checkToken() async {

    final token = await storage.read(key: 'token');


    // small delay for splash feel (optional)
    await Future.delayed(
      const Duration(seconds: 1)
    );


    if(token != null && token.isNotEmpty){

      Get.offAllNamed('/home');

    }else{

      Get.offAllNamed('/login');

    }

  }

}