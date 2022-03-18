class RdvModel {
   final String? firebaseId;
   final String id;
   final dynamic date;
   final bool? done;
   final int? individual_id;
   final int? professionnal_id;

  RdvModel({
      this.firebaseId, 
      required this.id,
      this.date,
      this.done,
      this.individual_id,
      this.professionnal_id
      });


factory RdvModel.fromMap(Map<String, dynamic> data, String documentId) {
     String id= data['id'];
     dynamic date = data['date'];
     bool done = data['done'];
     int individual_id = data['individual_id'];
     int professionnal_id = data['professionnal_id'];

    return RdvModel(
        id: id,
        date: date,
        done: done,
        individual_id: individual_id,
        professionnal_id: professionnal_id,
        );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'done': done,
      'individual_id': individual_id,
      'professionnal_id':professionnal_id
    };
  }
}
