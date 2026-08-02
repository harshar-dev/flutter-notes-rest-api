import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/home/home_controller.dart';


class HomeView extends StatelessWidget {
   HomeView({super.key});


   


   final homeController = Get.put(HomeController());
   final searchController = TextEditingController();

  @override

  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Get.defaultDialog(
              title: "Logout",
              middleText: "Are you sure want to logout",
              textConfirm: "logout",
              textCancel: "cancel",
              onConfirm: () async{
                   await homeController.logout();
                    Get.offAllNamed('/login');
              },
            );
         
          }, icon: Icon(Icons.logout_outlined)),
          
        ],
        title: Text("Home Page"),),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          FocusManager.instance.primaryFocus?.unfocus();
          Get.toNamed('/add-notes');
      }),

      body: Obx((){
        return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                homeController.searchnotes(value);
              },
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: "Search By Title",
                border: OutlineInputBorder()),
            ),

            SizedBox(height: 10,),

            Expanded(
              child: GridView.builder(
                
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.8,
                  crossAxisCount: 2), 
                itemCount: homeController.notes.length,
                
                itemBuilder: (context,index){
                  final data = homeController.notes[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed('/detailpage',arguments: data);
                    },
                    child: Card(
                      elevation: 8,
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),),
                              Text("${data['title']}"),
                              Text("Incident",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),),
                              Text("${data['incidents']}",maxLines: 4,overflow: TextOverflow.ellipsis,),
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                ),
            )
          ],
        ),
      );
      })
    );
  }
}