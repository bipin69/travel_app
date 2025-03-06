

import 'package:hotel_booking/features/auth/domain/entity/hotel.dart';
import 'package:hotel_booking/features/auth/domain/repository/hotel_repository_final.dart';



class GetAllVenuesUseCase {
  final VenueRepository repository;

  GetAllVenuesUseCase(this.repository);

  Future<List<Venue>> call() async {
    return await repository.getAllVenues();
  }
}
