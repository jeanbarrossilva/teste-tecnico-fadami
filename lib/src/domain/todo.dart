class Todo {
  final String title;

  bool get isCompleted => _isCompleted;

  bool _isCompleted;

  Todo({required this.title, isCompleted = false}) : _isCompleted = isCompleted;

  @override
  bool operator ==(Object other) =>
      other is Todo && title == other.title && isCompleted == other.isCompleted;

  @override
  int get hashCode => Object.hash(title, isCompleted);

  void toggle() {
    _isCompleted = !isCompleted;
  }

  Map<String, dynamic> toMap() {
    return {"title": title, "isCompleted": isCompleted};
  }

  static Todo fromMap(Map<String, dynamic> map) {
    final title =
        map['title']?.toString() ?? (throw MissingMapKeyError(key: 'title'));
    final bool isCompleted = map['isCompleted'] ?? false;
    return Todo(title: title, isCompleted: isCompleted);
  }
}

class MissingMapKeyError extends ArgumentError {
  MissingMapKeyError({required String key})
      : super("Missing required '$key' key in to-do map.");
}
