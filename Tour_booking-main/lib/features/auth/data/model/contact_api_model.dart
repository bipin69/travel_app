import 'package:hotel_booking/features/auth/domain/entity/contact_entity.dart';
import 'package:json_annotation/json_annotation.dart';



part 'contact_api_model.g.dart';

@JsonSerializable()
class ContactApiModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;
  final String phone;
  final String message;

  ContactApiModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
  });

  factory ContactApiModel.fromJson(Map<String, dynamic> json) =>
      _$ContactApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContactApiModelToJson(this);

  ContactEntity toEntity() {
    return ContactEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      message: message,
    );
  }
}
