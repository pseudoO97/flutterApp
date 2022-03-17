class TaskModel {
  final String firebaseId;
  final int id;
  final String name;
  final int sequence;
  final bool done;

  TaskModel({
    required this.firebaseId,
    required this.id,
    required this.name,
    required this.sequence,
    required this.done,
  });

  factory TaskModel.fromMap(Map<String, dynamic> data, String documentId) {
    int id = data['id'];
    String name = data['name'];
    int sequence = data['sequence'];
    bool done = data['done'] ?? false;

    return TaskModel(
        firebaseId: documentId,
        id: id,
        name: name,
        sequence: sequence,
        done: done);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sequence': sequence,
      'done': done,
    };
  }
}
