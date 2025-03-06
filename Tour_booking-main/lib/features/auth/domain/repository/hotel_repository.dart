import 'package:dartz/dartz.dart';
import 'package:hotel_booking/core/error/failure.dart';
import 'package:hotel_booking/features/auth/data/data_source/remote_datasource/hotel_remote_datasource.dart';
import 'package:hotel_booking/features/auth/domain/entity/hotel_entity.dart';



abstract class VenueRepository {
  Future<Either<Failure, List<VenueEntity>>> getVenues();
}

class VenueRepositoryImpl implements VenueRepository {
  final VenueRemoteDataSource remoteDataSource;

  VenueRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<VenueEntity>>> getVenues() async {
    try {
      final venues = await remoteDataSource.fetchVenues();
      return Right(venues.map((venue) => venue.toEntity()).toList());
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 400));
    }
  }
}
