class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Day 5', isDone: true),
      ToDo(id: '02', todoText: 'Day 6', isDone: true),
      ToDo(
        id: '03',
        todoText: 'Day 4',
      ),
      ToDo(
        id: '04',
        todoText: 'Day 3',
      ),
      ToDo(
        id: '05',
        todoText: 'Day 2',
      ),
      ToDo(
        id: '06',
        todoText: 'Day 1',
      ),
    ];
  }
}
