class ServiceModel {
    final dynamic firebaseId;
   final String? name;
   

  ServiceModel({
      required this.firebaseId,
      this.name
  });
      
factory ServiceModel.fromMap(Map<String, dynamic> data, String documentId) {
     String? name = data['name'];
    

    return ServiceModel(
        firebaseId: documentId,
        name: name
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name
    };
  }
}
