import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/detail/detail_controller.dart';
import 'package:notes_app/home/home_controller.dart';


class DetailView extends StatelessWidget {
   DetailView({super.key});

   final data = Get.arguments;
   final controller = Get.put(DetailController());
   final homeController = Get.find<HomeController>();
   final  titleController = TextEditingController();
   final incidentsController = TextEditingController();
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Note Page"),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          width: double.infinity,
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [                    
                    Text("Title",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                    Text("${data['title']}",style: TextStyle(fontSize: 18),),
                    SizedBox(height: 20,),
                    Text("Incident",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                    Text("${data['incidents']}",style: TextStyle(fontSize: 18),textAlign: TextAlign.justify,),
                
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: (){
                            Get.defaultDialog(
                              title: "Edit",
                              content: Column(
                                children: [
                                  TextField(
                                    controller: titleController,
                                  ),
                                  TextField(
                                    controller: incidentsController,
                                  ),
            
                                ],
                              ),
                              textConfirm: "Edit",
                              textCancel: "Cancel",
                              onConfirm: () async{
                                await controller.updatenote(
                                  titleController.text.isEmpty ? data['title'] : titleController.text, 
                                  incidentsController.text.isEmpty ? data['incidents'] : incidentsController.text,
                                  data['_id']
                                  );
                                  homeController.fetchnotes();
                                   Get.back();
                                   Get.snackbar('success', 'edited successfully',duration: Duration(milliseconds: 700));

                              },
                            );
                          }, icon: Icon(Icons.edit)),


                            IconButton(onPressed: ()async{
                              Get.defaultDialog(
                                barrierDismissible: false,
                                title: "Delete",
                                middleText: "Are You Sure Want To Delete?",
                                textConfirm: "delete",
                                textCancel: "cancel",
                                onConfirm: () async{
                                   await controller.deletenote(data['_id']);
                                   homeController.fetchnotes();
                                   Get.back();
                                   Get.snackbar('success', 'deleted succesfully',duration: Duration(milliseconds: 700));
                                   
                                },
                              );
                             
                             
                          }, icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}