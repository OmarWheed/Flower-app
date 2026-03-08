import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app/data/models/meta_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_notifications_response_dto.g.dart';

@JsonSerializable()
class GetNotificationsResponseDTO {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "notifications")
  final List<NotificationItemDTO>? notificationsDto;

  GetNotificationsResponseDTO({
    this.message,
    this.metadata,
    this.notificationsDto,
  });

  factory GetNotificationsResponseDTO.fromJson(Map<String, dynamic> json) {
    return _$GetNotificationsResponseDTOFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetNotificationsResponseDTOToJson(this);
  }
}

@JsonSerializable()
class NotificationItemDTO with EquatableMixin {
  @JsonKey(name: "recipient")
  final String? recipient;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "body")
  final String? body;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "priority")
  final String? priority;
  @JsonKey(name: "actionLink")
  final String? actionLink;
  @JsonKey(name: "relatedId")
  final String? relatedId;
  @JsonKey(name: "relatedModel")
  final String? relatedModel;

  NotificationItemDTO({
    this.recipient,
    this.title,
    this.body,
    this.type,
    this.priority,
    this.actionLink,
    this.relatedId,
    this.relatedModel,
  });

  factory NotificationItemDTO.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemDTOFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationItemDTOToJson(this);

  @override
  List<Object?> get props => [
    recipient,
    title,
    body,
    type,
    priority,
    actionLink,
    relatedId,
    relatedModel,
  ];
}
