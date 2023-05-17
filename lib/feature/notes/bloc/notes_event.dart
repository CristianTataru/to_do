part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class NotesEventKeywordSearch extends NotesEvent {
  final String keyword;

  const NotesEventKeywordSearch({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class NotesEventOnNoteDeleted extends NotesEvent {
  final Note note;

  const NotesEventOnNoteDeleted({required this.note});

  @override
  List<Object> get props => [note];
}

class NotesEventOnNoteAdded extends NotesEvent {
  final Note note;

  const NotesEventOnNoteAdded({required this.note});

  @override
  List<Object> get props => [note];
}

class NotesEventOnNoteEdited extends NotesEvent {
  final Note noteDeleted;
  final Note noteAdded;

  const NotesEventOnNoteEdited({required this.noteDeleted, required this.noteAdded});

  @override
  List<Object> get props => [noteDeleted, noteAdded];
}
