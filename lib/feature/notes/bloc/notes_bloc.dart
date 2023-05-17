import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/model/note.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesState(notes: databaseRepository.getNotes())) {
    on<NotesEventKeywordSearch>(_onNotesEventKeywordSearch);
    on<NotesEventOnNoteDeleted>(_onNotesEventOnNoteDeleted);
    on<NotesEventOnNoteAdded>(_onNotesEventOnNoteAdded);
    on<NotesEventOnNoteEdited>(_onNotesEventOnNoteEdited);
  }

  FutureOr<void> _onNotesEventKeywordSearch(NotesEventKeywordSearch event, Emitter<NotesState> emit) {
    emit(NotesState(notes: databaseRepository.getFilteredNotes(event.keyword)));
  }

  FutureOr<void> _onNotesEventOnNoteDeleted(NotesEventOnNoteDeleted event, Emitter<NotesState> emit) {
    databaseRepository.deleteNote(event.note);
    emit(NotesState(notes: databaseRepository.getNotes()));
  }

  FutureOr<void> _onNotesEventOnNoteAdded(NotesEventOnNoteAdded event, Emitter<NotesState> emit) {
    databaseRepository.addNote(event.note);
    emit(NotesState(notes: databaseRepository.getNotes()));
  }

  FutureOr<void> _onNotesEventOnNoteEdited(NotesEventOnNoteEdited event, Emitter<NotesState> emit) {
    databaseRepository.editNote(event.noteDeleted, event.noteAdded);
    emit(NotesState(notes: databaseRepository.getNotes()));
  }
}
