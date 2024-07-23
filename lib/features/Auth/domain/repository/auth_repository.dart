import 'package:cleanarcproject/core/error/failures.dart';
import 'package:cleanarcproject/core/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRespository {
  Future<Either<Failure, User>> signupWithEmailPassword(
      {required String name, required String email, required String password});

  Future<Either<Failure, User>> signinWithEmailPassword(
      {required String email, required String password});
}
