import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/login/login_controller.dart';

class LoginView extends StatelessWidget {
   LoginView({super.key});

  final formkey = GlobalKey<FormState>();
   final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Login User"),),
      body : Column(
        children: [
          Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
              children: [
              
                TextFormField(
                   validator: (value) {
                    if(value == null || value.isEmpty){
                      return "please Enter Field";
                    }
                    return null;
                  },
                  controller: emailController,
                   decoration: InputDecoration(
                    labelText: "email",
                    border: OutlineInputBorder()),
                ),
                SizedBox(height: 10,),
                TextFormField(
                   validator: (value) {
                    if(value == null || value.isEmpty){
                      return "please Enter Field";
                    }
                    if(value.length < 6){
                      return "please Enter above 6 Characters";
                    }
                    return null;
                  },
                  controller: passwordController,
                   decoration: InputDecoration(
                    labelText: "password",
                    border: OutlineInputBorder()),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey,
                      textStyle: TextStyle(fontSize: 20)
                    ),
                    onPressed: ()async{
                        if(formkey.currentState!.validate()){
                          await controller.login(emailController.text, passwordController.text);
                          Get.offAllNamed('/home');
                          Get.snackbar('success', 'login in successsfully');
                        }        
                  }, child: Text("Login")),

                  
                ),
                TextButton(onPressed: (){
                  Get.toNamed('/signup');
                }, child: Text("don't have account ? signup"))
              ],
                        ),
            ))
        ],
      ),
    );
  }
}