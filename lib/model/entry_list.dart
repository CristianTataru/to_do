import 'package:to_do_list/model/entry.dart';

class EntryList {
  List<Entry> entries;
  EntryList(this.entries);

  void addEntry(Entry entry) {
    entries.add(entry);
  }
}
