import 'package:cleanarcproject/core/error/exceptions.dart';
import 'package:cleanarcproject/features/Auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpEmailPassword(
      {required String name, required String email, required String password});

  Future<UserModel> signInEmailPassword(
      {required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl(
      {required this.firebaseAuth, required this.firestore});

  @override
  Future<UserModel> signInEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await _storeSignInDetails(email);

      return UserModel(id: response.user!.uid, email: email, name: '');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _storeSignUpDetails(name, email, password);
      if (response.user == null) {
        throw ServerException(message: "Invalid User");
      } else {
        return UserModel(id: response.user!.uid, email: email, name: name);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> _storeSignUpDetails(
      String name, String email, String password) async {
    try {
      await firestore.collection('users').doc(email).set({
        'name': name,
        'email': email,
        'password': password,
      });
    } catch (e) {
      print("Error storing user details: $e");
    }
  }

  Future<void> _storeSignInDetails(String email) async {
    try {
      await firestore.collection('signin').doc(email).set({
        'email': email,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      print("Error storing sign-in details: $e");
    }
  }
}
