import 'package:hotel_booking/features/auth/domain/entity/contact_entity.dart';




abstract class ContactEvent {}

class SubmitContactEvent extends ContactEvent {
  final ContactEntity contact;
  SubmitContactEvent(this.contact);
}
