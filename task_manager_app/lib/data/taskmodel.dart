class Taskmodel {
  String title;
  String description;
  bool isCompleted;
  Taskmodel({
    required this.title,

    required this.description,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': 'description',
    'is COMPLETED': isCompleted,
  };

  factory Taskmodel.fromJson(Map<String, dynamic> json) => Taskmodel(
    title: json['title'],
    description: json['description'],
    isCompleted: json['isCOMPLETED'],
  );
}
