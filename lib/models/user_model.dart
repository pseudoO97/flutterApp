class UserModel {
  String uid;
  String? firebaseId;
  String? email;
  String? firstName;
  String? lastName;
  String? birthday;
  String? displayName;
  String? type;
  String? phoneNumber;
  String? category;
  String? address;
  String? sexe;

  UserModel(
      {
      required this.uid,
      this.firebaseId,
      this.email,
      this.firstName,
      this.lastName,
      this.birthday,
      this.type,
      this.displayName,
      this.category,
      this.phoneNumber,
      this.address,
      this.sexe,
      });
factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
     String uid= data['id'];
     String? email = data['email'];
     String? firstName = data['first_name'];
     String? lastName = data['last_name'];
     String? birthday = data['birthday'];
     String? type = data['type'];
     String? category = data['category'];
     String? phoneNumber = data['phone_number'];
     String? address = data['address'];
     String? sexe = data['sexe'];

    return UserModel(
        firebaseId: documentId,
        uid: uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        birthday: birthday,
        type: type,
        category: category,
        phoneNumber: phoneNumber,
        address: address,
        sexe: sexe,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': uid,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'birthday': birthday,
      'type': type,
      'category': category,
      'phone_number': phoneNumber,
      'address': address,
      'sexe': sexe,
    };
  }
}

