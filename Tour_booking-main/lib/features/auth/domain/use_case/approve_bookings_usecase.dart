
import 'package:hotel_booking/features/auth/domain/entity/booking_entity.dart';


import '../repository/booking_repository.dart';

class ApproveBookingUseCase {
  final BookingRepository repository;
  ApproveBookingUseCase(this.repository);

  Future<BookingEntity> call(String bookingId) async {
    return await repository.approveBooking(bookingId);
  }
}
