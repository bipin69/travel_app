// 2 unit test
// test/submit_contact_usecase_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/features/auth/domain/entity/contact_entity.dart';
import 'package:hotel_booking/features/auth/domain/repository/contact_repository.dart';
import 'package:hotel_booking/features/auth/domain/use_case/submit_contact_usecase.dart';
import 'package:mocktail/mocktail.dart';


// Create a mock for ContactRepository
class MockContactRepository extends Mock implements ContactRepository {}

void main() {
  late SubmitContactUseCase usecase;
  late MockContactRepository mockContactRepository;

  setUp(() {
    mockContactRepository = MockContactRepository();
    usecase = SubmitContactUseCase(mockContactRepository);
  });

  final tContact = ContactEntity(
    id: '',
    name: 'bibhakta',
    email: 'bibhakta@gmail.com',
    phone: '9877375322',
    message: 'Test message',
  );

  test('should return true when contact submission is successful', () async {
    // Arrange
    when(() => mockContactRepository.submitContact(tContact))
        .thenAnswer((_) async => true);

    // Act
    final result = await usecase(tContact);

    // Assert
    expect(result, true);
    verify(() => mockContactRepository.submitContact(tContact)).called(1);
    verifyNoMoreInteractions(mockContactRepository);
  });

  test('should throw an exception when contact submission fails', () async {
    // Arrange
    when(() => mockContactRepository.submitContact(tContact))
        .thenThrow(Exception('Submission failed'));

    // Act & Assert
    expect(() => usecase(tContact), throwsException);
    verify(() => mockContactRepository.submitContact(tContact)).called(1);
    verifyNoMoreInteractions(mockContactRepository);
  });
}