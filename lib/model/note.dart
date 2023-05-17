import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String title;
  final String content;

  const Note(this.title, this.content);

  Note.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
      };

  @override
  List<Object?> get props => [title, content];
}
