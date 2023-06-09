import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/database/database.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/model/checklist.dart';
import 'package:to_do_list/model/entry.dart';
import 'package:to_do_list/model/note.dart';
import 'package:to_do_list/model/priority.dart';

class DatabaseRepository {
  Database _database = Database({}, [], []);

  Future<void> getAppData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? appDataJson = prefs.getString('myApp');
    if (appDataJson == null) {
      return;
    }
    _database = Database.fromJson(jsonDecode(appDataJson));
  }

  List<List<Entry>> getFilteredEntries(EntryPriority? selectedPriority) {
    List<List<Entry>> myList = databaseRepository.getEntries();
    List<List<Entry>> newList = [];
    if (selectedPriority == null) {
      newList = [...myList];
    } else {
      for (int i = 0; i < myList.length; i++) {
        List<Entry> listToAdd = [];
        for (int j = 0; j < myList[i].length; j++) {
          if (myList[i][j].priority == selectedPriority) {
            listToAdd.add(myList[i][j]);
          }
        }
        if (listToAdd.isNotEmpty) {
          newList.add(listToAdd);
        }
      }
    }
    return newList;
  }

  List<Entry> getEntryList(DateTime? key) {
    final stringKey = key == null ? "null" : key.toIso8601String();
    if (!_database.toDos.containsKey(stringKey)) {
      return [];
    }
    List<Entry> listReturned = _database.toDos[stringKey]!;
    listReturned.sort(compareTwoEntries);
    return listReturned;
  }

  void saveAppData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('myApp', jsonEncode(_database));
  }

  void deleteChecklist(Checklist checklist) {
    _database.checklists.remove(checklist);
    saveAppData();
  }

  void deleteEntry(Entry entry) {
    String entryKey = entry.date == null
        ? "null"
        : DateTime(
            entry.date!.year,
            entry.date!.month,
            entry.date!.day,
          ).toIso8601String();
    _database.toDos[entryKey]!.remove(entry);
    saveAppData();
  }

  void deleteNote(Note note) {
    _database.notes.remove(note);
    saveAppData();
  }

  void editNote(Note oldNote, Note newNote) {
    final index = _database.notes.indexOf(oldNote);
    if (index == -1) {
      return;
    }
    _database.notes.insert(index, newNote);
    _database.notes.remove(oldNote);
    saveAppData();
  }

  void addNote(Note note) {
    _database.notes.add(note);
    saveAppData();
  }

  void addChecklist(Checklist checklist) {
    _database.checklists.add(checklist);
    saveAppData();
  }

  void addEntry(Entry entry) {
    String entryKey = entry.date == null
        ? "null"
        : DateTime(
            entry.date!.year,
            entry.date!.month,
            entry.date!.day,
          ).toIso8601String();
    if (_database.toDos[entryKey] == null) {
      _database.toDos[entryKey] = <Entry>[entry];
    } else {
      _database.toDos[entryKey]!.add(entry);
    }
    saveAppData();
  }

  void removeChecklistItemAtIndex(int index, ChecklistEntry entry) {
    if (_database.checklists.length <= index) {
      return;
    }
    _database.checklists[index].content.remove(entry);
    saveAppData();
  }

  void addChecklistItemAtIndex(int index, ChecklistEntry entry) {
    if (_database.checklists.length <= index) {
      return;
    }
    _database.checklists[index].content.add(entry);
    saveAppData();
  }

  List<Checklist> getFilteredChecklists(String selection) {
    List<Checklist> myList = databaseRepository._database.checklists.map((e) => e.copyWith()).toList();
    List<Checklist> newList = [];
    if (selection == "All") {
      newList = myList;
    } else if (selection == "Progress") {
      for (int i = 0; i < myList.length; i++) {
        for (int j = 0; j < myList[i].content.length; j++) {
          if (myList[i].content[j].checked == false) {
            newList.add(myList[i]);
            break;
          }
        }
      }
    } else if (selection == "Done") {
      newList = [...myList];
      for (int i = 0; i < myList.length; i++) {
        for (int j = 0; j < myList[i].content.length; j++) {
          if (myList[i].content[j].checked == false) {
            newList.remove(myList[i]);
            break;
          }
        }
      }
      List<Checklist> listForUse = [...newList];
      for (int i = 0; i < listForUse.length; i++) {
        if (listForUse[i].content.isEmpty) {
          newList.remove(listForUse[i]);
        }
      }
    }
    return newList;
  }

  List<Note> getNotes() {
    return List.from(databaseRepository._database.notes);
  }

  List<Note> getFilteredNotes(String search) {
    return databaseRepository
        .getNotes()
        .where((element) =>
            element.content.toLowerCase().contains(search.toLowerCase()) ||
            element.title.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

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
    List<List<Entry>> myList = _database.toDos.values.where((element) => element.isNotEmpty).toList();
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
    return myList.map((list) => List<Entry>.from(list)).toList();
  }
}
