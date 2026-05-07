import 'package:flutter/material.dart';
import 'package:sqlite/add_notes.dart';
import 'package:sqlite/db_helper.dart';
import 'package:sqlite/edit_notes.dart';
import 'package:sqlite/notes_model.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String search = "";
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();
  DBHelper? dbHelper;
  late Future<List<notesModel>> notesList;
  getData(){
    notesList = dbHelper!.getNotesList();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: isSearch == false?
           AppBar(
              title: Text("SQLite Notes"),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearch = true;
                    });
                  },
                ),
              ],
            )
          : 
          AppBar(backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    isSearch = false;
                    searchController.clear();
                    search = "";
                  });
                },
              ),
              title: TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Search",
                  border: InputBorder.none,
                 
                ),
              ),
            ),
      body: FutureBuilder(
        future: notesList,
        builder: (context,AsyncSnapshot<List<notesModel>>snapshot){
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(child: Text(snapshot.data![index].id.toString())),
                  title: Text(snapshot.data![index].title.toString()),
                  subtitle: Text(snapshot.data![index].description.toString()),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.edit, color: Colors.green),
                          title: Text("Edit"),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditNotes(
                              id :snapshot.data![index].id,
                              title: snapshot.data![index].title.toString(),
                              description: snapshot.data![index].description.toString(),
                            )));
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.delete_forever, color: Colors.red),
                          title: Text("Delete"),
                          onTap: (){
                          setState(() {
                              dbHelper!.delete(snapshot.data![index].id!);
                            notesList = dbHelper!.getNotesList();
                            snapshot.data!.remove(snapshot.data![index]);
                            Navigator.pop(context);
                          });
                            
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotes()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
