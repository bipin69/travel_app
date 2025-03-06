// 5 bloc test
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/features/auth/domain/entity/contact_entity.dart';
import 'package:hotel_booking/features/auth/domain/use_case/submit_contact_usecase.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/view_model/contact_bloc_view.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/view_model/contact_event.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/view_model/contact_state.dart';
import 'package:mocktail/mocktail.dart';


///  **Mock Dependencies**
class MockSubmitContactUseCase extends Mock implements SubmitContactUseCase {}

void main() {
  late ContactBlocView contactBloc;
  late MockSubmitContactUseCase mockSubmitContactUseCase;

  ///  **Set up test dependencies**
  setUp(() {
    mockSubmitContactUseCase = MockSubmitContactUseCase();
    contactBloc = ContactBlocView(mockSubmitContactUseCase);
  });

  /// **Close the bloc after tests**
  tearDown(() {
    contactBloc.close();
  });

  /// **Fake ContactEntity for testing**
  final testContact = ContactEntity(
    id: "1",
    name: "Test User",
    email: "test@example.com",
    phone: "+1234567890",
    message: "Hello, this is a test message",
  );

  /// Initial state should be ContactInitialState**
  test("Initial state should be ContactInitialState", () {
    expect(contactBloc.state, isA<ContactInitialState>());
  });

  ///Successful contact submission**
  blocTest<ContactBlocView, ContactState>(
    'should emit [ContactLoadingState, ContactSuccessState] when contact form is submitted successfully',
    build: () {
      when(() => mockSubmitContactUseCase(testContact))
          .thenAnswer((_) async => true);
      return contactBloc;
    },
    act: (bloc) => bloc.add(SubmitContactEvent(testContact)),
    expect: () => [
      isA<ContactLoadingState>(),
      isA<ContactSuccessState>(),
    ],
    verify: (_) {
      verify(() => mockSubmitContactUseCase(testContact)).called(1);
    },
  );

  /// Failed contact submission**
  blocTest<ContactBlocView, ContactState>(
    'should emit [ContactLoadingState, ContactErrorState] when contact form submission fails',
    build: () {
      when(() => mockSubmitContactUseCase(testContact))
          .thenAnswer((_) async => false);
      return contactBloc;
    },
    act: (bloc) => bloc.add(SubmitContactEvent(testContact)),
    expect: () => [
      isA<ContactLoadingState>(),
      isA<ContactErrorState>().having(
        (state) => state.message,
        'error message',
        "Failed to submit contact form",
      ),
    ],
  );

  /// Contact submission throws an exception**
  blocTest<ContactBlocView, ContactState>(
    'should emit [ContactLoadingState, ContactErrorState] when an exception occurs',
    build: () {
      when(() => mockSubmitContactUseCase(testContact))
          .thenThrow(Exception("Server Error"));
      return contactBloc;
    },
    act: (bloc) => bloc.add(SubmitContactEvent(testContact)),
    expect: () => [
      isA<ContactLoadingState>(),
      isA<ContactErrorState>().having(
        (state) => state.message,
        'error message',
        "An error occurred",
      ),
    ],
  );

  /// Multiple consecutive submissions**
  blocTest<ContactBlocView, ContactState>(
    'should emit states correctly when multiple contact form submissions happen consecutively',
    build: () {
      when(() => mockSubmitContactUseCase(testContact))
          .thenAnswer((_) async => true);
      return contactBloc;
    },
    act: (bloc) {
      bloc.add(SubmitContactEvent(testContact));
      bloc.add(SubmitContactEvent(testContact));
    },
    expect: () => [
      isA<ContactLoadingState>(),
      isA<ContactSuccessState>(),
      isA<ContactLoadingState>(),
      isA<ContactSuccessState>(),
    ],
    verify: (_) {
      verify(() => mockSubmitContactUseCase(testContact)).called(2);
    },
  );

    /// No state change when an empty contact entity is submitted**
blocTest<ContactBlocView, ContactState>(
  'should emit [] (no state change) when no event is added',
  build: () => contactBloc,
  expect: () => [],
);


}