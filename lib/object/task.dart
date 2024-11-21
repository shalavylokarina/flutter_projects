class Task {
  String id;
  String name;
  bool completed;
 
Task({
    required this.id,
    required this.name,
    this.completed = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] != null ? json['id'] as String : '',
      name: json['name'] != null ? json['name'] as String : '',
      completed: json['completed'] != null ? json['completed'] as bool : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'completed': completed,
    };
  }
}