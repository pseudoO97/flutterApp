class CategoryModel {
  final dynamic firebaseId;
  final int? id;
  final String? name;
  final String? path;

  CategoryModel(
      {required this.firebaseId, required this.id, this.name, this.path});

  factory CategoryModel.fromMap(Map<String, dynamic> data, String documentId) {
    int? id = data['id'];
    String? name = data['name'];
    String? path = data['path'];

    return CategoryModel(
        firebaseId: documentId, id: id, name: name, path: path);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'path': path};
  }
}
