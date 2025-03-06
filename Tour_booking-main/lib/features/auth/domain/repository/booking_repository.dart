import 'package:hotel_booking/features/auth/domain/entity/booking_entity.dart';


abstract class BookingRepository {
  Future<BookingEntity> createBooking(String venueId);
  Future<List<BookingEntity>> getUserBookings();
  Future<List<BookingEntity>> getAllBookings();
  Future<bool> cancelBooking(String bookingId);
  Future<BookingEntity> approveBooking(String bookingId);
  Future<bool> deleteBooking(String bookingId);
}
