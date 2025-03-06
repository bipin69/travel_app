import 'package:dartz/dartz.dart';
import 'package:hotel_booking/core/error/failure.dart';
import 'package:hotel_booking/features/auth/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/auth/domain/repository/hotel_repository.dart';



class GetVenuesUseCase {
  final VenueRepository repository;

  GetVenuesUseCase(this.repository);

  Future<Either<Failure, List<VenueEntity>>> call() async {
    return repository.getVenues();
  }
}
