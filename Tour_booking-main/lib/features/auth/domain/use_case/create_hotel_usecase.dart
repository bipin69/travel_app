
import 'package:hotel_booking/features/auth/domain/entity/hotel.dart';
import 'package:hotel_booking/features/auth/domain/repository/hotel_repository_final.dart';


class AddVenueUseCase {
  final VenueRepository repository;

  AddVenueUseCase(this.repository);

  Future<Venue> call({
    required String name,
    required String location,
    required int capacity,
    required double price,
    required String description,
    required List<String> images,
  }) async {
    return await repository.addVenue(
      name: name,
      location: location,
      capacity: capacity,
      price: price,
      description: description,
      images: images,
    );
  }
}
