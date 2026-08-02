import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/signup/signup_controller.dart';


class SignupView extends StatelessWidget {
   SignupView({super.key});

   final formkey = GlobalKey<FormState>();
   final nameController = TextEditingController();
   final emailController = TextEditingController();
   final passwordController = TextEditingController();
   final signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Create User"),),
      body: Column(
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
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "name",
                    border: OutlineInputBorder()),
                ),
                SizedBox(height: 10,),
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
                          await signupController.signup(nameController.text, emailController.text, passwordController.text);
                          Get.offAllNamed('/home');
                          Get.snackbar('success', 'signed in successsfully');
                        }        
                  }, child: Text("Create User")),

                  
                ),
                TextButton(onPressed: (){
                  Get.toNamed('/login');
                }, child: Text("already an user ? login"))
              ],
                        ),
            ))
        ],
      ),
    );
  }
}