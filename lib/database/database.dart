import 'dart:convert';

import 'package:to_do_list/model/checklist.dart';
import 'package:to_do_list/model/entry.dart';

import '../model/note.dart';

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
}
