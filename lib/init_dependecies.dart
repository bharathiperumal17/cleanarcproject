import 'package:cleanarcproject/core/common/widget/cubit/app_user_cubit/appuser_cubit.dart';
import 'package:cleanarcproject/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:cleanarcproject/features/Auth/data/repository/auth_repository_impl.dart';
import 'package:cleanarcproject/features/Auth/domain/repository/auth_repository.dart';
import 'package:cleanarcproject/features/Auth/domain/usercases/user_sign_in.dart';
import 'package:cleanarcproject/features/Auth/domain/usercases/user_sign_up.dart';
import 'package:cleanarcproject/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:cleanarcproject/features/home/data/datasource/bog_remote_data_source.dart';
import 'package:cleanarcproject/features/home/data/repository/blog_rep_do.dart';
import 'package:cleanarcproject/features/home/domain/repository/blog_rep_do.dart';
import 'package:cleanarcproject/features/home/domain/usecase/upload_blog.dart';
import 'package:cleanarcproject/features/home/presentation/bloc/bloc/blog_bloc.dart';
import 'package:cleanarcproject/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependecies() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  _initAuth();
  _initblog();
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  serviceLocator.registerLazySingleton(() => FirebaseStorage.instance);
  serviceLocator.registerLazySingleton<AppuserCubit>(() => AppuserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(() =>
      AuthRemoteDataSourceImpl(
          firebaseAuth: serviceLocator<FirebaseAuth>(),
          firestore: serviceLocator<FirebaseFirestore>()));

  serviceLocator.registerFactory<AuthRespository>(
      () => AuthRespositoryImpl(serviceLocator()));

  serviceLocator
      .registerFactory<UserSignUp>(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory<UserSignIn>(
      () => UserSignIn(authRespository: serviceLocator()));

  serviceLocator.registerLazySingleton(() => AuthBloc(
      appuserCubit: serviceLocator<AppuserCubit>(),
      userSignUp: serviceLocator<UserSignUp>(),
      userSignIn: serviceLocator<UserSignIn>()));
}

void _initblog() {
  serviceLocator.registerFactory<BlogRemoteDataSource>(() =>
      BlogRemoteDataSourceImpl(
          firestore: serviceLocator<FirebaseFirestore>(),
          storage: serviceLocator<FirebaseStorage>()));

  serviceLocator.registerFactory<BlogRepositry>(() => BlogRepositryImp(
      blogRemoteDataSource: serviceLocator<BlogRemoteDataSource>()));

  serviceLocator.registerFactory<UploadBlogUsecase>(
      () => UploadBlogUsecase(blogRepositry: serviceLocator<BlogRepositry>()));

  serviceLocator.registerFactory<BlogBloc>(
      () => BlogBloc(serviceLocator<UploadBlogUsecase>()));
}
