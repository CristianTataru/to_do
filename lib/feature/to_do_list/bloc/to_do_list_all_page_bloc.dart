import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/model/entry.dart';
import 'package:to_do_list/model/priority.dart';
part 'to_do_list_all_page_event.dart';
part 'to_do_list_all_page_state.dart';

class ToDoListBloc extends Bloc<ToDoListEvent, ToDoListState> {
  ToDoListBloc() : super(ToDoListState(dataList: databaseRepository.getEntries(), priority: null)) {
    on<ToDoListEventOnPriorityChanged>(_onToDoListEventOnPriorityChanged);
    on<ToDoListEventOnPriorityAll>(_onToDoListEventOnPriorityAll);
    on<ToDoListEventItemDone>(_onToDoListEventItemDone);
    on<ToDoListEventItemUnDone>(_onToDoListEventItemUnDone);
    on<ToDoListEventItemDeleted>(_onToDoListEventItemDeleted);
    on<ToDoListEventItemEdited>(_onToDoListEventItemEdited);
    on<ToDoListEventItemAdded>(_onToDoListEventItemAdded);
  }

  FutureOr<void> _onToDoListEventOnPriorityChanged(ToDoListEventOnPriorityChanged event, Emitter<ToDoListState> emit) {
    List<List<Entry>> newDataList = databaseRepository.getFilteredEntries(event.priority);
    emit(ToDoListState(dataList: newDataList, priority: event.priority));
  }

  FutureOr<void> _onToDoListEventOnPriorityAll(ToDoListEventOnPriorityAll event, Emitter<ToDoListState> emit) {
    List<List<Entry>> newDataList = databaseRepository.getEntries();
    emit(ToDoListState(dataList: newDataList, priority: null));
  }

  FutureOr<void> _onToDoListEventItemDone(ToDoListEventItemDone event, Emitter<ToDoListState> emit) {
    final oldToDo = event.entry;
    final newToDo = oldToDo.copyWith(isDone: true);
    databaseRepository.deleteEntry(oldToDo);
    databaseRepository.addEntry(newToDo);
    List<List<Entry>> dataList = [];
    if (state.priority == null) {
      dataList = databaseRepository.getEntries();
    } else {
      dataList = databaseRepository.getFilteredEntries(state.priority);
    }
    emit(ToDoListState(dataList: dataList, priority: state.priority));
  }

  FutureOr<void> _onToDoListEventItemUnDone(ToDoListEventItemUnDone event, Emitter<ToDoListState> emit) {
    final oldToDo = event.entry;
    final newToDo = oldToDo.copyWith(isDone: false);
    databaseRepository.deleteEntry(oldToDo);
    databaseRepository.addEntry(newToDo);
    List<List<Entry>> dataList = [];
    if (state.priority == null) {
      dataList = databaseRepository.getEntries();
    } else {
      dataList = databaseRepository.getFilteredEntries(state.priority);
    }
    emit(ToDoListState(dataList: dataList, priority: state.priority));
  }

  FutureOr<void> _onToDoListEventItemDeleted(ToDoListEventItemDeleted event, Emitter<ToDoListState> emit) {
    databaseRepository.deleteEntry(event.entry);
    List<List<Entry>> dataList = [];
    if (state.priority == null) {
      dataList = databaseRepository.getEntries();
    } else {
      dataList = databaseRepository.getFilteredEntries(state.priority);
    }
    emit(ToDoListState(dataList: dataList, priority: state.priority));
  }

  FutureOr<void> _onToDoListEventItemEdited(ToDoListEventItemEdited event, Emitter<ToDoListState> emit) {
    databaseRepository.deleteEntry(event.entryDeleted);
    databaseRepository.addEntry(event.entryAdded);
    List<List<Entry>> dataList = [];
    if (state.priority == null) {
      dataList = databaseRepository.getEntries();
    } else {
      dataList = databaseRepository.getFilteredEntries(state.priority);
    }
    emit(ToDoListState(dataList: dataList, priority: state.priority));
  }

  FutureOr<void> _onToDoListEventItemAdded(ToDoListEventItemAdded event, Emitter<ToDoListState> emit) {
    databaseRepository.addEntry(event.entry);
    List<List<Entry>> dataList = [];
    if (state.priority == null) {
      dataList = databaseRepository.getEntries();
    } else {
      dataList = databaseRepository.getFilteredEntries(state.priority);
    }
    emit(ToDoListState(dataList: dataList, priority: state.priority));
  }
}
