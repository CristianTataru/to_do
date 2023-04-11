import 'package:to_do_list/model/entry.dart';

class EntryList {
  List<Entry> entriesWithDate;
  List<Entry> entriesWithoutDate;
  EntryList(this.entriesWithDate, this.entriesWithoutDate);

  void addEntry(Entry entry) {
    if (entry.date == null) {
      entriesWithoutDate.add(entry);
    } else {
      entriesWithDate.add(entry);
    }
  }
}
