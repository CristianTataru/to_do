part of 'to_do_list_all_page_bloc.dart';

class ToDoListState extends Equatable {
  final List<List<Entry>> dataList;
  final EntryPriority? priority;

  const ToDoListState({required this.dataList, required this.priority});

  @override
  List<Object?> get props => [dataList, priority];
}
