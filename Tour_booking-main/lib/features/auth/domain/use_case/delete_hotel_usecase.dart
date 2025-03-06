



import 'package:hotel_booking/features/auth/domain/repository/hotel_repository_final.dart';


class DeleteVenueUseCase {
  final VenueRepository repository;

  DeleteVenueUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.deleteVenue(id);
  }
}
