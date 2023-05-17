part of 'checklists_bloc.dart';

abstract class ChecklistsEvent extends Equatable {
  const ChecklistsEvent();

  @override
  List<Object> get props => [];
}

class ChecklistsEventOnFilterChanged extends ChecklistsEvent {
  final String filter;

  const ChecklistsEventOnFilterChanged({required this.filter});

  @override
  List<Object> get props => [filter];
}

class ChecklistsEventOnChecklistDeleted extends ChecklistsEvent {
  final Checklist checklist;

  const ChecklistsEventOnChecklistDeleted({required this.checklist});

  @override
  List<Object> get props => [checklist];
}

class ChecklistsEventOnChecklistAdded extends ChecklistsEvent {
  final Checklist checklist;

  const ChecklistsEventOnChecklistAdded({required this.checklist});

  @override
  List<Object> get props => [checklist];
}

class ChecklistsEventOnChecklistItemDeleted extends ChecklistsEvent {
  final int index;
  final ChecklistEntry entry;

  const ChecklistsEventOnChecklistItemDeleted({required this.index, required this.entry});

  @override
  List<Object> get props => [index, entry];
}

class ChecklistsEventOnChecklistItemAdded extends ChecklistsEvent {
  final int index;
  final ChecklistEntry entry;

  const ChecklistsEventOnChecklistItemAdded({required this.index, required this.entry});

  @override
  List<Object> get props => [index, entry];
}

class ChecklistsEventOnChecklistItemDoneUndone extends ChecklistsEvent {
  final int index;
  final ChecklistEntry entry;

  const ChecklistsEventOnChecklistItemDoneUndone({required this.index, required this.entry});

  @override
  List<Object> get props => [index, entry];
}
