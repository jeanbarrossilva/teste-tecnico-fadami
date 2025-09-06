class Todo {
  final String title;
  bool isCompleted;

  Todo({required this.title, this.isCompleted = false});

  void complete() {
    isCompleted = true;
  }

  void uncomplete() {
    isCompleted = false;
  }

  Map<String, dynamic> toMap() {
    return {"title": title, "isCompleted": isCompleted};
  }
}
