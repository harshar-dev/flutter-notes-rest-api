import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/add_notes/add_notes_controller.dart';
import 'package:notes_app/home/home_controller.dart';


class AddNotesView extends StatelessWidget {
   AddNotesView({super.key});

  final titleController = TextEditingController();
  final incidentsController = TextEditingController();
  final addPageController = Get.put(AddNotesController()); 
  final formkey = GlobalKey<FormState>();
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add-Notes",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return "Please Enter Field";
                      }
                      return null;
                    },
                controller: titleController,
                  decoration: InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder()),
                ),
            
                SizedBox(height: 15,),
            
                TextFormField(
                  maxLines: 5,
                   validator: (value) {
                      if(value == null || value.isEmpty){
                        return "Please Enter Field";
                      }
                      return null;
                    },
                  controller: incidentsController,
                  decoration: InputDecoration(
                    hintText: "Type Your Incidents...",
                    border: OutlineInputBorder()),
                ),
                SizedBox(height: 15,),
            
                SizedBox(
                  
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.blueGrey,
                      textStyle: TextStyle(fontSize: 20),
                      padding: EdgeInsets.all(15)),
                    onPressed: ()async{
                        if(formkey.currentState!.validate()){
                           await addPageController.addnotes(titleController.text, incidentsController.text);
                           
                           titleController.clear();
                           incidentsController.clear();
                           homeController.fetchnotes();
                           Get.back();
                           
                        }
            
                        
            
                     
                  }, child: Text("Save")),
                )
                ],
              ),
          ))
        
      ),
    );
  }
}