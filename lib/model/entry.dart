class Entry {
  String name;
  DateTime? date;
  bool hasTime;
  bool isDone;

  Entry(this.name, this.date, this.hasTime, this.isDone);

  Entry.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        date = DateTime.parse(json['date']),
        hasTime = json['hasTime'],
        isDone = json['isDone'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'date': date.toString(),
        "hasTime": hasTime,
        'isDone': isDone,
      };
}
