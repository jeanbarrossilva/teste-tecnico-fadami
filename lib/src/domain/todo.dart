class Todo {
  @override
  int get hashCode => Object.hash(title, isCompleted);

  Todo get toggled => Todo(title: title, isCompleted: !isCompleted);

  final String title;
  final bool isCompleted;

  Todo({required this.title, this.isCompleted = false});

  @override
  bool operator ==(Object other) =>
      other is Todo && title == other.title && isCompleted == other.isCompleted;

  Map<String, dynamic> toJson() => {'title': title, 'isCompleted': isCompleted};

  @override
  String toString() => 'Todo(title: $title, isCompleted: $isCompleted)';

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title']?.toString() ??
            (throw MissingMapKeyError(key: 'title')),
        isCompleted = json['isCompleted'] ?? false;
}

class MissingMapKeyError extends ArgumentError {
  MissingMapKeyError({required String key})
      : super("Missing required '$key' key in to-do map.");
}
