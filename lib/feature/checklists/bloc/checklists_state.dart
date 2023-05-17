part of 'checklists_bloc.dart';

class ChecklistsState extends Equatable {
  final List<Checklist> checklists;
  final String filter;
  const ChecklistsState({required this.checklists, required this.filter});

  @override
  List<Object> get props => [checklists, filter];
}
