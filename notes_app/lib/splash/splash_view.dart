import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';


class SplashView extends StatelessWidget {

  SplashView({super.key});


  final controller = Get.put(SplashController());


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [


            Icon(
              Icons.note_alt,
              size: 80,
              color: Colors.blue,
            ),


            const SizedBox(height: 20),


            const Text(
              "Notes App",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),


            const SizedBox(height: 30),


            const CircularProgressIndicator()


          ],

        ),

      ),

    );

  }

}