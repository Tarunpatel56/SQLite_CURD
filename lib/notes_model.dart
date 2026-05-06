class notesModel {
  int? id;
  String? title;
  String? description;

  notesModel({this.id, this.title, this.description});

  notesModel.fromMap(Map<String, dynamic> res) {
    id = res['id'];
    title = res['title'];
    description = res['description'];
  }

  Map<String, dynamic> toMap() {
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    // data['title'] = this.title;
    // data['description'] = this.description;
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}