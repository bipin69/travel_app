import 'package:dartz/dartz.dart';
import 'package:hotel_booking/core/error/failure.dart';
import 'package:hotel_booking/features/auth/domain/entity/hotel_entity.dart';




abstract class VenueRepository {
  Future<Either<Failure, List<VenueEntity>>> getAllVenues();
  Future<Either<Failure, void>> addVenue(VenueEntity venue);
  Future<Either<Failure, void>> updateVenue(String id, VenueEntity venue);
  Future<Either<Failure, void>> deleteVenue(String id);
}
