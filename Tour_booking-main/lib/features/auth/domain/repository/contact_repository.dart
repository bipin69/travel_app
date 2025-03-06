

import 'package:hotel_booking/features/auth/domain/entity/contact_entity.dart';


abstract class ContactRepository {
  Future<bool> submitContact(ContactEntity contact);
  Future<List<ContactEntity>> getAllContacts();
  Future<bool> deleteContact(String id);
}
