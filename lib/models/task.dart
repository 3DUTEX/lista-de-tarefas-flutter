class Task {
  late int id;
  String title;
  String desc;
  String date;
  int status;

  Task(
      {required this.title,
      this.desc = "",
      required this.date,
      required this.status});

  Map<String, dynamic> toMap() {
    return {'title': title, 'desc': desc, 'date': date, 'status': status};
  }
}
