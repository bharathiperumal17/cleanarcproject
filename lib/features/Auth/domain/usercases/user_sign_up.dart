import 'package:cleanarcproject/core/error/failures.dart';
import 'package:cleanarcproject/core/usecase/usecase.dart';
import 'package:cleanarcproject/core/user.dart';
import 'package:cleanarcproject/features/Auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRespository authRespository;
  UserSignUp(this.authRespository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRespository.signupWithEmailPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String email;
  final String name;
  final String password;

  UserSignUpParams(
      {required this.email, required this.name, required this.password});
}
