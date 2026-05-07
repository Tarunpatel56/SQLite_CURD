import 'package:flutter/material.dart';
import 'package:sqlite/db_helper.dart';
import 'package:sqlite/notes_model.dart';

class EditNotes extends StatefulWidget {
  final int? id;
  final String title;
  final String description;
  const EditNotes({super.key, required this.id, required this.title, required this.description});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
 late TextEditingController titleController = TextEditingController(text: widget.title);
 late TextEditingController descriptionController = TextEditingController(text: widget.description);
  DBHelper? dbHelper;
late Future<List<notesModel>> notesList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
  
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                controller: titleController,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                decoration: InputDecoration(hintText: "Title",border: InputBorder.none),
              ),
                TextFormField(
                maxLines: 7,
                controller: descriptionController,
               
                decoration: InputDecoration(hintText: "Description",border: InputBorder.none),
              )
            ],),
          ),
          InkWell( onTap: () {
           dbHelper!.update(notesModel(
            id: widget.id,
            title:titleController.text.toString(),
            description:descriptionController.text.toString(), 
           )).then((value){ notesList = dbHelper!.getNotesList(); 
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Note Updated Successfully!")));
           }).onError((error, stackTrace) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error")));
           });
          },
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