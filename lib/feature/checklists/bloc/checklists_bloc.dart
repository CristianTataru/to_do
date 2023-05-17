import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/model/checklist.dart';
part 'checklists_event.dart';
part 'checklists_state.dart';

class ChecklistsBloc extends Bloc<ChecklistsEvent, ChecklistsState> {
  ChecklistsBloc()
      : super(ChecklistsState(checklists: databaseRepository.getFilteredChecklists("All"), filter: "All")) {
    on<ChecklistsEventOnFilterChanged>(_onChecklistEventOnFilterChanged);
    on<ChecklistsEventOnChecklistDeleted>(_onChecklistEventOnChecklistDeleted);
    on<ChecklistsEventOnChecklistAdded>(_onChecklistEventOnChecklistAdded);
    on<ChecklistsEventOnChecklistItemDeleted>(_onChecklistEventOnChecklistItemDeleted);
    on<ChecklistsEventOnChecklistItemAdded>(_onChecklistEventOnChecklistItemAdded);
    on<ChecklistsEventOnChecklistItemDoneUndone>(_onChecklistEventOnChecklistItemDoneUndone);
  }

  FutureOr<void> _onChecklistEventOnFilterChanged(ChecklistsEventOnFilterChanged event, Emitter<ChecklistsState> emit) {
    emit(ChecklistsState(checklists: databaseRepository.getFilteredChecklists(event.filter), filter: event.filter));
  }

  FutureOr<void> _onChecklistEventOnChecklistDeleted(
      ChecklistsEventOnChecklistDeleted event, Emitter<ChecklistsState> emit) {
    databaseRepository.deleteChecklist(event.checklist);
    emit(ChecklistsState(checklists: databaseRepository.getFilteredChecklists(state.filter), filter: state.filter));
  }

  FutureOr<void> _onChecklistEventOnChecklistAdded(
      ChecklistsEventOnChecklistAdded event, Emitter<ChecklistsState> emit) {
    databaseRepository.addChecklist(event.checklist);
    emit(ChecklistsState(checklists: databaseRepository.getFilteredChecklists(state.filter), filter: state.filter));
  }

  FutureOr<void> _onChecklistEventOnChecklistItemDeleted(
      ChecklistsEventOnChecklistItemDeleted event, Emitter<ChecklistsState> emit) {
    databaseRepository.removeChecklistItemAtIndex(event.index, event.entry);
    emit(ChecklistsState(checklists: databaseRepository.getFilteredChecklists(state.filter), filter: state.filter));
  }

  FutureOr<void> _onChecklistEventOnChecklistItemAdded(
      ChecklistsEventOnChecklistItemAdded event, Emitter<ChecklistsState> emit) {
    databaseRepository.addChecklistItemAtIndex(event.index, event.entry);
    emit(ChecklistsState(checklists: databaseRepository.getFilteredChecklists(state.filter), filter: state.filter));
  }

  FutureOr<void> _onChecklistEventOnChecklistItemDoneUndone(
      ChecklistsEventOnChecklistItemDoneUndone event, Emitter<ChecklistsState> emit) {
    databaseRepository.removeChecklistItemAtIndex(event.index, event.entry);
    databaseRepository.addChecklistItemAtIndex(event.index, event.entry.copyWith(checked: !event.entry.checked));
    emit(ChecklistsState(checklists: databaseRepository.getFilteredChecklists(state.filter), filter: state.filter));
  }
}
