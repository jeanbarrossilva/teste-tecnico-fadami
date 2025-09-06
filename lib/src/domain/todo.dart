class Todo {
  final String title;

  bool get isCompleted => _isCompleted;

  bool _isCompleted;

  Todo({required this.title, isCompleted = false}) : _isCompleted = isCompleted;

  void toggle() {
    _isCompleted = !isCompleted;
  }

  Map<String, dynamic> toMap() {
    return {"title": title, "isCompleted": isCompleted};
  }
}
