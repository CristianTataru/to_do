import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/model/checklist.dart';
import 'package:to_do_list/model/entry.dart';
import 'package:to_do_list/model/note.dart';
import 'package:to_do_list/model/priority.dart';
import '../../database/database.dart';

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

  List<Checklist> getChecklists() {
    List<Checklist> myList = databaseRepository._database.checklists;
    return myList;
  }

  List<Checklist> getFilteredChecklists(String selection) {
    List<Checklist> myList = databaseRepository.getChecklists();
    List<Checklist> newList = [];
    if (selection == "All") {
      newList = [...myList];
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
    }
    return newList;
  }

  List<Note> getNotes() {
    List<Note> myList = databaseRepository._database.notes;
    return myList;
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
    return myList;
  }
}
