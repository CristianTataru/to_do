part of 'notes_bloc.dart';

class NotesState extends Equatable {
  final List<Note> notes;
  const NotesState({required this.notes});

  @override
  List<Object> get props => [notes];
}
