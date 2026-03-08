import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String body;

  const NotificationEntity({this.id = "", this.title = "", this.body = ""});

  @override
  List<Object?> get props => [id, title, body];
}
