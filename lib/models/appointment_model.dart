class AppointmentModel {
   final String? firebaseId;
   final String? individualId;
   final String? professionnalId;
   final String? individualName;
   final String? professionnalName;

  AppointmentModel({
      this.firebaseId, 
      this.individualId,
      this.professionnalId,
      this.individualName,
      this.professionnalName
      });


factory AppointmentModel.fromMap(Map<String, dynamic> data, String documentId) {
     String firebaseId = documentId;
     String? individualId = data['individual_id'];
     String? professionnalId = data['professionnal_id'];
     String? individualName = data['individual_name'];
     String? professionnalName = data['professionnal_name'];

    return AppointmentModel(
        firebaseId: firebaseId,
        individualId: individualId,
        professionnalId: professionnalId,
        individualName: individualName,
        professionnalName: professionnalName,
      );
  }

  Map<String, dynamic> toMap() {
    return {
      'individual_id': individualId,
      'professionnal_id':professionnalId,
      'individual_name': individualName,
      'professionnal_name': professionnalName
    };
  }
}
