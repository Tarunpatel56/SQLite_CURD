import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.brown, width: 3),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(children: [
              TextFormField(
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                decoration: InputDecoration(hintText: "Title",border: InputBorder.none),
              ),
                TextFormField(
                maxLines: 7,
               
                decoration: InputDecoration(hintText: "Description",border: InputBorder.none),
              )
            ],),
          ),
          InkWell(
            child: Container(
              height: 50,width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 50, ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.brown,
                
            
              ),
              child: const Center(child: Text("Save",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)),
            ),
          ),
        ],
      ),
    );
  }
}
