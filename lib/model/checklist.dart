import 'package:equatable/equatable.dart';

class Checklist extends Equatable {
  final String title;
  final List<ChecklistEntry> content;

  const Checklist(this.title, this.content);

  Checklist.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = (json['content'] as List).map((e) => ChecklistEntry.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
      };

  Checklist copyWith({
    String? title,
    List<ChecklistEntry>? content,
  }) {
    return Checklist(
      title ?? this.title,
      content ?? List.from(this.content),
    );
  }

  @override
  List<Object> get props => [title, content];
}

class ChecklistEntry extends Equatable {
  final String name;
  final bool checked;

  const ChecklistEntry(this.name, this.checked);

  ChecklistEntry.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        checked = json['checked'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'checked': checked,
      };

  ChecklistEntry copyWith({
    String? name,
    bool? checked,
  }) {
    return ChecklistEntry(
      name ?? this.name,
      checked ?? this.checked,
    );
  }

  @override
  List<Object> get props => [name, checked];
}
