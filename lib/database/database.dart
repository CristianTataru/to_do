import 'package:to_do_list/model/entry.dart';

Database database = Database(
  {
    DateTime.tryParse("2023-04-15"): [
      Entry("Feed dog", DateTime.tryParse("2023-04-15"), false, false),
      Entry("Do dishes", DateTime.tryParse("2023-04-15"), false, true),
      Entry("Haircut", DateTime.tryParse("2023-04-15 15:45"), true, false),
      Entry("Trim beard", DateTime.tryParse("2023-04-15 10:45"), true, false),
      Entry("Wash Car", DateTime.tryParse("2023-04-15"), false, false),
    ],
    DateTime.tryParse("2023-04-17"): [
      Entry('Buy Gift', DateTime.tryParse("2023-04-17"), false, false),
      Entry('Buy Meat', DateTime.tryParse("2023-04-17"), false, false),
    ],
    null: [
      Entry("Feed cat", null, false, false),
      Entry('Clean house', null, false, false),
      Entry("Fix sink", null, false, false),
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

  List<Entry> getEntryList(DateTime? key) {
    if (!toDos.containsKey(key)) {
      return [];
    }
    List<Entry> listReturned = toDos[key]!;
    listReturned.sort((a, b) {
      if (a.isDone == b.isDone) {
        if (a.hasTime == b.hasTime) {
          if (a.date == null) {
            return 1;
          }
          if (b.date == null) {
            return -1;
          }
          return a.date!.compareTo(b.date!);
        }
        return b.hasTime ? 1 : -1;
      }
      return b.isDone ? -1 : 1;
    });
    return listReturned;
  }

  List<List<Entry>> getEntries() {
    List<List<Entry>> myList = toDos.values.where((element) => element.isNotEmpty).toList();
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
    for (int i = 0; i < myList.length; i++) {
      myList[i].sort((a, b) {
        if (a.isDone == b.isDone) {
          if (a.hasTime == b.hasTime) {
            if (a.date == null) {
              return 1;
            }
            if (b.date == null) {
              return -1;
            }
            return a.date!.compareTo(b.date!);
          }
          return b.hasTime ? 1 : -1;
        }
        return b.isDone ? -1 : 1;
      });
    }
    return myList;
  }
}
