import 'package:to_do_list/model/entry.dart';

Database database = Database(
  {
    DateTime.tryParse("2023-04-15"): [
      Entry("Haircut", DateTime.tryParse("2023-04-15 15:45"), true),
      Entry("Wash Car", DateTime.tryParse("2023-04-15"), false),
    ],
    DateTime.tryParse("2023-04-17"): [
      Entry('Buy Gift', DateTime.tryParse("2023-04-17"), false),
      Entry('Buy Meat', DateTime.tryParse("2023-04-17"), false),
    ],
    null: [
      Entry("Feed cat", null, false),
      Entry('Clean house', null, false),
      Entry("Fix sink", null, false),
    ],
  },
);

class Database {
  Map<DateTime?, List<Entry>> toDos = {};
  Database(this.toDos);

  void addEntry(Entry entry) {
    DateTime? entryKey = entry.date == null
        ? null
        : DateTime(
            entry.date!.year,
            entry.date!.month,
            entry.date!.day,
          );
    if (toDos[entryKey] == null) {
      toDos[entryKey] = <Entry>[entry];
    } else {
      toDos[entryKey]!.add(entry);
    }
  }

  List<List<Entry>> getEntries() {
    List<List<Entry>> myList = toDos.values.toList();

    myList.sort(
      (a, b) {
        if (a.first.date == null) {
          return 1;
        }
        if (b.first.date == null) {
          return -1;
        }
        return a.first.date!.compareTo(b.first.date!);
      },
    );
    return myList;
  }
}
