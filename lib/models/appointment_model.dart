class AppointmentModel {
   final String? firebaseId;
   final String id;
   final dynamic date;
   final bool? done;
   final int? individualId;
   final int? professionnalId;

  AppointmentModel({
      this.firebaseId, 
      required this.id,
      this.date,
      this.done,
      this.individualId,
      this.professionnalId
      });


factory AppointmentModel.fromMap(Map<String, dynamic> data, String documentId) {
     String id= data['id'];
     dynamic date = data['date'];
     bool done = data['done'];
     int individual_id = data['individual_id'];
     int professionnal_id = data['professionnal_id'];

    return AppointmentModel(
        id: id,
        date: date,
        done: done,
        individualId: individual_id,
        professionnalId: professionnal_id,
        );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'done': done,
      'individual_id': individualId,
      'professionnal_id':professionnalId
    };
  }
}
