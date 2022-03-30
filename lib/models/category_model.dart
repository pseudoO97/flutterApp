class CategoryModel {
    final dynamic firebaseId;
   final int? id;
   final String? name;
   

  CategoryModel({
      required this.firebaseId,
      required this.id,
      this.name
  });
      
factory CategoryModel.fromMap(Map<String, dynamic> data, String documentId) {
     int? id = data['id'];
     String? name = data['name'];
    

    return CategoryModel(
        firebaseId: documentId,
        id: id,
        name: name
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name
    };
  }
}
