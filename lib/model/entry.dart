class Entry {
  String name;
  DateTime? hour;
  DateTime? date;

  Entry(this.name, this.date, this.hour);
  Entry.noTime(this.name, this.date);
  Entry.noDate(this.name);
}
