class Todo {
  final String id;
  final String title;

  Todo({required this.id, required this.title});

  Todo copyWith({String? id, String? title}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}
