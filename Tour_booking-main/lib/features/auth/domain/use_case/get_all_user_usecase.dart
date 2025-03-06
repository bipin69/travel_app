import 'package:dartz/dartz.dart';
import 'package:hotel_booking/app/usecase/usecase.dart';
import 'package:hotel_booking/core/error/failure.dart';
import 'package:hotel_booking/features/auth/domain/entity/user_entity.dart';
import 'package:hotel_booking/features/auth/domain/repository/user_repository.dart';


class GetAllUserUsecase implements UsecaseWithoutParams<List<UserEntity>> {
  final IUserRepository userRepository;

  GetAllUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, List<UserEntity>>> call() {
    return userRepository.getAllUsers();
  }
}
