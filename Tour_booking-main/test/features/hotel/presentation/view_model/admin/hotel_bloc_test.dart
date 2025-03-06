import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/features/auth/domain/entity/hotel.dart';
import 'package:hotel_booking/features/dashboard1/admin_screens/view_model/hotel_bloc.dart';
import 'package:hotel_booking/features/dashboard1/admin_screens/view_model/hotel_event.dart';
import 'package:hotel_booking/features/dashboard1/admin_screens/view_model/hotel_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hotel_booking/features/auth/domain/use_case/create_hotel_usecase.dart';
import 'package:hotel_booking/features/auth/domain/use_case/delete_hotel_usecase.dart';
import 'package:hotel_booking/features/auth/domain/use_case/get_all_hotel_usecase.dart';
import 'package:hotel_booking/features/auth/domain/use_case/update_hotel_usecase.dart';

class MockGetAllVenuesUseCase extends Mock implements GetAllVenuesUseCase {}

class MockAddVenueUseCase extends Mock implements AddVenueUseCase {}

class MockUpdateVenueUseCase extends Mock implements UpdateVenueUseCase {}

class MockDeleteVenueUseCase extends Mock implements DeleteVenueUseCase {}

void main() {
  late VenueBloc venueBloc;
  late MockGetAllVenuesUseCase mockGetAllVenuesUseCase;
  late MockAddVenueUseCase mockAddVenueUseCase;
  late MockUpdateVenueUseCase mockUpdateVenueUseCase;
  late MockDeleteVenueUseCase mockDeleteVenueUseCase;

  setUp(() {
    mockGetAllVenuesUseCase = MockGetAllVenuesUseCase();
    mockAddVenueUseCase = MockAddVenueUseCase();
    mockUpdateVenueUseCase = MockUpdateVenueUseCase();
    mockDeleteVenueUseCase = MockDeleteVenueUseCase();

    venueBloc = VenueBloc(
      getAllVenuesUseCase: mockGetAllVenuesUseCase,
      addVenueUseCase: mockAddVenueUseCase,
      updateVenueUseCase: mockUpdateVenueUseCase,
      deleteVenueUseCase: mockDeleteVenueUseCase,
    );
  });

  tearDown(() {
    venueBloc.close();
  });

  ///  **Test Data**
  final testVenue = Venue(
    id: '1',
    name: 'Test Venue',
    location: 'Test City',
    capacity: 100,
    price: 500.0,
    description: 'A great venue for events',
    images: ['test_image.jpg'],
    available: true,
  );

  final List<Venue> testVenuesList = [testVenue];

  ///  Initial State**
  test("Initial state should be VenueInitial", () {
    expect(venueBloc.state, isA<VenueInitial>());
  });

  ///Load Venues Successfully
  blocTest<VenueBloc, VenueState>(
    'emits [VenueLoading, VenueLoaded] when LoadVenues is successful',
    build: () {
      when(() => mockGetAllVenuesUseCase())
          .thenAnswer((_) async => testVenuesList);
      return venueBloc;
    },
    act: (bloc) => bloc.add(LoadVenues()),
    expect: () => [
      isA<VenueLoading>(),
      isA<VenueLoaded>()
          .having((state) => state.venues, 'venues', testVenuesList),
    ],
    verify: (_) {
      verify(() => mockGetAllVenuesUseCase()).called(1);
    },
  );

  /// Fail to Load Venues
  blocTest<VenueBloc, VenueState>(
    'emits [VenueLoading, VenueError] when LoadVenues fails',
    build: () {
      when(() => mockGetAllVenuesUseCase()).thenThrow(Exception('API Failure'));
      return venueBloc;
    },
    act: (bloc) => bloc.add(LoadVenues()),
    expect: () => [
      isA<VenueLoading>(),
      isA<VenueError>()
          .having((state) => state.error, 'error', 'Exception: API Failure'),
    ],
  );
}
