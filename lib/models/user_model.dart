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
  String? categoryUser;
  String? address;

  UserModel(
      {required this.uid,
      this.firebaseId,
      this.email,
      this.firstName,
      this.lastName,
      this.birthday,
      this.type,
      this.displayName,
      this.categoryUser,
      this.phoneNumber,
      this.address,
      });

factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
     String uid= data['id'];
     String email = data['email'];
     String? firstName = data['first_name'];
     String? lastName = data['last_name'];
     String? birthday = data['birthday'];
     String? type = data['type'];
     String? categoryUser = data['category_user'];
     String? phoneNumber = data['phone_number'];
     String? address = data['address'];

    return UserModel(
        firebaseId: documentId,
        uid: uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        birthday: birthday,
        type: type,
        categoryUser: categoryUser,
        phoneNumber: phoneNumber,
        address: address,
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
      'category_user': categoryUser,
      'phone_number': phoneNumber,
      'address': address,
    };
  }
}

