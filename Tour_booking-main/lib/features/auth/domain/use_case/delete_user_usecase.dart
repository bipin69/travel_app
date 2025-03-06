import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel_booking/app/usecase/usecase.dart';
import 'package:hotel_booking/core/error/failure.dart';
import 'package:hotel_booking/features/auth/domain/repository/user_repository.dart';


class DeleteUserParams extends Equatable {
  final String userId;

  const DeleteUserParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class DeleteUserUsecase implements UsecaseWithParams<void, DeleteUserParams> {
  final IUserRepository userRepository;

  DeleteUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(DeleteUserParams params) async {
    return await userRepository.deleteUser(params.userId);
  }
}
