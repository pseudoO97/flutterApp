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

}

