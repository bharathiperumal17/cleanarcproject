import 'package:cleanarcproject/core/error/failures.dart';
import 'package:cleanarcproject/core/usecase/usecase.dart';
import 'package:cleanarcproject/core/user.dart';
import 'package:cleanarcproject/features/Auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements UseCase<User, UserSignInParams> {
  final AuthRespository authRespository;
  UserSignIn({required this.authRespository});
  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await authRespository.signinWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserSignInParams {
  final String email;
  final String password;
  UserSignInParams({required this.email, required this.password});
}
