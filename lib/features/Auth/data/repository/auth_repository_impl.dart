import 'package:cleanarcproject/core/error/exceptions.dart';
import 'package:cleanarcproject/core/error/failures.dart';
import 'package:cleanarcproject/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:cleanarcproject/core/user.dart';
import 'package:cleanarcproject/features/Auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRespositoryImpl implements AuthRespository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRespositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, User>> signinWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(
      () async => await remoteDataSource.signInEmailPassword(
          email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, User>> signupWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(
      () async => await remoteDataSource.signUpEmailPassword(
          name: name, email: email, password: password),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
