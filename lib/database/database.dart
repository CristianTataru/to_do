import 'dart:convert';

import 'package:to_do_list/model/checklist.dart';
import 'package:to_do_list/model/entry.dart';

import '../model/note.dart';

Database database = Database({}, [], []);

class Database {
  Map<String, List<Entry>> toDos = {};
  List<Note> notes;
  List<Checklist> checklists;
  Database(this.toDos, this.notes, this.checklists);

  Database.fromJson(Map<String, dynamic> json)
      : toDos = (jsonDecode(json['toDos']) as Map)
            .map((key, value) => MapEntry(key, (value as List).map((e) => Entry.fromJson(e)).toList())),
        notes = (json['notes'] as List).map((e) => Note.fromJson(e)).toList(),
        checklists = (json['checklists'] as List).map((e) => Checklist.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'toDos': jsonEncode(toDos),
        'notes': notes,
        'checklists': checklists,
      };

  void addNote(Note note) {
    notes.add(note);
  }

  void addChecklist(Checklist checklist) {
    checklists.add(checklist);
  }

  void addEntry(Entry entry) {
    String entryKey = entry.date == null
        ? "null"
        : DateTime(
            entry.date!.year,
            entry.date!.month,
            entry.date!.day,
          ).toIso8601String();
    if (toDos[entryKey] == null) {
      toDos[entryKey] = <Entry>[entry];
    } else {
      toDos[entryKey]!.add(entry);
    }
  }

  List<ChecklistEntry> getChecklistData(Checklist a) {
    List<ChecklistEntry> myList = a.content;
    myList.sort((a, b) {
      if (a.checked == b.checked) {
        return a.name.compareTo(b.name);
      }
      return b.checked ? -1 : 1;
    });
    return myList;
  }

  List<Entry> getEntryList(DateTime? key) {
    final stringKey = key == null ? "null" : key.toIso8601String();
    if (!toDos.containsKey(stringKey)) {
      return [];
    }
    List<Entry> listReturned = toDos[stringKey]!;
    listReturned.sort(compareTwoEntries);
    return listReturned;
  }

  //Sorteaza 2 entry in ordinea prioritatii:
  //1.Pune taskurile "Not Done" inainte celor "Done".
  //2.Pune taskurile cu ora inaintea celor fara ora.
  //3.Pune taskurile cu ora mai devreme inaintea celor cu ora mai tarzie.
  //4.Sorteaza taskurile in ordine alfabetica.
  int compareTwoEntries(Entry a, Entry b) {
    if (a.isDone == b.isDone) {
      if (a.hasTime == b.hasTime) {
        if (a.date == b.date) {
          return a.name.compareTo(b.name);
        }
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
      myList[i].sort(compareTwoEntries);
    }
    return myList;
  }
}
