//2 unit test done
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/features/auth/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/auth/domain/repository/hotel_repository.dart';

import 'package:hotel_booking/features/auth/domain/use_case/get_all_hotels_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hotel_booking/core/error/failure.dart';

/// ✅ **Mock for VenueRepository**
class MockVenueRepository extends Mock implements VenueRepository {}

void main() {
  late GetVenuesUseCase getVenuesUseCase;
  late MockVenueRepository mockVenueRepository;

  setUp(() {
    mockVenueRepository = MockVenueRepository();
    getVenuesUseCase = GetVenuesUseCase(mockVenueRepository);
  });

  ///**Test Data: Sample Venue List**
  const tVenues = [
    VenueEntity(
      id: '1',
      name: 'Grand Hall',
      location: 'Kathmandu',
      capacity: 500,
      price: 10000.0,
      description: 'A luxurious hall for grand events',
      images: ['image1.jpg', 'image2.jpg'],
      available: true,
    ),
    VenueEntity(
      id: '2',
      name: 'Sunset Garden',
      location: 'Pokhara',
      capacity: 300,
      price: 7500.0,
      description: 'An outdoor venue with a beautiful sunset view',
      images: ['image3.jpg', 'image4.jpg'],
      available: true,
    ),
  ];

  ///  **Test 1: Should return a list of venues when successful**
  test('should return a list of venues from the repository', () async {
    // Arrange
    when(() => mockVenueRepository.getVenues())
        .thenAnswer((_) async => const Right(tVenues));

    // Act
    final result = await getVenuesUseCase();

    // Assert
    expect(result, const Right(tVenues));
    verify(() => mockVenueRepository.getVenues()).called(1);
    verifyNoMoreInteractions(mockVenueRepository);
  });

  /// Test 2: Should return failure when fetching venues fails**
  test('should return Failure when fetching venues fails', () async {
    // Arrange
    final failure = ApiFailure(message: 'Failed to fetch venues', statusCode: 500);
    when(() => mockVenueRepository.getVenues()).thenAnswer((_) async => Left(failure));

    // Act
    final result = await getVenuesUseCase();

    // Assert
    expect(result, Left(failure));
    verify(() => mockVenueRepository.getVenues()).called(1);
    verifyNoMoreInteractions(mockVenueRepository);
  });


}