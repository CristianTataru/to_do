part of 'to_do_list_all_page_bloc.dart';

abstract class ToDoListEvent extends Equatable {
  const ToDoListEvent();

  @override
  List<Object?> get props => [];
}

class ToDoListEventOnPriorityChanged extends ToDoListEvent {
  final EntryPriority priority;

  const ToDoListEventOnPriorityChanged({required this.priority});

  @override
  List<Object> get props => [priority];
}

class ToDoListEventOnPriorityAll extends ToDoListEvent {}

class ToDoListEventItemDone extends ToDoListEvent {
  final Entry entry;

  const ToDoListEventItemDone({required this.entry});

  @override
  List<Object> get props => [entry];
}

class ToDoListEventItemUnDone extends ToDoListEvent {
  final Entry entry;

  const ToDoListEventItemUnDone({required this.entry});

  @override
  List<Object> get props => [entry];
}

class ToDoListEventItemDeleted extends ToDoListEvent {
  final Entry entry;

  const ToDoListEventItemDeleted({required this.entry});

  @override
  List<Object> get props => [entry];
}

class ToDoListEventItemEdited extends ToDoListEvent {
  final Entry entryDeleted;
  final Entry entryAdded;

  const ToDoListEventItemEdited({required this.entryDeleted, required this.entryAdded});

  @override
  List<Object> get props => [entryDeleted, entryAdded];
}

class ToDoListEventItemAdded extends ToDoListEvent {
  final Entry entry;

  const ToDoListEventItemAdded({required this.entry});

  @override
  List<Object> get props => [entry];
}
