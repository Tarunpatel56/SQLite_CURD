import 'package:flutter/material.dart';
import 'package:sqlite/add_notes.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String search = "";
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();

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
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text("$index")),
              title: Text("SQlite note"),
              subtitle: Text("@code_with_sidd"),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.edit, color: Colors.green),
                      title: Text("Edit"),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.delete_forever, color: Colors.red),
                      title: Text("Delete"),
                    ),
                  ),
                ],
              ),
            ),
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
