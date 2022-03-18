class CategoriesModel {
   final String? firebaseId;
   final String id;
   final String? name;
   

  CategoriesModel({
      this.firebaseId, 
      required this.id,
      this.name
  });
      
factory CategoriesModel.fromMap(Map<String, dynamic> data, String documentId) {
     String id= data['id'];
     String name = data['name'];
    

    return CategoriesModel(
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
